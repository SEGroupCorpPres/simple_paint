import 'package:simple_paint/core/extensions/extensions.dart';
import 'package:simple_paint/app/app_barrels.dart';
extension ContextExtentions on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get height => size.height;

  double get width => size.width;

  UserProvider get userProvider => read<UserProvider>();

  LocalUser? get currentUser => userProvider.userModel;
}
