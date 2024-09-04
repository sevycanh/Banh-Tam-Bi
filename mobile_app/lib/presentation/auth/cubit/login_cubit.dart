import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/request/auth/login_model.dart';
import 'package:mobile_app/services/helpers/auth_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(LoginModel model) async {
    emit(LoginLoading());

    try {
      var response = await AuthHelper.login(model).timeout(const Duration(seconds: 10));

      if (response == true) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Đăng nhập không thành công'));
      }
    } on TimeoutException {
      emit(LoginFailure('Không thể kết nối, vui lòng thử lại!'));
    } catch (e) {
      emit(LoginFailure('Đã xảy ra lỗi: ${e.toString()}'));
    }
  }

  bool _isPasswordVisible = false;
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityChanged(_isPasswordVisible));
  }
}
