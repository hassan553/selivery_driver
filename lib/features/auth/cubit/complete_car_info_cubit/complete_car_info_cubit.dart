import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selivery_driver/core/functions/global_function.dart';
import 'package:selivery_driver/features/auth/presentation/views/upload_driver_data_view/upload_car_image_view.dart';
import 'package:selivery_driver/features/auth/presentation/views/upload_driver_data_view/upload_national_id.dart';
import 'package:selivery_driver/features/home/views/main_view.dart';
import '../../../../../core/widgets/image_picker.dart';
import '../../../../core/contants/api.dart';
import '../../../../core/functions/checkinternet.dart';
import '../../../../core/services/cache_storage_services.dart';
import '../../date/car_info_repo.dart';
import 'package:http/http.dart' as http;

import '../../presentation/views/upload_driver_data_view/car_license_view.dart';
import '../../presentation/views/upload_driver_data_view/driver_license_view.dart';
part 'complete_car_info_state.dart';

class CompleteCarInfoCubit extends Cubit<CompleteCarInfoState> {
  final CarInfoRepo _carInfoRepo;
  final PickImage _pickImage;

  CompleteCarInfoCubit(this._carInfoRepo, this._pickImage)
      : super(CompleteCarInfoInitial());

  static CompleteCarInfoCubit get(context) => BlocProvider.of(context);
  File? carImage;
  File? nationalId;
  File? carLicense;
  File? driverLicense;

  void pickDriverLicenseImage(bool isCamera) async {
    emit(DriverLicensePickImageLoadingState());
    driverLicense = await _pickImage.pickImage(isCamera);
    emit(DriverLicensePickImageState());
  }

  void pickNationalIdImage(bool isCamera) async {
    emit(NationalIdPickImageLoadingState());
    nationalId = await _pickImage.pickImage(isCamera);
    emit(NationalIdPickImageState());
  }

  void pickCarImage(bool isCamera) async {
    emit(CarPickImageLoadingState());
    carImage = await _pickImage.pickImage(isCamera);
    emit(CarPickImageState());
  }

  void pickDriverCarLicenseImage(bool isCamera) async {
    emit(PickDriverCarLicenseImageLoadingState());
    carLicense = await _pickImage.pickImage(isCamera);
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
        final result = await _carInfoRepo.uploadImages(
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

/////////////////////
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

  uploadCategory({required String category, required String model}) async {
    emit(CategoryLoadingState());
    final result = await _carInfoRepo.uploadCategory(category, model);
    result.fold((l) {
      emit(CategoryErrorState(l));
    }, (r) {
      emit(CategorySuccessState());
      navigateOff(UploadCarImageView());
    });
  }

  step() async {
    try {
      final response = await http.get(
        openRequestUri,
        headers: authHeadersWithToken(CacheStorageServices().token),
      );
      final result = jsonDecode(response.body);
      print('message ${result['request'][0]['_id']}');
      String? res = result['request'][0]['_id'];
      return res ?? '';
    } catch (e) {
      print('message ${e.toString()}');
      return '';
    }
  }

  String id = '';
  Future getStep() async {
    emit(GetStepLoadingState());
    final result = await _carInfoRepo.getStep();
    result.fold(
      (l) {
        emit(GetStepErrorState(l));
      },
      (r) {
        print('r $r');
        id = r;
        emit(GetStepSuccessState());
      },
    );
  }

  uploadNationalId() async {
    emit(NationalIdLoadingState());
    var r = await step();
    final result = await _carInfoRepo.uploadImage(
        image: nationalId!,
        title: 'nationalId',
        uri: Uri.parse('${baseUri}request/$r/driver-id'));
    result.fold((l) {
      emit(NationalIdErrorState(l));
    }, (r) {
      emit(NationalIdSuccessState());
      navigateTo(UploadDriverLicenseView());
    });
  }

  uploadCarImage() async {
    emit(CarImagesLoadingState());
    print('id $id');
    var r = await step();
    final result = await _carInfoRepo.uploadImage(
        image: carImage!,
        title: 'carImages',
        uri: Uri.parse('${baseUri}request/$r/car-images'));
    result.fold((l) {
      emit(CarImagesErrorState(l));
    }, (r) {
      emit(CarImagesSuccessState());
      navigateTo(UploadCarLicenseView());
    });
  }

  uploadCarLicenseImage() async {
    emit(CarLicenseLoadingState());
    var r = await step();
    final result = await _carInfoRepo.uploadImage(
        image: carLicense!,
        title: 'carLicense',
        uri: Uri.parse('${baseUri}request/$r/car-license'));
    result.fold((l) {
      emit(CarLicenseErrorState(l));
    }, (r) {
      emit(CarLicenseSuccessState());
      navigateTo(UploadNationalIdView());
    });
  }

  uploadDriverCarLicenseImage() async {
    emit(DriverLicenseLoadingState());
    var r = await step();
    final result = await _carInfoRepo.uploadImage(
        image: driverLicense!,
        title: 'driverLicense',
        uri: Uri.parse('${baseUri}request/$r/driver-license'));
    result.fold((l) {
      emit(DriverLicenseErrorState(l));
    }, (r) {
      emit(DriverLicenseSuccessState());
       
      navigateTo(MainView());
    });
  }
}
