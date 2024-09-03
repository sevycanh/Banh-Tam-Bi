import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/assets/app_image.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

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
                  "Bắt Đầu",
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
                      'Bánh tằm bì là món ăn làm từ gạo của người Việt. Đây là một món ăn có thể dùng ăn vặt hoặc ăn no đều được, phổ biến ở tỉnh miền nam như Đồng Tháp, Bạc Liêu.',
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
