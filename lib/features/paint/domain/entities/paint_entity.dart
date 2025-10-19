import 'package:simple_paint/core/core.dart';

class PaintEntity extends Equatable {
  final String? url;
  final String paintId;
  final String? uid;
  final Timestamp created;
  final Timestamp updated;

  const PaintEntity({
    required this.paintId,
    required this.uid,
    required this.url,
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
  List<Object?> get props => [paintId, uid,  url, created, updated];
}
