import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:mobile_app/presentation/onboarding/widgets/page_one.dart';
import 'package:mobile_app/presentation/onboarding/widgets/page_three.dart';
import 'package:mobile_app/presentation/onboarding/widgets/page_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Stack(
          children: [
            PageView(
              physics: (state is OnboardingLast)
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (value) {
                context.read<OnboardingCubit>().onPageChanged(value);
              },
              children: const [PageOne(), PageTwo(), PageThree()],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.03,
              left: 0,
              right: 0,
              child: (state is OnboardingLast)
                  ? const SizedBox.shrink()
                  : Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                            dotHeight: 12,
                            dotWidth: 12,
                            spacing: 10,
                            dotColor: Color(AppColors.kDarkGrey.value)
                                .withOpacity(0.5),
                            activeDotColor: Color(AppColors.kLight.value)),
                      ),
                    ),
            ),
            Positioned(
                child: (state is OnboardingLast)
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 30.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  pageController.jumpToPage(2);
                                },
                                child: Text(
                                  "Skip",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(AppColors.kLight.value),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.ease);
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Color(AppColors.kLight.value),
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
          ],
        );
      },
    ));
  }
}
