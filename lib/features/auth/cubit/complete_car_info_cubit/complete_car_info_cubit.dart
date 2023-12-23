import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/image_picker.dart';
import '../../date/car_info_repo.dart';
part 'complete_car_info_state.dart';

class CompleteCarInfoCubit extends Cubit<CompleteCarInfoState> {
  final CarInfoRepo carInfoRepo;
  final PickImage _pickImage;

  CompleteCarInfoCubit(this.carInfoRepo, this._pickImage)
      : super(CompleteCarInfoInitial());

  static CompleteCarInfoCubit get(context) => BlocProvider.of(context);
  String? category;
  String? model;
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
upload()async{
  await carInfoRepo.upload('asas',carLicense!);
}
  void completeCarInfo(context) async {
    final result = await carInfoRepo.uploadImage(
      carImage: carImage!,
      model: "car",
      driverLicense: driverLicense!,
      carLicense: carLicense!,
      nationalId: nationalId!,
    );
    print(result);
    print("ddd");
    if (category == null ||
        model == null ||
        carImage == null ||
        nationalId == null ||
        carLicense == null ||
        driverLicense == null) {
      // showAdaptiveDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: const Text("تنبيه"),
      //     content: const Text( 'قم بدخال الحقل الفارغ'),
      //     actions: <Widget>[
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(context).pop(); // Close the alert dialog
      //         },
      //         child:const  Text('الغاء'),
      //       ),
      //     ],
      //   )
      // );
    } else {
      print("hhh");
      emit(CompleteCarInfoLoading());
      final result = await carInfoRepo.uploadImages2(
        carImage: carImage!,
        model: model!,
        driverLicense: driverLicense!,
        carLicense: carLicense!,
        nationalId: nationalId!,
      );
      print(result);
      result.fold((l) {
        print(l.toString());
        emit(
          CompleteCarInfoError());
        },
          (r) {
        print(r.toString());
        emit(CompleteCarInfoSuccess());
          });
    }
  }
}
