import 'package:simple_paint/core/core.dart';

class ScaffoldBuilderWidget extends StatelessWidget {
  const ScaffoldBuilderWidget({
    super.key,
    required this.appBarChildren,
    required this.bodyChildren,
    this.bottomSheet,
    this.isHome = false,
    this.controller,
    this.appBarMainAxisAlignment,
  });

  final List<Widget> bodyChildren;
  final List<Widget> appBarChildren;
  final Widget? bottomSheet;
  final bool? isHome;
  final ScrollController? controller;
  final MainAxisAlignment? appBarMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => false,
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Assets.imagesMainBg), fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: -150,
              child: BackdropFilter(
                blendMode: BlendMode.srcOver,
                filter: ImageFilter.blur(
                  sigmaX: MediaQuery.sizeOf(context).width,
                  sigmaY: MediaQuery.sizeOf(context).width,
                ),
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesMainBgShader),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).padding.top + kToolbarHeight,
                  decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4).withValues(alpha: .1),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFE3E3E3).withValues(alpha: .2),
                        blurRadius: 40,
                        spreadRadius: 0,
                        offset: Offset(0, 1.h),
                        blurStyle: BlurStyle.inner,
                      ),
                      BoxShadow(
                        color: Color(0xFF604490).withValues(alpha: .3),
                        blurRadius: 68,
                        spreadRadius: -64,
                        offset: Offset(0, -82.h),
                        blurStyle: BlurStyle.inner,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: appBarMainAxisAlignment ?? MainAxisAlignment.spaceBetween,
                    children: appBarChildren,
                  ),
                ),
                Column(children: bodyChildren),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
