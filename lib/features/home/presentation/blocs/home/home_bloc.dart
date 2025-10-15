import 'package:bloc/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState().init()) {
    on<HomeInitEvent>(_init);
  }

  void _init(HomeInitEvent event, Emitter<HomeState> emit) async {
    emit(state.clone());
  }
}
