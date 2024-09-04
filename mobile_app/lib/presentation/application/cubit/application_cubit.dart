import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/presentation/application/cubit/application_state.dart';


class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(const ApplicationState());

  void indexPageChange(int index){
    emit(ApplicationState(index: index));
  }
}
