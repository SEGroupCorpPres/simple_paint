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
    this.bodyMainAxisAlignment = MainAxisAlignment.start,
  });

  final List<Widget> bodyChildren;
  final List<Widget> appBarChildren;
  final Widget? bottomSheet;
  final bool? isHome;
  final ScrollController? controller;
  final MainAxisAlignment? appBarMainAxisAlignment;
  final MainAxisAlignment? bodyMainAxisAlignment;

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
              bottom: -200,
              child: BackdropFilter(
                blendMode: BlendMode.color,
                enabled: false,
                filter: ImageFilter.blur(
                  sigmaX: MediaQuery.sizeOf(context).width,
                  sigmaY:
                      MediaQuery.sizeOf(context).height -
                      MediaQuery.of(context).padding.top -
                      kToolbarHeight,
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
                if(isHome!)  Container(
                  height: MediaQuery.of(context).padding.top + kToolbarHeight,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Color(0xC4C4C4).withValues(alpha: .01),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x604490).withValues(alpha: .3),
                        blurRadius: 68,
                        spreadRadius: -64,
                        offset: Offset(0, -82.h),
                        blurStyle: BlurStyle.inner,
                      ),
                      BoxShadow(
                        color: Color(0xE3E3E3).withValues(alpha: .2),
                        blurRadius: 40,
                        spreadRadius: 0,
                        offset: Offset(0, 1),
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
                SizedBox(
                  height: isHome! ? null: size.height,
                  width: size.width,
                  child: Column(mainAxisAlignment: bodyMainAxisAlignment!, children: bodyChildren),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
