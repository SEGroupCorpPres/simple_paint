import 'package:simple_paint/app/data/remote/remote.dart';
import 'package:simple_paint/core/core.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    super.password,
    required super.fullName,
  });

  LocalUserModel.fromMap(DataMap map)
    : super(
        uid: map['uid'] as String,
        email: map['email'] as String,
        password: map['password'] as String?,
        fullName: map['fullName'] as String,
      );

  const LocalUserModel.empty() : this(uid: '', email: '', password: '', fullName: '');

  LocalUserModel copyWith({String? uid, String? email, String? password, String? fullName}) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
    );
  }

  DataMap toMap() {
    return {'uid': uid, 'email': email, 'password': password, 'fullName': fullName};
  }
}
