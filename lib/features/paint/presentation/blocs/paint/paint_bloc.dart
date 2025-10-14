import 'package:bloc/bloc.dart';

import 'paint_event.dart';
import 'paint_state.dart';

class PaintBloc extends Bloc<PaintEvent, PaintState> {
  PaintBloc() : super(PaintState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<PaintState> emit) async {
    emit(state.clone());
  }
}
