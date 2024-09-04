import 'package:flutter_bloc/flutter_bloc.dart';
part 'side_dish_state.dart';

class SideDishCubit extends Cubit<SideDishState> {
  SideDishCubit() : super(SideDishLoading());
}