part of 'paint_bloc.dart';

abstract class PaintState extends Equatable {
  const PaintState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialPaintState extends PaintState {
  const InitialPaintState();
}

class GetPaintState extends PaintState {
  final PaintModel paint;

  const GetPaintState({required this.paint});

  @override
  List<Object?> get props => [paint];
}

class GetPaintsListState extends PaintState {
  final List<PaintModel>? paints;

  const GetPaintsListState({required this.paints});

  @override
  List<Object?> get props => [paints];
}

class UpdatePaintState extends PaintState {
  const UpdatePaintState();
}

class DeletePaintState extends PaintState {
  const DeletePaintState();
}

class CreatePaintState extends PaintState {
  const CreatePaintState();
}

class ErrorPaintState extends PaintState {
  final String error;

  const ErrorPaintState({required this.error});

  @override
  List<Object?> get props => [error];
}

class LoadingPaintState extends PaintState {
  const LoadingPaintState();
}

class PaintSuccessPaintState extends PaintState {
  const PaintSuccessPaintState();
}


class EmptyPaintState extends PaintState {
  const EmptyPaintState();
}
