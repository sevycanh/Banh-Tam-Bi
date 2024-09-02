import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/assets/app_image.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

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
              height: 40.h,
            ),
            Column(
              children: [
                Text(
                  "Welcome 2",
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: Color(AppColors.kLight.value),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0.w),
                  child: Text(
                      'We help you find your dream job according to your skills, location and preference to build your career',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(AppColors.kLight.value),
                          fontWeight: FontWeight.normal)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
