// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'complete_car_info_cubit.dart';

class CompleteCarInfoState extends Equatable {
  const CompleteCarInfoState();

  @override
  List<Object> get props => [];
}

class CompleteCarInfoInitial extends CompleteCarInfoState {}

class CompleteCarInfoEmptyImage extends CompleteCarInfoState {}

class CompleteCarInfoLoading extends CompleteCarInfoState {}

class CompleteCarInfoSuccess extends CompleteCarInfoState {
  final String message;
  const CompleteCarInfoSuccess({
    required this.message,
  });
}

class CompleteCarInfoError extends CompleteCarInfoState {
  final String message;
  const CompleteCarInfoError({
    required this.message,
  });
}

class DriverLicensePickImageState extends CompleteCarInfoState {}

class NationalIdPickImageState extends CompleteCarInfoState {}

class CompleteCarInfoCategoryLoading extends CompleteCarInfoState {}

class CompleteCarInfoCategorySuccess extends CompleteCarInfoState {}

class CompleteCarInfoCategoryError extends CompleteCarInfoState {
  final String error;
  const CompleteCarInfoCategoryError(this.error);
}
class ChoiceCameraOrGalley extends CompleteCarInfoState {}

class CarPickImageState extends CompleteCarInfoState {}

class PickDriverCarLicenseImageState extends CompleteCarInfoState {}

class CarLicensePickImageLoadingState extends CompleteCarInfoState {}

class CarLicensePickImageSuccessState extends CompleteCarInfoState {}

class CarLicensePickImageErrorState extends CompleteCarInfoState {}
