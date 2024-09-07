import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/common/button.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/models/response/products/products_res.dart';

import '../../../common/app_bar.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});
  final ProductResponse product;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(widget.product.image),
                  Divider(
                    thickness: 2.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.product.name,
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(AppColors.kDark.value),
                                fontWeight: FontWeight.bold)),
                        Text(
                            "${NumberFormat("#,##0", "vi_VN").format(int.parse(widget.product.price))}đ",
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Color(AppColors.kOrange.value),
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.h),
                        Text("Mô tả: ",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Color(AppColors.kDark.value),
                                fontStyle: FontStyle.italic)),
                        Text("  ${widget.product.description}",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Color(AppColors.kDark.value),
                                fontStyle: FontStyle.italic))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CustomAppBar(
                  leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(6.h),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.kDarkGrey,
                          child: Icon(CupertinoIcons.arrow_left,
                              color: Color(
                                AppColors.kLight.value,
                              ))),
                    ),
                  ),
                  actions: _actionAppBar(),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 58.h,
        color: Color(AppColors.kLightGrey.value),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.kLight,
                        radius: 15,
                        child: Icon(Icons.remove),
                      ),
                    ),
                    Text("1", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),),
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.kLight,
                        radius: 15,
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                flex: 2,
                child: CustomButton(
                  text: "Thêm vào giỏ",
                  color: AppColors.primary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> _actionAppBar() => [
      Padding(
        padding: EdgeInsets.all(6.h),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.kDarkGrey,
          child: Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Color(AppColors.kLight.value),
                ),
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
      ),
    ];
