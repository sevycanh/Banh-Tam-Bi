import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/configs/theme/app_colors.dart';
import 'package:mobile_app/presentation/home_and_product/cubit/product_cubit.dart';
import 'package:mobile_app/presentation/home_and_product/pages/product_detail.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.page, required this.categoryId});
  final int page;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProducts(categoryId, page),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else if (state is ProductLoadedFailure) {
            return Center(child: Text(state.message));
          } else if (state is ProductLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() =>
                            ProductDetailPage(product: state.products[index]));
                      },
                      child: SizedBox(
                        width: 150.w,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              state.products[index].image,
                                            ))),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  state.products[index].name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "${NumberFormat("#,##0", "vi_VN").format(int.parse(state.products[index].price))}đ",
                                  style: TextStyle(
                                      color: Color(AppColors.kOrange.value),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13.sp),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 10.w),
                  itemCount: state.products.length),
            );
          }
          return const Center(
            child: Text("Có lỗi xảy ra vui lòng thử lại sau"),
          );
        },
      ),
    );
  }
}
