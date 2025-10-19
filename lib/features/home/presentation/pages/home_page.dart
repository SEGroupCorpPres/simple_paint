import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/core.dart';
import 'package:simple_paint/features/home/home.dart';
import 'package:simple_paint/features/paint/paint.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late bool isBlank = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener}
        if (state is AuthSignedOutState) {
          toastification.show(
            context: context,
            style: ToastificationStyle.fillColored,
            title: const Text('Success'),
            description: const Text('Signed out successfully!'),
            type: ToastificationType.success,
            autoCloseDuration: const Duration(seconds: 3),
          );
          context.go(RouterNames.login);
        }
        if (state is AuthLoadingState) {
          showDialog(
            context: context,
            builder: (context) => const SimpleDialog(
              children: [Center(child: CircularProgressIndicator.adaptive())],
            ),
          );
        }
      },
      child: Material(
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
            BlocConsumer<PaintBloc, PaintState>(
              listener: (context, state) {
                if (state is CreatePaintState || state is UpdatePaintState || state is DeletePaintState) {
                  NotificationService().showNotification(title: 'Add new Image');
                }
                // TODO: implement listener
                if (state is EmptyPaintState) {
                  setState(() {
                    isBlank = true;
                  });
                }
                if (state is GetPaintsListState) {
                  setState(() {
                    isBlank = false;
                  });
                }
              },
              builder: (context, state) {
                if (state is LoadingPaintState) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height - MediaQuery.of(context).padding.top - kToolbarHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator.adaptive()],
                    ),
                  );
                } else if (state is GetPaintsListState) {
                  if (state.paints != null) {
                    return ImageGrid(controller: _scrollController, paintsList: state.paints!);
                  }
                } else if (state is EmptyPaintState) {
                  isBlank = true;
                  return SizedBox(
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
                  );
                } else if (state is ErrorPaintState) {
                  return Center(child: Text(state.error));
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
