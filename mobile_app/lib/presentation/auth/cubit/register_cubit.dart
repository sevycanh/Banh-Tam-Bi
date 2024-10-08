import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/request/auth/register_model.dart';
import 'package:mobile_app/services/helpers/auth_helper.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(RegisterModel model) async {
    emit(RegisterLoading());

    try {
      var response =
          await AuthHelper.register(model).timeout(const Duration(seconds: 10));

      if (response == true) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure('Đăng ký thất bại hoặc tài khoản đã tồn tại'));
      }
    } on TimeoutException {
      emit(RegisterFailure('Không thể kết nối, vui lòng thử lại!'));
    } catch (e) {
      emit(RegisterFailure('Đã xảy ra lỗi: ${e.toString()}'));
    }
  }

  bool _isPasswordVisible = false;
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityChanged(_isPasswordVisible));
  }

  bool _isRePasswordVisible = false;
  void toggleRePasswordVisibility() {
    _isRePasswordVisible = !_isRePasswordVisible;
    emit(RePasswordVisibilityChanged(_isRePasswordVisible));
  }
}
