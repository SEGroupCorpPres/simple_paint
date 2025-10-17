import 'package:simple_paint/core/common/common.dart';
import 'package:simple_paint/app/app_barrels.dart';

class UserProvider extends ChangeNotifier {
  LocalUserModel? _userModel;

  LocalUserModel? get userModel => _userModel;

  void initUser(LocalUserModel? userModel) {
    if (_userModel != userModel) _userModel = userModel;
  }

  set userModel(LocalUserModel? userModel) {
    if (_userModel != userModel) {
      _userModel = userModel;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
