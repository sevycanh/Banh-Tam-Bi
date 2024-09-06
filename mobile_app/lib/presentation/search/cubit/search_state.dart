part of 'search_cubit.dart';

abstract class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<ProductResponse> productsList;

  SearchLoaded({required this.productsList});
}

final class SearchLoadedFailure extends SearchState {
  final String message;

  SearchLoadedFailure({required this.message});
}

final class SearchLoadedNoMoreProducts extends SearchState {}
