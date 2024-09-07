import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/app_bar.dart';
import 'package:mobile_app/configs/assets/app_image.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/presentation/home_and_product/cubit/product_cubit.dart';
import 'package:mobile_app/presentation/home_and_product/pages/product_page.dart';
import 'package:mobile_app/presentation/home_and_product/widgets/heading_widget.dart';
import 'package:mobile_app/presentation/home_and_product/widgets/image_slider.dart';
import 'package:mobile_app/presentation/home_and_product/widgets/products.dart';
import 'package:mobile_app/presentation/search/cubit/search_cubit.dart';
import 'package:mobile_app/presentation/search/pages/search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2),
        child: CustomAppBar(
          title: Text("Kính Chào Quý Khách",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Color(AppColors.kLight.value),
                  fontWeight: FontWeight.bold)),
          leading: Image.asset(
            AppImages.logoMain,
          ),
          actions: _actionAppBar(),
          bottom: _bottomAppBar(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            const ImageSlider(),
            SizedBox(height: 15.h),
            Center(
                child: Text("Thực Đơn",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Color(AppColors.primary.value),
                        fontWeight: FontWeight.bold))),
            SizedBox(height: 10.h),
            HeadingWidget(
              text: "Món chính",
              onTap: () {
                Get.to(() => BlocProvider(
                      create: (context) => ProductCubit(),
                      child: const ProductsPage(categoryId: 1),
                    ));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const ProductsList(categoryId: 1, page: 1),
            ),
            SizedBox(height: 10.h),
            HeadingWidget(
              text: "Món phụ",
              onTap: () {
                Get.to(() => BlocProvider(
                      create: (context) => ProductCubit(),
                      child: const ProductsPage(categoryId: 2),
                    ));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const ProductsList(categoryId: 2, page: 1),
            ),
            SizedBox(height: 10.h),
            HeadingWidget(
              text: "Nước uống",
              onTap: () {
                Get.to(() => BlocProvider(
                      create: (context) => ProductCubit(),
                      child: const ProductsPage(categoryId: 3),
                    ));
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const ProductsList(categoryId: 3, page: 1),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _actionAppBar() => [
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            if (true) // Hiển thị số lượng chỉ khi lớn hơn 0
              Positioned(
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '12',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ];

PreferredSizeWidget _bottomAppBar() => PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Get.to(() => BlocProvider(
                  create: (context) => SearchCubit(),
                  child: const SearchPage(),
                ));
          },
          child: AbsorbPointer(
            child: Container(
              decoration: BoxDecoration(
                color: Color(AppColors.kLight.value),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                readOnly: true, // Đảm bảo không thể chỉnh sửa trực tiếp
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm...',
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: EdgeInsets.only(top: 10.h),
                ),
              ),
            ),
          ),
        ),
      ),
    );
