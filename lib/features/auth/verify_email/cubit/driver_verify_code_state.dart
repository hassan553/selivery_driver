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

class ResendOtpState extends DriverVerifyCodeState {}
