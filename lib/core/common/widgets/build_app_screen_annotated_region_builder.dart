import 'package:simple_paint/core/core.dart';
class BuildAppScreenAnnotatedRegionBuilder extends StatelessWidget {
  const BuildAppScreenAnnotatedRegionBuilder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
      child: child,
    );
  }
}
