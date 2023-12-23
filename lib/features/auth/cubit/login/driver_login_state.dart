part of 'driver_login_cubit.dart';

class DriverLoginState extends Equatable {
  const DriverLoginState();

  @override
  List<Object> get props => [];
}

class DriverLoginInitial extends DriverLoginState {}
class DriverSendCodeToEmailState extends DriverLoginState {}


class DriverLoginLoading extends DriverLoginState {}

class DriverLoginSuccess extends DriverLoginState {
  final String message;

  const DriverLoginSuccess(this.message);
}

class DriverLoginError extends DriverLoginState {
  final String message;

  const DriverLoginError(this.message);
}
class DriverGoogleLoginLoading extends DriverLoginState {}

class DriverGoogleLoginSuccess extends DriverLoginState {}

class DriverGoogleLoginError extends DriverLoginState {
  final String message;

  const DriverGoogleLoginError(this.message);
}
