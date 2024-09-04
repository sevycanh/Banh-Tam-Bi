part of 'side_dish_cubit.dart';
abstract class SideDishState {}

final class SideDishLoading extends SideDishState {}

final class SideDishLoaded extends SideDishState{
  
}

final class SideDishLoadedFailure extends SideDishState{}