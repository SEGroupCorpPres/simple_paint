import 'package:simple_paint/features/features.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key, required this.controller});
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    log('balandlik: --> ${size.height -MediaQuery.of(context).padding.top - kToolbarHeight}');

    return SizedBox(
      height: size.height -MediaQuery.of(context).padding.top - kToolbarHeight,
      width: size.width,
      child: GridView.builder(
        controller: controller,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.defaultHomeImageWrapSpacing.sp,
          mainAxisSpacing: AppSizes.defaultHomeImageWrapSpacing.sp,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.defaultHomeScreenHorizontalPadding.sp,
          vertical: AppSizes.defaultHomeScreenHorizontalPadding.sp,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => index != 10 ? ImageCard(index: index): Container(height: 100,),
      ),
    );
  }
}
