import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.text, this.onTap});

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 18.sp,
                color: Color(AppColors.kDark.value),
                fontWeight: FontWeight.w600),
          ),
          GestureDetector(
              onTap: onTap,
              child: Text(
                "Xem thêm...",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(AppColors.kLightBlue.value),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic),
              ))
        ],
      ),
    );
  }
}
