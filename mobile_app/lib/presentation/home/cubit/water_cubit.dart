import 'package:flutter_bloc/flutter_bloc.dart';

part 'water_state.dart';

class WaterCubit extends Cubit<WaterState> {
  WaterCubit() : super(WaterLoading());
}
