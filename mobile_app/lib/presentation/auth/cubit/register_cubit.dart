import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/request/auth/register_model.dart';
import 'package:mobile_app/services/helpers/auth_helper.dart';

import 'register_state.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> register(RegisterModel model) async {
    emit(RegisterLoading());

    var response = await AuthHelper.register(model);

    if (response == true) {
      emit(RegisterSuccess());
    } else {
      emit(RegisterFailure('Đăng ký thất bại hoặc tài khoản đã tồn tại'));
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
