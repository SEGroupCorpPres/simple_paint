import 'package:simple_paint/core/core.dart';

class MainBtn extends StatelessWidget {
  const MainBtn({
    super.key,
    required this.size,
    required this.title,
    required this.onPressed,
    this.color,
    this.gradient,
    this.isIgnoring,
    this.titleColor,
  });

  final Size size;
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final LinearGradient? gradient;
  final bool? isIgnoring;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.defaultHomeScreenHorizontalPadding.w),
      decoration: BoxDecoration(
        gradient: color == null ? AppColors.mainGradient : null,
        color: color,
        borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius.r),
      ),
      width: size.width,
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).textButtonTheme.style!,
        child: Text(
          title.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: titleColor ?? AppColors.mainTextColor),
        ),
      ),
    );
  }
}
