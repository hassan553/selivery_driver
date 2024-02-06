import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/checkinternet.dart';

import '../data_source/verify_email_repo.dart';

part 'driver_verify_code_state.dart';

class DriverVerifyCodeCubit extends Cubit<DriverVerifyCodeState> {
 final VerifyDriverEmailAddressRepo verifyEmailAddressRepo;

  DriverVerifyCodeCubit(this.verifyEmailAddressRepo) : super(DriverVerifyCodeInitial());

  static DriverVerifyCodeCubit get(context) => BlocProvider.of(context);

  void verifyEmailWithCode(String email, String code) async {
    if(await checkInternet()){
    emit(OtpLoadingState());
    final result =
        await verifyEmailAddressRepo.driverVerifyEmailCode(email, code);
    result.fold((l) =>
        emit(OtpErrorState(message:l)), (r) => emit(OtpSuccessState()));
           } else {
      emit(const OtpErrorState(message: 'لايوجد اتصال بالانترنت'));
    }
  }

  void resendEmailVerifyCode(String email) async {
    emit(ResendOtpLoadingState());
    final result = await verifyEmailAddressRepo.clientResendEmailCode(email);
    result.fold((l) => emit(ResendOtpErrorState(message: l)),
        (r) => emit(ResendOtpSuccessState(message: r)));
  }
}
