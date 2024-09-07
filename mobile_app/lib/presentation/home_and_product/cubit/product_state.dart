part of 'product_cubit.dart';

abstract class ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState{
  final List<ProductResponse> products;

  ProductLoaded({required this.products});

}

final class ProductLoadedFailure extends ProductState{
  final String message;

  ProductLoadedFailure({required this.message});

}