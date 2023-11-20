import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/functions/checkinternet.dart';
import '../../date/driver_auth_repo.dart';

part 'driver_login_state.dart';

class DriverLoginCubit extends Cubit<DriverLoginState> {
  final DriverAuthRepo _driverLoginRepo;
  DriverLoginCubit(this._driverLoginRepo) : super(DriverLoginInitial());
  static DriverLoginCubit get(context) => BlocProvider.of(context);
  void login(String email, String password) async {
    if (await checkInternet()) {
      emit(DriverLoginLoading());
      final result = await _driverLoginRepo.driverLoginRepo(email, password);
      result.fold(
        (l) => emit(DriverLoginError(l)),
        (r) {
          if (r == 'LoggedIn successfully') {
            emit(DriverLoginSuccess(r));
          } else {
            emit(DriverSendCodeToEmailState());
          }
        },
      );
    } else {
      emit(const DriverLoginError("لا يوجد اتصال بالانترنت"));
    }
  }
}
