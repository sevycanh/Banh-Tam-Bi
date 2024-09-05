import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/response/products/products_res.dart';
import 'package:mobile_app/services/helpers/product_helper.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());

  Future<void> getMainDish(int categoryId,int page) async {
    emit(ProductLoading());
    try {
      var response = await ProductHelper.getMainDish(categoryId, page).timeout(const Duration(seconds: 10));

      if (response.isNotEmpty) {
        emit(ProductLoaded(products: response));
      } else {
        emit(ProductLoadedFailure(message: "Không có sản phẩm nào"));
      }
    } on TimeoutException {
      emit(ProductLoadedFailure(message: "Có lỗi xảy ra vui lòng thử lại!"));
    } catch (e) {
      emit(ProductLoadedFailure(message: "Có lỗi xảy ra vui lòng thử lại!"));
    }
  }
}
