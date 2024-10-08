import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/models/response/products/products_res.dart';
import 'package:mobile_app/services/helpers/product_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future searchProducts(String key, int page, {bool isLoadMore = true}) async {
    if (!isLoadMore) {
      emit(SearchLoading());
    }

    try {
      var response = await ProductHelper.searchProducts(key, page)
          .timeout(const Duration(seconds: 15));

      emit(SearchLoaded(productsList: response));

      if (response.isEmpty && !isLoadMore) {
        emit(SearchLoadedFailure(message: "Không tìm thấy sản phẩm phù hợp"));
      }
    } on TimeoutException {
      emit(SearchLoadedFailure(message: "Có lỗi trong quá trình tìm kiếm"));
    } catch (e) {
      emit(SearchLoadedFailure(message: "Lỗi tìm kiếm sản phẩm"));
    }
  }
}
