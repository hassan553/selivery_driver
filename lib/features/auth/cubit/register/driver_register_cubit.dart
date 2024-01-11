import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/checkinternet.dart';

import '../../date/driver_auth_repo.dart';
import '../../date/social_auth.dart';

part 'driver_register_state.dart';

class DriverRegisterCubit extends Cubit<DriverRegisterState> {
  final DriverAuthRepo driverRegisterRepo;
  DriverRegisterCubit(this.driverRegisterRepo) : super(DriverRegisterInitial());
  static DriverRegisterCubit get(context) => BlocProvider.of(context);
  void register(String name, String email, String password) async {
    if (await checkInternet()) {
      emit(DriverRegisterLoading());
      final result =
          await driverRegisterRepo.driverRegisterRepo(name, email, password);

      result.fold(
        (l) => emit(DriverRegisterError(l)),
        (r) => emit(DriverRegisterSuccess(r)),
      );
    } else {
      emit(const DriverRegisterError("لا يوجد اتصال بالانترنت"));
    }
  }

  void registerWithGoogle() async {
    if (await checkInternet()) {
      emit(DriverGoogleRegisterLoading());
      final result = await handleSignInWithGoogle();
      result.fold((l) {
        emit(DriverGoogleRegisterError(l));
      }, (r) {
        emit(DriverGoogleRegisterSuccess());
      });
    } else {
      emit(const DriverGoogleRegisterError("لا يوجد اتصال بالانترنت"));
    }
  }
}
