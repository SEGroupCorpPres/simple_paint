import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/paint/paint.dart';

abstract class PaintRemoteDataSource {
  const PaintRemoteDataSource();

  Future<PaintModel> getPaint({required String paintId});

  Future<List<PaintModel>> getPaintsList();

  Future<bool> addPaint({required PaintModel paint, required File image});

  Future<bool> deletePaint({required String paintId});

  Future<bool> updatePaint({required PaintModel paint, required File? image, required String paintId});
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
      PaintModel paintModel = paint.copyWith(url: downloadUrl);

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
      await _firebaseFirestore.collection('paints').doc(paintId).delete();
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
      final snapshot = await _firebaseFirestore.collection('paints').doc(paintId).get();
      return PaintModel.fromMap(snapshot.data()!);
    } on FirebaseException catch (e) {
      throw ServerException(e.message!, e.code);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<PaintModel>> getPaintsList() {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'NO_USER', message: 'User not logged in');
    final uid = user.uid;
    try {
      return _firebaseFirestore
          .collection('paints')
          .where('uid', isEqualTo: uid)
          .get()
          .then((value) => value.docs.map((e) => PaintModel.fromMap(e.data())).toList());
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
      _firebaseFirestore
          .collection('paints')
          .doc(paint.created.microsecondsSinceEpoch.toString())
          .update(paint.toMap());
      return true;
    } on FirebaseException catch (e) {
      throw ServerException(e.message!, e.code);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
