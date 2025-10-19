import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class PaintModel extends PaintEntity {
  const PaintModel({
    required super.id,
    required super.uid,
    required super.name,
    required super.url,
    required super.created,
    required super.updated,
  });

  PaintModel.fromMap(DataMap map)
    : super(
        id: map['id'] as String,
        uid: map['uid'] as String,
        name: map['name'] as String,
        url: map['url'] as String,
        created: map['created'] as Timestamp,
        updated: map['updated'] as Timestamp,
      );

  PaintModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? url,
    Timestamp? created,
    Timestamp? updated,
  }) {
    return PaintModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      url: url ?? this.url,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  factory PaintModel.fromEntity(PaintEntity entity) {
    return PaintModel(
      id: entity.id,
      uid: entity.uid,
      name: entity.name,
      url: entity.url,
      created: entity.created,
      updated: entity.updated,
    );
  }

  /// ✅ Model → Entity
  PaintEntity toEntity() {
    return PaintEntity(
      id: this.id,
      uid: uid,
      name: name,
      url: url,
      created: created,
      updated: updated,
    );
  }

  DataMap toMap() {
    return {'id': id, 'uid': uid, 'name': name, 'url': url, 'created': created, 'updated': updated};
  }

  PaintModel.empty()
    : this(id: '', uid: '', name: '', url: '', created: Timestamp.now(), updated: Timestamp.now());
}
