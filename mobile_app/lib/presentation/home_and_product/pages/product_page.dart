import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/common/app_bar.dart';
import 'package:mobile_app/models/response/products/products_res.dart';
import 'package:mobile_app/presentation/home_and_product/cubit/product_cubit.dart';
import 'package:mobile_app/presentation/home_and_product/pages/product_detail.dart';

import '../../../configs/theme/app_colors.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, required this.categoryId});
  final int categoryId;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isLoadingData = false;
  bool _canLoadMore = true;
  List<ProductResponse> productsList = [];
  int _page = 1;

  @override
  void initState() {
    super.initState();
    // Request focus khi trang được tạo
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(_focusNode);
    // });
    _focusNode.requestFocus();
    context.read<ProductCubit>().getProducts(widget.categoryId, _page);

    _scrollController.addListener(
      () {
        if (isLoadingData) return;
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _canLoadMore = true;

          isLoadingData = true;
          _page += 1;
          context.read<ProductCubit>().getProducts(widget.categoryId, _page);
          isLoadingData = false;
        }
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(CupertinoIcons.arrow_left),
          ),
          actions: _actionAppBar(),
          title: Text(widget.categoryId == 1
              ? "Món Chính"
              : widget.categoryId == 2
                  ? "Món Phụ"
                  : "Nước Uống", style: TextStyle(
                  fontSize: 16.sp,
                  color: Color(AppColors.kLight.value),
                  fontWeight: FontWeight.bold)),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoadedFailure) {
            return Center(child: Text(state.message));
          } else if (state is ProductLoaded) {
            if (state.products.isNotEmpty) {
              productsList.addAll(state.products);
              if (state.products.length < 6) {
                _canLoadMore = false;
              } else {
                _canLoadMore = true;
              }
            } else {
              _canLoadMore = false;
            }
          }
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                    child: GridView.builder(
                      itemCount: productsList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio:
                              0.75, // Điều chỉnh tỷ lệ để thay đổi chiều cao
                          mainAxisSpacing: 5.sp,
                          crossAxisSpacing: 5.sp),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() =>
                            ProductDetailPage(product: productsList[index]));
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                productsList[index].image,
                                              ))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    productsList[index].name,
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
                                    "${NumberFormat("#,##0", "vi_VN").format(int.parse(productsList[index].price))}đ",
                                    style: TextStyle(
                                        color: Color(AppColors.kOrange.value),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                Padding(
                    padding: EdgeInsets.all(10.h),
                    child: _canLoadMore
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(child: Text("Đã hết sản phẩm")))
              ],
            ),
          );
        },
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
