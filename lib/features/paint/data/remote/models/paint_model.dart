import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

class PaintModel extends PaintEntity {
  const PaintModel({
    required super.paintId,
    super.uid,
    super.imageUrl,
    required super.created,
    required super.updated,
  });

  PaintModel.fromMap(DataMap map)
    : super(
        paintId: map['paintId'] as String,
        uid: map['uid'] as String,
        imageUrl: map['imageUrl'] as String,
        created: map['created'] as String,
        updated: map['updated'] as String,
      );

  PaintModel copyWith({
    String? paintId,
    String? uid,
    String? imageUrl,
    String? created,
    String? updated,
  }) {
    return PaintModel(
      paintId: paintId ?? this.paintId,
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  factory PaintModel.fromEntity(PaintEntity entity) {
    return PaintModel(
      paintId: entity.paintId,
      uid: entity.uid,
      imageUrl: entity.imageUrl,
      created: entity.created,
      updated: entity.updated,
    );
  }

  /// ✅ Model → Entity
  PaintEntity toEntity() {
    return PaintEntity(
      paintId: paintId,
      uid: uid,
      imageUrl: imageUrl,
      created: created,
      updated: updated,
    );
  }

  DataMap toMap() {
    return {
      'paintId': paintId,
      'uid': uid,
      'imageUrl': imageUrl,
      'created': created,
      'updated': updated,
    };
  }

  PaintModel.empty()
    : this(
        paintId: '',
        uid: '',
        imageUrl: '',
        created: DateTime.now().toIso8601String(),
        updated: DateTime.now().toIso8601String(),
      );
}
