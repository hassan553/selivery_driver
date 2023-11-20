part of 'complete_car_info_cubit.dart';

class CompleteCarInfoState extends Equatable {
  const CompleteCarInfoState();

  @override
  List<Object> get props => [];
}

class CompleteCarInfoInitial extends CompleteCarInfoState {}

class CompleteCarInfoLoading extends CompleteCarInfoState {}

class CompleteCarInfoSuccess extends CompleteCarInfoState {}

class CompleteCarInfoError extends CompleteCarInfoState {}

class DriverLicensePickImageState extends CompleteCarInfoState {}

class NationalIdPickImageState extends CompleteCarInfoState {}


class CarPickImageState extends CompleteCarInfoState {}
class PickDriverCarLicenseImageState extends CompleteCarInfoState {}

class CarLicensePickImageLoadingState extends CompleteCarInfoState {}

class CarLicensePickImageSuccessState extends CompleteCarInfoState {}

class CarLicensePickImageErrorState extends CompleteCarInfoState {}
