import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/home/home.dart';
import 'package:simple_paint/features/paint/paint.dart';

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key, required this.controller, required this.paintsList});

  final ScrollController controller;
  final List<PaintModel> paintsList;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
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
        itemCount: paintsList.length,
        itemBuilder: (context, index) => index <= paintsList.length
            ? ImageCard(index: index, paint: paintsList[index])
            : Container(height: 100),
      ),
    );
  }
}
