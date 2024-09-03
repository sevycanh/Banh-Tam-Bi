import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, this.title, required this.child, this.actions});

  final Widget? title;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Color(AppColors.primary.value),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: child,
        leadingWidth: 70.w,
        actions: actions,
        centerTitle: true,
        title: title ?? const Text(""));
  }
}
