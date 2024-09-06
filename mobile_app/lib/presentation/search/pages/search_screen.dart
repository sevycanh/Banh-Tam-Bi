import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/common/app_bar.dart';
import 'package:mobile_app/configs/assets/app_image.dart';
import 'package:mobile_app/models/response/products/products_res.dart';
import 'package:mobile_app/presentation/search/cubit/search_cubit.dart';

import '../../../configs/theme/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

    _scrollController.addListener(
      () {
        if (!_scrollController.hasClients || isLoadingData) return;
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
              
          _canLoadMore = true;

          isLoadingData = true;
          _page += 1;
          context.read<SearchCubit>().searchProducts(_controller.text, _page);
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
          title: Container(
            decoration: BoxDecoration(
              color: Color(AppColors.kLight.value),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm...',
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                contentPadding: EdgeInsets.only(top: 10.h),
              ),
              onEditingComplete: () {
                if (_controller.text != "") {
                  _focusNode.unfocus();
                  productsList.clear();
                  _page = 1;
                  context.read<SearchCubit>().searchProducts(
                      _controller.text, _page,
                      isLoadMore: false);
                }
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchInitial) {
            return Center(child: Image.asset(AppImages.searchBackground));
          } else if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchLoadedFailure) {
            return Center(child: Text(state.message));
          } else if (state is SearchLoaded) {
            if (state.productsList.isNotEmpty) {
              productsList.addAll(state.productsList);
              if (state.productsList.length < 6) {
                _canLoadMore = false;
              } else {
                _canLoadMore = true;
              }
            } else {
              _canLoadMore = false;
            }
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // CupertinoSliverRefreshControl(
              //       onRefresh: _refresh
              //   ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        0.75, // Điều chỉnh tỷ lệ để thay đổi chiều cao
                    mainAxisSpacing: 5.sp,
                    crossAxisSpacing: 5.sp,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: productsList.length,
                    (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
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
                  ),
                ),
              ),
              SliverPadding(
                  padding: EdgeInsets.all(10.h),
                  sliver: SliverToBoxAdapter(
                    child: _canLoadMore
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(child: Text("Đã hết sản phẩm")),
                  ))
            ],
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
