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
import 'package:mobile_app/models/request/auth/login_model.dart';
import 'package:mobile_app/presentation/auth/cubit/login_cubit.dart';
import 'package:mobile_app/presentation/auth/pages/register.dart';

import '../../home/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
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
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message), 
                  backgroundColor: Color(AppColors.kOrange.value)),
                );
              } else if (state is LoginSuccess) {
                Get.off(()=> const HomePage());
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  const Text(
                    'Đăng Nhập',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextField(
                    controller: _phone,
                    hintText: "Số điện thoại",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    controller: _password,
                    hintText: "Mật khẩu",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !(state is PasswordVisibilityChanged &&
                        state.isVisible),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        context.read<LoginCubit>().togglePasswordVisibility();
                      },
                      child: Icon(
                        (state is PasswordVisibilityChanged && state.isVisible)
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(AppColors.kDark.value),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Quên mật khẩu?",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  (state is LoginLoading)
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          onTap: () {
                            LoginModel model = LoginModel(
                                phone: _phone.text, password: _password.text);
                            context.read<LoginCubit>().login(model);
                          },
                          text: 'Đăng Nhập',
                        ),
                  SizedBox(height: 20.h,),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=> const RegisterPage());
                    },
                    child: Text(
                      "Đăng ký",
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ), 
                  SizedBox(
                    height: 30.h,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
