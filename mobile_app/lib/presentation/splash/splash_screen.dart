import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/assets/app_image.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/presentation/application/pages/application_page.dart';
import 'package:mobile_app/presentation/onboarding/pages/onboarding_screen.dart';
import 'package:mobile_app/presentation/onboarding/widgets/page_three.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

Widget defaultScreen = const OnBoardingScreen();

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.primary.value),
      body: Center(
        child: Image.asset(AppImages.logoMain),
      ),
    );
  }
}

Future<void> redirect() async {
  await Future.delayed(const Duration(seconds: 2));

  final SharedPreferences preferences = await SharedPreferences.getInstance();

  final entryPoint = preferences.getBool('entryPoint') ?? false;
  final loggedIn = preferences.getBool('loggedIn') ?? false;

  if (entryPoint && !loggedIn){
    defaultScreen = const PageThree();
  } else if (entryPoint && loggedIn) {
    defaultScreen = const ApplicationPage();
  }

  Get.off(()=> defaultScreen);
}
