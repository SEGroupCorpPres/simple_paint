import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

part 'paint_event.dart';
part 'paint_state.dart';

class PaintBloc extends Bloc<PaintEvent, PaintState> {
  PaintBloc({
    required AddPaint addPaint,
    required DeletePaint removePaint,
    required EditPaint editPaint,
    required GetPaint getPaint,
    required GetPaintsList getPaints,
  }) : _addPaint = addPaint,
       _removePaint = removePaint,
       _editPaint = editPaint,
       _getPaint = getPaint,
       _getPaintsList = getPaints,
       super(InitialPaintState()) {
    on<AddPaintEvent>(_addPaintHandler);
    on<UpdatePaintEvent>(_editPaintHandler);
    on<DeletePaintEvent>(_removePaintHandler);
    on<GetPaintEvent>(_getPaintHandler);
    on<GetPaintsListEvent>(_getPaintsListHandler);
  }

  final AddPaint _addPaint;
  final DeletePaint _removePaint;
  final EditPaint _editPaint;
  final GetPaint _getPaint;
  final GetPaintsList _getPaintsList;

  Future<void> _addPaintHandler(AddPaintEvent event, Emitter<PaintState> emit) async {
    emit(LoadingPaintState());
    final result = await _addPaint(AddPaintParams(event.image, paint: event.paint));
    result.fold((failure) => emit(ErrorPaintState(error: failure.message)), (r) async {
      emit(CreatePaintState());
    });
  }

  Future<void> _removePaintHandler(DeletePaintEvent event, Emitter<PaintState> emit) async {
    emit(LoadingPaintState());
    final result = await _removePaint(DeletePaintParams(id: event.id));
    result.fold(
      (failure) => emit(ErrorPaintState(error: failure.message)),
      (_) => emit(DeletePaintState()),
    );
  }

  Future<void> _editPaintHandler(UpdatePaintEvent event, Emitter<PaintState> emit) async {
    emit(LoadingPaintState());
    final result = await _editPaint(
      EditPaintParams(id: event.id, paint: event.paint, image: event.image),
    );
    result.fold(
      (failure) => emit(ErrorPaintState(error: failure.message)),
      (_) => emit(UpdatePaintState()),
    );
  }

  Future<void> _getPaintHandler(GetPaintEvent event, Emitter<PaintState> emit) async {
    emit(LoadingPaintState());
    final result = await _getPaint(GetPaintParams(id: event.id));
    result.fold((failure) => emit(ErrorPaintState(error: failure.message)), (paint) {
      PaintModel paintModel = PaintModel.fromEntity(paint);
      emit(GetPaintState(paint: paintModel));
    });
  }

  Future<void> _getPaintsListHandler(GetPaintsListEvent event, Emitter<PaintState> emit) async {
    emit(LoadingPaintState());
    final result = await _getPaintsList();
    result.fold((failure) => emit(ErrorPaintState(error: failure.message)), (paints) {
      List<PaintModel>? paintsList = paints?.map((paint) => PaintModel.fromEntity(paint)).toList();
      if (paintsList != null) {
        emit(GetPaintsListState(paints: paintsList));
      } else {
        emit(EmptyPaintState());
      }
    });
  }
}
