import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/request/auth/login_model.dart';
import 'package:mobile_app/services/helpers/auth_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(LoginModel model) async {
    emit(LoginLoading());

    var response = await AuthHelper.login(model);

    if (response == true) {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure('Đăng nhập không thành công'));
    }
  }

  bool _isPasswordVisible = false;
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityChanged(_isPasswordVisible));
  }
}
