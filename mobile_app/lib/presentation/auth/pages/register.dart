import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/app_bar.dart';
import 'package:mobile_app/common/button.dart';
import 'package:mobile_app/common/text_form_field.dart';
import 'package:mobile_app/configs/assets/app_image.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/models/request/auth/register_model.dart';
import 'package:mobile_app/presentation/auth/cubit/register_cubit.dart';
import 'package:mobile_app/presentation/auth/pages/login.dart';

import '../cubit/register_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _rePassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _password.dispose();
    _rePassword.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tên không được để trống';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại không được để trống';
    } else if (value.length != 10) {
      return 'Số điện thoại phải có 10 số';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    } else if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  String? _validateRePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nhập lại mật khẩu không được để trống';
    } else if (value != _password.text) {
      return 'Mật khẩu không khớp';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
            title: Image.asset(
              AppImages.logoMain,
              scale: 6,
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message),
                  backgroundColor: Color(AppColors.kOrange.value)),
                );
              } else if (state is RegisterSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Đăng ký thành công"),
                  backgroundColor: Color(AppColors.primary.value),),
                );
                Get.to(()=> const LoginPage());
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    const Text(
                      'Đăng Ký',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextField(
                      validator: _validateName,
                      controller: _name,
                      hintText: "Họ và tên",
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      validator: _validatePhone,
                      controller: _phone,
                      hintText: "Số điện thoại",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      validator: _validatePassword,
                      controller: _password,
                      hintText: "Mật khẩu",
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !(state is PasswordVisibilityChanged &&
                          state.isVisible),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          context.read<RegisterCubit>().togglePasswordVisibility();
                        },
                        child: Icon(
                          (state is PasswordVisibilityChanged &&
                                  state.isVisible)
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(AppColors.kDark.value),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      validator: _validateRePassword,
                      controller: _rePassword,
                      hintText: "Nhập lại mật khẩu",
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !(state is RePasswordVisibilityChanged &&
                          state.isVisible),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          context.read<RegisterCubit>().toggleRePasswordVisibility();
                        },
                        child: Icon(
                          (state is PasswordVisibilityChanged &&
                                  state.isVisible)
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(AppColors.kDark.value),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    (state is RegisterLoading)
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                RegisterModel model = RegisterModel(name: _name.text, phone: _phone.text, password: _password.text);
                                context.read<RegisterCubit>().register(model);
                              }
                            },
                            text: 'Đăng Ký',
                          ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=> const LoginPage());
                      },
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
