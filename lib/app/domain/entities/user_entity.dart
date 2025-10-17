import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
     this.password,
    required this.fullName,
  });

  const LocalUser.empty() : this(uid: '', email: '', password: '', fullName: '');

  @override
  String toString() {
    return 'LocalUser{uid: $uid, email: $email,'
        ' password: $password, fullName: $fullName';
  }

  final String uid;
  final String email;
  final String fullName;
  final String? password;

  @override
  List<Object?> get props => [uid, email, password, fullName];
}
