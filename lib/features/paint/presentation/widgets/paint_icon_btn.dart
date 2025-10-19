import 'package:simple_paint/features/features.dart';

class PaintIconBtn extends StatelessWidget {
  const PaintIconBtn({super.key, required this.svg, required this.onPressed});

  final String svg;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: AppSizes.defaultIconBtnSize,
      color: Colors.white,
      onPressed: onPressed,
      icon: SvgPicture.asset(colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn), svg),
    );
  }
}
