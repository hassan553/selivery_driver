import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/image_picker.dart';
import '../../../../core/contants/api.dart';
import '../../../../core/functions/checkinternet.dart';
import '../../../../core/services/cache_storage_services.dart';
import '../../date/car_info_repo.dart';
import 'package:http/http.dart' as http;
part 'complete_car_info_state.dart';

class CompleteCarInfoCubit extends Cubit<CompleteCarInfoState> {
  final CarInfoRepo carInfoRepo;
  final PickImage _pickImage;

  CompleteCarInfoCubit(this.carInfoRepo, this._pickImage)
      : super(CompleteCarInfoInitial());

  static CompleteCarInfoCubit get(context) => BlocProvider.of(context);
  File? carImage;
  File? nationalId;
  File? carLicense;
  File? driverLicense;

  void pickDriverLicenseImage() async {
    driverLicense = await _pickImage.pickImage();
    emit(DriverLicensePickImageState());
  }

  void pickIationalIdImage() async {
    nationalId = await _pickImage.pickImage();
    emit(NationalIdPickImageState());
  }

  void pickCarImage() async {
    carImage = await _pickImage.pickImage();
    emit(CarPickImageState());
  }

  void pickDriverCarLicenseImage() async {
    carLicense = await _pickImage.pickImage();
    emit(PickDriverCarLicenseImageState());
  }

  void takeImages({
    String? model,
    String? category,
  }) async {
    if (await checkInternet()) {
      if (carImage == null ||
          driverLicense == null ||
          carLicense == null ||
          nationalId == null) {
        emit(CompleteCarInfoEmptyImage());
      } else {
        emit(CompleteCarInfoLoading());
        final result = await carInfoRepo.uploadImages(
            carImage: carImage!,
            model: model ?? '',
            driverLicense: driverLicense!,
            carLicense: carLicense!,
            nationalId: nationalId!,
            category: category ?? '');
        result.fold((l) => emit(CompleteCarInfoError(message: l)),
            (r) => emit(CompleteCarInfoSuccess(message: r)));
      }
    } else {
      emit(const CompleteCarInfoError(message: "لا يوجد اتصال بالانترنت"));
    }
  }

  List categories = [];
  Future getCategoryData() async {
    if (await checkInternet()) {
      try {
        emit(CompleteCarInfoCategoryLoading());
        var response = await http.get(Uri.parse(categoriesUrL),
            headers: authHeadersWithToken(CacheStorageServices().token));
        final result = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          categories.addAll(result['categories']);
          emit(CompleteCarInfoCategorySuccess());
        } else {
          emit(CompleteCarInfoCategoryError(result['message'].toString()));
        }
      } catch (error) {
        emit(CompleteCarInfoCategoryError(error.toString()));
      }
    } else {
      emit(const CompleteCarInfoCategoryError("لا يوجد اتصال بالانترنت"));
    }
  }
}
