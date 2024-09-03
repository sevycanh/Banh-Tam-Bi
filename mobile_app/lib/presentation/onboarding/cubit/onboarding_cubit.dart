import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(Onboarding());

  Future<void> onPageChanged(int page) async {
    if (page == 2) {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool('entryPoint', true);
      emit(OnboardingLast());
    } else {
      emit(Onboarding());
    }
  }
}
