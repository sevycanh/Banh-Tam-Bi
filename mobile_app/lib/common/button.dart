import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.color, this.onTap, this.width, this.height});

  final String text;
  final Color? color;
  final void Function()? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(AppColors.primary.value),
          borderRadius: BorderRadius.circular(8)
        ),
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height * 0.065,
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: 16.sp,
              color: Color(AppColors.kLight.value),
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
