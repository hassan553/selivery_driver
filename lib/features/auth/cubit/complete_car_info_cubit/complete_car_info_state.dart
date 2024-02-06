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

class DriverLicensePickImageLoadingState extends CompleteCarInfoState {}

class NationalIdPickImageState extends CompleteCarInfoState {}

class NationalIdPickImageLoadingState extends CompleteCarInfoState {}

class CompleteCarInfoCategoryLoading extends CompleteCarInfoState {}

class CompleteCarInfoCategorySuccess extends CompleteCarInfoState {}

class CompleteCarInfoCategoryError extends CompleteCarInfoState {
  final String message;
  const CompleteCarInfoCategoryError(this.message);
}

class ChoiceCameraOrGalley extends CompleteCarInfoState {}

class CarPickImageState extends CompleteCarInfoState {}
class CarPickImageLoadingState extends CompleteCarInfoState {}

class PickDriverCarLicenseImageState extends CompleteCarInfoState {}
class PickDriverCarLicenseImageLoadingState extends CompleteCarInfoState {}

class CarLicensePickImageLoadingState extends CompleteCarInfoState {}

class CarLicensePickImageSuccessState extends CompleteCarInfoState {}

class CarLicensePickImageErrorState extends CompleteCarInfoState {}

////category states ///
class CategoryErrorState extends CompleteCarInfoState {
  final String message;
  CategoryErrorState(this.message);
}

class CategoryLoadingState extends CompleteCarInfoState {}

class CategorySuccessState extends CompleteCarInfoState {}

////driver license states ///
class DriverLicenseErrorState extends CompleteCarInfoState {
  final String message;
  DriverLicenseErrorState(this.message);
}

class DriverLicenseLoadingState extends CompleteCarInfoState {}

class DriverLicenseSuccessState extends CompleteCarInfoState {}

////car license states ///
class CarLicenseErrorState extends CompleteCarInfoState {
  final String message;
  CarLicenseErrorState(this.message);
}

class CarLicenseLoadingState extends CompleteCarInfoState {}

class CarLicenseSuccessState extends CompleteCarInfoState {}

////national id states ///
class NationalIdErrorState extends CompleteCarInfoState {
  final String message;
  NationalIdErrorState(this.message);
}

class NationalIdLoadingState extends CompleteCarInfoState {}

class NationalIdSuccessState extends CompleteCarInfoState {}

////car image states ///
class CarImagesErrorState extends CompleteCarInfoState {
  final String message;
  CarImagesErrorState(this.message);
}

class CarImagesLoadingState extends CompleteCarInfoState {}

class CarImagesSuccessState extends CompleteCarInfoState {}

///////get step////
class GetStepErrorState extends CompleteCarInfoState {
  final String message;
  GetStepErrorState(this.message);
}

class GetStepLoadingState extends CompleteCarInfoState {}

class GetStepSuccessState extends CompleteCarInfoState {}
