part of 'driver_verify_code_cubit.dart';

 class DriverVerifyCodeState extends Equatable {
  const DriverVerifyCodeState();

  @override
  List<Object> get props => [];
}

 class DriverVerifyCodeInitial extends DriverVerifyCodeState {}

class OtpLoadingState extends DriverVerifyCodeState {}

class OtpSuccessState extends DriverVerifyCodeState {}

class OtpErrorState extends DriverVerifyCodeState {
  final String message;

  const OtpErrorState({required this.message});
}


class ResendOtpErrorState extends DriverVerifyCodeState {
  final String message;

  const ResendOtpErrorState({required this.message});
}

class ResendOtpSuccessState extends DriverVerifyCodeState {
  final String message;

  const ResendOtpSuccessState({required this.message});
}

class ResendOtpLoadingState extends DriverVerifyCodeState {}
