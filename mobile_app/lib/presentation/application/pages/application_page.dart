import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/presentation/application/cubit/application_cubit.dart';
import 'package:mobile_app/presentation/application/cubit/application_state.dart';

import '../widgets/application_widget.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationCubit, ApplicationState>(
      builder: (context, state) {
        return Scaffold(
          body: buildPage(state.index),
          bottomNavigationBar: Container(
            width: MediaQuery.of(context).size.width,
            height: 58.h,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.h),
                    topRight: Radius.circular(20.h)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(
                        0.1), // bòng đổ với màu xám có trong suốt 0.1
                    spreadRadius: 1, //kích thước của bóng trải rộng
                    blurRadius: 1, //độ mờ của bóng
                  )
                ]),
            child: BottomNavigationBar(
              currentIndex: state
                  .index, //thay đổi giao diện ngay chỗ item được chọn, cho biết item nào đã được chọn
              onTap: (value) {
                context.read<ApplicationCubit>().indexPageChange(value);
              },
              elevation: 0, //độ đổ bóng của bottombar so với nền
              type: BottomNavigationBarType
                  .fixed, //fix cho các item ngay hàng không bị nhảy lên khi nhấn vào từng item
              showSelectedLabels: true,
              showUnselectedLabels: false, //tắt label
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.kLightGrey,
              items: bottomTabs,
            ),
          ),
        );
      },
    );
  }
}
