import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class PaintModel extends PaintEntity {
  const PaintModel({
    required super.paintId,
     super.uid,
     super.url,
    required super.created,
    required super.updated,
  });

  PaintModel.fromMap(DataMap map)
    : super(
        paintId: map['id'] as String,
        uid: map['uid'] as String,
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
      paintId: id ?? this.paintId,
      uid: uid ?? this.uid,
      url: url ?? this.url,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  factory PaintModel.fromEntity(PaintEntity entity) {
    return PaintModel(
      paintId: entity.paintId,
      uid: entity.uid,
      url: entity.url,
      created: entity.created,
      updated: entity.updated,
    );
  }

  /// ✅ Model → Entity
  PaintEntity toEntity() {
    return PaintEntity(
      paintId: paintId,
      uid: uid,
      url: url,
      created: created,
      updated: updated,
    );
  }

  DataMap toMap() {
    return {'id': paintId, 'uid': uid, 'url': url, 'created': created, 'updated': updated};
  }

  PaintModel.empty()
    : this(paintId: '', uid: '',  url: '', created: Timestamp.now(), updated: Timestamp.now());
}
