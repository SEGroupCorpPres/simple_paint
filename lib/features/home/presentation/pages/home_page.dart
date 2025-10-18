import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/home/home.dart';
import 'package:simple_paint/core/common/widgets/main_btn.dart';

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
    isBlank = false;
    return Material(
      child: ScaffoldBuilderWidget(
        isHome: true,
        controller: _scrollController,
        appBarChildren: [
          InkWell(
            child: SvgPicture.asset(
              Assets.iconsBrokenLogin,
              fit: BoxFit.fitWidth,
              width: AppSizes.defaultIconSize.sp,
            ),
            onTap: () {
              context.read<AuthBloc>().add(AuthSignOutEvent());
            },
          ),
          Text(AppConstants.homePageGallery.tr(), style: Theme.of(context).textTheme.titleLarge),
          !isBlank
              ? InkWell(
                  child: SvgPicture.asset(
                    Assets.iconsBoldPaintRoller,
                    width: AppSizes.defaultIconSize.sp,
                  ),
                  onTap: () {
                    context.push(RouterNames.paint, extra: {'id': null, 'isEdit': false});
                  },
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
                        child: MainBtn(
                          size: size,
                          title: AppConstants.homePageCreate,
                          onPressed: () {
                            context.push(RouterNames.paint, extra: {'id': null, 'isEdit': false});
                          },
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
