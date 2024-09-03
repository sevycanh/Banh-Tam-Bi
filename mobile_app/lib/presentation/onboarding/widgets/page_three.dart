import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/assets/app_image.dart';
import 'package:mobile_app/presentation/auth/pages/login.dart';
import 'package:mobile_app/presentation/auth/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/outline_btn.dart';
import '../../../configs/theme/app_colors.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(AppColors.primary.value),
        child: Column(
          children: [
            SizedBox(
              height: 70.h,
            ),
            Image.asset(AppImages.logoMain),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Xin Chào Quý Khách",
              style: TextStyle(
                  fontSize: 25.sp,
                  color: Color(AppColors.kLight.value),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Text(
                "Created by SevyCanh",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(AppColors.kLight.value),
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOutlineBtn(
                  onTap: () async {
                    final SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.setBool('entryPoint', true);
                    Get.to(() => const RegisterPage());
                  },
                  text: "Đăng ký",
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.06,
                  color: Color(AppColors.kLight.value),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.06,
                    color: Color(AppColors.kLight.value),
                    child: Center(
                      child: Text(
                        "Đăng nhập",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(AppColors.kDark.value),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
                "Quên mật khẩu?",
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(AppColors.kLight.value),
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}
