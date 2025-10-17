import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late bool isBlank = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    // isBlank = false;
    return Material(
      child: ScaffoldBuilderWidget(
        controller: _scrollController,
        appBarChildren: [
          InkWell(
            child: SvgPicture.asset(
              Assets.iconsBrokenLogin,
              fit: BoxFit.fitWidth,
              width: AppSizes.defaultIconSize.sp,
            ),
            onTap: () {},
          ),
          Text(AppConstants.homePageGallery.tr(), style: Theme.of(context).textTheme.titleLarge),
          !isBlank
              ? InkWell(
                  child: SvgPicture.asset(
                    Assets.iconsBoldPaintRoller,
                    width: AppSizes.defaultIconSize.sp,
                  ),
                  onTap: () {},
                )
              : InkWell(child: Container(width: AppSizes.defaultIconSize.sp)),
        ],
        bodyChildren: [
          isBlank
              ? SizedBox(
                  height: size.height - MediaQuery.of(context).padding.top - kToolbarHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SafeArea(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: AppSizes.defaultHomeScreenHorizontalPadding.w,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppColors.mainGradient,
                            borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius.r),
                          ),
                          width: size.width,
                          child: TextButton(
                            onPressed: () {},
                            style: Theme.of(context).textButtonTheme.style,
                            child: Text(AppConstants.homePageCreate.tr()),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ImageGrid(controller: _scrollController),
        ],
      ),
    );
  }
}
