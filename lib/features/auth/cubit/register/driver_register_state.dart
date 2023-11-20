part of 'driver_register_cubit.dart';

class DriverRegisterState extends Equatable {
  const DriverRegisterState();

  @override
  List<Object> get props => [];
}

class DriverRegisterInitial extends DriverRegisterState {}

class DriverRegisterLoading extends DriverRegisterState {}

class DriverRegisterSuccess extends DriverRegisterState {
  final String message;

  const DriverRegisterSuccess(this.message);
}

class DriverRegisterError extends DriverRegisterState {
  final String message;

  const DriverRegisterError(this.message);
}
