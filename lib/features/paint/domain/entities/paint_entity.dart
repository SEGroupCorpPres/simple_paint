import 'package:simple_paint/core/core.dart';

class PaintEntity extends Equatable {
  final String? imageUrl;
  final String paintId;
  final String? uid;
  final String created;
  final String updated;

  const PaintEntity({
    required this.paintId,
    required this.uid,
    required this.imageUrl,
    required this.created,
    required this.updated,
  });

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
  @override
  // TODO: implement props
  List<Object?> get props => [paintId, uid,  imageUrl, created, updated];
}
