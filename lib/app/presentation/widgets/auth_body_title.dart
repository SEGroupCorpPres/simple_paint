import 'package:simple_paint/core/core.dart';

class AuthBodyTitle extends StatelessWidget {
  const AuthBodyTitle({super.key, required this.title});
final String title;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          title.tr(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5)
              ..shader = AppColors.mainGradient.createShader(
                Rect.fromCenter(center: Offset(0, 0), width: 20, height: 10),
              ),
          ),
        ),
        Text(title.tr(), style: Theme.of(context).textTheme.bodyLarge!),
      ],
    );
  }
}
