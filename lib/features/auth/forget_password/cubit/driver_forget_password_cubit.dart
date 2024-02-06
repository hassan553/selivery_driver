import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/checkinternet.dart';
import '../data/forgetpassword_repo.dart';

part 'driver_forget_password_state.dart';

class DriverForgetPasswordCubit extends Cubit<DriverForgetPasswordState> {
  final DriverForgetPasswordRepo _driverForgetPasswordRepo;

  DriverForgetPasswordCubit(this._driverForgetPasswordRepo)
      : super(DriverForgetPasswordInitial());

  static DriverForgetPasswordCubit get(context) => BlocProvider.of(context);

  void sendEmail(String email) async {
    if (await checkInternet()) {
      emit(ForgetPasswordLoadingState());
      final result = await _driverForgetPasswordRepo
          .sendForgetPasswordVerificationCodeToEmail(email);
      result.fold((l) => emit(ForgetPasswordErrorState(message: l)),
          (r) => emit(ForgetPasswordSuccessState()));
    } else {
      emit(const ForgetPasswordErrorState(message: "لا يوجد اتصال بالانترنت"));
    }
  }

  
   void reSendForgetPasswordVerificationCodeToEmail(String email) async {
    emit(ReSendForgetPasswordVerificationCodeToEmailLoadingState());
    final result = await _driverForgetPasswordRepo
        .reSendForgetPasswordVerificationCodeToEmail(email);
    result.fold(
      (l) => emit(
          ReSendForgetPasswordVerificationCodeToEmailErrorState(message: l)),
      (r) => emit(ReSendForgetPasswordVerificationCodeToEmailState(message: r)),
    );
  }

  void verifyEmailWithCode(String email, int code) async {
    if (await checkInternet()) {
      emit(ForgetPasswordOTPCodeLoadingState());
      final result = await _driverForgetPasswordRepo
          .verifyClientForgetPasswordCode(email, code);
      result.fold((l) => emit(ForgetPasswordOTPErrorState(message: l)),
          (r) => emit(ForgetPasswordOTPSuccessState()));
    } else {
      emit(const ForgetPasswordOTPErrorState(
          message: "لا يوجد اتصال بالانترنت"));
    }
  }

  void newPassword(String password) async {
    if (await checkInternet()) {
      emit(NewForgetPasswordLoadingState());
      final result = await _driverForgetPasswordRepo.sentNewPassword(password);
      result.fold((l) => emit(NewForgetPasswordErrorState(message: l)),
          (r) => emit(NewForgetPasswordSuccessState()));
    } else {
      emit(const NewForgetPasswordErrorState(
          message: "لا يوجد اتصال بالانترنت"));
    }
  }
}
