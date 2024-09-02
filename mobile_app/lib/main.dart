import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/presentation/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banh Tam Decade',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(AppColors.kLight.value),
        iconTheme: IconThemeData(color: Color(AppColors.kLight.value)),
        primaryColor: Color(AppColors.primary.value),
        // appBarTheme:
        //     const AppBarTheme(elevation: 0, backgroundColor: Colors.white),
      ),
      home: SplashScreen(),
    );
  }
}
