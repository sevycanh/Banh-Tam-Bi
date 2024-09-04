
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_app/common/app_bar.dart';

import '../../configs/theme/app_colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Request focus khi trang được tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
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
              ),
            ),
        ),
      ),
      body: Container(),
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