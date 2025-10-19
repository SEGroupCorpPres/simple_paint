part of 'paint_bloc.dart';

abstract class PaintEvent extends Equatable {
  const PaintEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends PaintEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPaintEvent extends PaintEvent {
  final PaintModel paint;
  final File image;

  const AddPaintEvent({required this.paint, required this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [paint, image];
}

class DeletePaintEvent extends PaintEvent {
  final String id;

  const DeletePaintEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class UpdatePaintEvent extends PaintEvent {
  final PaintModel paint;
  final String id;
  final File? image;

  const UpdatePaintEvent({required this.paint, required this.id, required this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [paint, id, image];
}

class GetPaintEvent extends PaintEvent {
  final String id;

  const GetPaintEvent({required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class GetPaintsListEvent extends PaintEvent {
  const GetPaintsListEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorPaintEvent extends PaintEvent {
  final String message;

  const ErrorPaintEvent({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
