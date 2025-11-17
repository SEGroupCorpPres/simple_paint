import 'package:simple_paint/app/data/remote/remote.dart';
import 'package:simple_paint/core/core.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<LocalUserModel> signIn({required String email, required String password});

  Future<void> signUp({required String email, required String password, required String fullName});

  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
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
  Future<LocalUserModel> signIn({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw const ServerException('Please try again later', '505');
      }
      var userData = await _getUserData(user.uid);
      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }
      userData = await _getUserData(user.uid);
      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Error Occurred', e.code);
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(e.toString(), 505);
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      // check user already exists
      var userData = await _firebaseFirestore
          .collection('users')
          .where('email', isEqualTo: email).limit(1)
          .get();
      if (userData.docs.isNotEmpty) {
        throw const ServerException('User already exists', '409');
      }
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(fullName);
      userCredential.user!.reload();
      await _setUserData(_firebaseAuth.currentUser!, email).catchError((value) {
        log(value.toString());
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Error Occurred', e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(e.toString(), 505);
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  Future<DocumentSnapshot<DataMap>> _getUserData(String id) async {
    return _firebaseFirestore.collection('users').doc(id).get();
  }

  Future<void> _setUserData(User user, String fallbackEmail) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallbackEmail,
            fullName: user.displayName ?? 'User',
          ).toMap(),
        );
  }
}
