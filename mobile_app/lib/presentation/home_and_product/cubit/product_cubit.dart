import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/response/products/products_res.dart';
import 'package:mobile_app/services/helpers/product_helper.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());

  Future getProducts(int categoryId, int page, {bool isLoadMore = true}) async {
    if (!isLoadMore) {
      emit(ProductLoading());
    }
    try {
      var response = await ProductHelper.getProducts(categoryId, page)
          .timeout(const Duration(seconds: 10));
      emit(ProductLoaded(products: response));
      if (response.isEmpty && !isLoadMore) {
        emit(ProductLoadedFailure(message: "Không tìm thấy sản phẩm phù hợp"));
      }
    } on TimeoutException {
      emit(ProductLoadedFailure(message: "Có lỗi xảy ra vui lòng thử lại!"));
    } catch (e) {
      emit(ProductLoadedFailure(message: "Có lỗi xảy ra vui lòng thử lại!"));
    }
  }
}
