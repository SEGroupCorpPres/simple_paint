import 'package:simple_paint/core/core.dart';

class PaintEntity extends Equatable {
  final String url;
  final String name;
  final String id;
  final String uid;
  final Timestamp created;
  final Timestamp updated;

  const PaintEntity({
    required this.id,
    required this.uid,
    required this.name,
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
  List<Object?> get props => [id, uid, name, url, created, updated];
}
