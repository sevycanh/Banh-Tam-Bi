part of 'main_dish_cubit.dart';

abstract class MainDishState {}

final class MainDishLoading extends MainDishState {}

final class MainDishLoaded extends MainDishState{
  
}

final class MainDishLoadedFailure extends MainDishState{}