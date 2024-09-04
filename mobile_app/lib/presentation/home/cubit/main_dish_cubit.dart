import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_dish_state.dart';

class MainDishCubit extends Cubit<MainDishState> {
  MainDishCubit() : super(MainDishLoading());
}
