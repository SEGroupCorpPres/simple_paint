import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

abstract class PaintRemoteDataSource {
  const PaintRemoteDataSource();

  Future<PaintModel> getPaint({required String paintId});

  Future<List<PaintModel>?> getPaintsList();

  Future<bool> addPaint({required PaintModel paint, required File image});

  Future<bool> deletePaint({required String paintId});

  Future<bool> updatePaint({
    required PaintModel paint,
    required File? image,
    required String paintId,
  });
}

class PaintRemoteDataSourceImpl implements PaintRemoteDataSource {
  const PaintRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore,
       _firebaseStorage = firebaseStorage;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  @override
  Future<bool> addPaint({required PaintModel paint, required File image}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'NO_USER', message: 'User not logged in');
    final uid = user.uid;
    try {
      final ref = _firebaseStorage.ref();
      final uploadTask = ref
          .child('paints/$uid/${paint.created.microsecondsSinceEpoch}')
          .putFile(image);
      final snapshot = await uploadTask;

      final downloadUrl = await snapshot.ref.getDownloadURL();
      PaintModel paintModel = paint.copyWith(uid: uid, url: downloadUrl);

      await _firebaseFirestore.collection('paints').add(paintModel.toMap());
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Unknown error', e.code);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<bool> deletePaint({required String paintId}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'NO_USER', message: 'User not logged in');
    final uid = user.uid;
    try {
      await _firebaseStorage.ref('paints/$uid/$paintId').delete();
      final snapshot = await _firebaseFirestore
          .collection('paints')
          .where(('id'), isEqualTo: paintId)
          .get();
      if (!snapshot.docs.first.exists) throw Exception('Paint not found');
      final docId = snapshot.docs.first.id;
      await _firebaseFirestore.collection('paints').doc(docId).delete();
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(e.message!, e.code);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<PaintModel> getPaint({required String paintId}) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('paints')
          .where(('id'), isEqualTo: paintId)
          .get();
      return PaintModel.fromMap(snapshot.docs.first.data());
    } on FirebaseException catch (e) {
      throw ServerException(e.message!, e.code);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<PaintModel>?> getPaintsList() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'NO_USER', message: 'User not logged in');
    final uid = user.uid;
    try {
      final snapshot = await _firebaseFirestore
          .collection('paints')
          .where('uid', isEqualTo: uid)
          .get();
      if (snapshot.docs.isEmpty) return null;
      return snapshot.docs.map((e) => PaintModel.fromMap(e.data())).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message!, e.code);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<bool> updatePaint({
    required PaintModel paint,
    required File? image,
    required String paintId,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw FirebaseAuthException(code: 'NO_USER', message: 'User not logged in');
      final uid = user.uid;
      if (image != null) {
        // 1. Eski faylni o‘chirish
        final oldDoc = await _firebaseFirestore
            .collection('paints')
            .where(('id'), isEqualTo: paintId)
            .get();
        if (oldDoc.docs.first.exists) throw Exception('Paint not found');
        final oldUrl = oldDoc.docs.first['url'] as String;

        await _firebaseStorage.refFromURL(oldUrl).delete();

        // 2. Yangi faylni yuklash
        final newRef = _firebaseStorage.ref('paints/$uid/$paintId');
        final uploadTask = await newRef.putFile(image);
        final newUrl = await newRef.getDownloadURL();

        // 3. Firestore’ni yangilash
        await _firebaseFirestore.collection('paints').doc(paintId).update({
          'url': newUrl,
          'updatedAt': DateTime.now().toIso8601String(),
        });
      } else {
        await _firebaseFirestore.collection('paints').doc(paintId).update(paint.toMap());
      }
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(e.message!, e.code);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
