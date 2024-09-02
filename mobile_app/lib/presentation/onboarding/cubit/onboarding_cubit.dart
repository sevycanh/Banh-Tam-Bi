
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(Onboarding());

  Future<void> onPageChanged(int page) async {
    if (page == 2){
      emit(OnboardingLast());
    } else {
      emit(Onboarding());
    }
  }
}
