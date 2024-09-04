import 'package:flutter/material.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, this.title, this.leading, this.actions, this.bottom});

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Color(AppColors.primary.value),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: leading,
        actions: actions,
        centerTitle: true,
        bottom: bottom,
        title: title ?? const Text(""));
  }
}
