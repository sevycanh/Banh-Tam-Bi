import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/presentation/application/cubit/application_cubit.dart';
import 'package:mobile_app/presentation/auth/cubit/login_cubit.dart';
import 'package:mobile_app/presentation/auth/cubit/register_cubit.dart';
import 'package:mobile_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:mobile_app/presentation/splash/splash_screen.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => OnboardingCubit()),
    BlocProvider(create: (context) => LoginCubit()),
    BlocProvider(create: (context) => RegisterCubit()),
    BlocProvider(create: (context) => ApplicationCubit())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Banh Tam Decade',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(AppColors.kLight.value),
          iconTheme: IconThemeData(color: Color(AppColors.kLight.value)),
          primaryColor: Color(AppColors.primary.value),
          // appBarTheme:
          //     const AppBarTheme(elevation: 0, backgroundColor: Colors.white),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
