import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/presentation/home_and_product/pages/home_page.dart';

Widget buildPage(int index) {
  List widgets = [
    const HomePage(),
    Center(
      child: Text("Đơn hàng"),
    ),
    Center(
      child: Text("Liên hệ"),
    ),
    Center(
      child: Text("Tài khoản"),
    ),
  ];
  return widgets[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: "Trang chủ",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/home.png"),
      ),
      activeIcon: SizedBox(
        //đổi màu icon khi nhấn
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/home.png",
          color: AppColors.primary,
        ),
      )),
  BottomNavigationBarItem(
      label: "Đơn hàng",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/order.png", color: AppColors.kDarkGrey,),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/order.png",
          color: AppColors.primary,
        ),
      )),
  BottomNavigationBarItem(
      label: "Liên hệ",
      icon: SizedBox(
        width: 30.w,
        height: 30.h,
        child: Image.asset("assets/icons/customer-service.png", color: AppColors.kDarkGrey,),
      ),
      activeIcon: SizedBox(
        width: 25.w,
        height: 25.h,
        child: Image.asset(
          "assets/icons/customer-service.png",
          color: AppColors.primary,
        ),
      )),
  BottomNavigationBarItem(
      label: "Tài khoản",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/person2.png"),
      ),
      activeIcon: SizedBox(
        width: 15.w,
        height: 15.h,
        child: Image.asset(
          "assets/icons/person2.png",
          color: AppColors.primary,
        ),
      )),
];
