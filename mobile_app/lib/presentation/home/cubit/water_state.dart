part of 'water_cubit.dart';

abstract class WaterState {}

final class WaterLoading extends WaterState {}

final class WaterLoaded extends WaterState{
  
}

final class WaterLoadedFailure extends WaterState{}