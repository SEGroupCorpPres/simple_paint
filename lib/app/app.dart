import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/core/common/widgets/build_app_screen_annotated_region_builder.dart';
import 'package:simple_paint/core/core.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = sl<AuthBloc>();
    final appRouter = AppRouter(authBloc: authBloc);
    return ChangeNotifierProvider(
      create: (BuildContext context) => UserProvider(),
      child: ScreenUtilInit(
        designSize: Size(
          AppSizes.defaultScreenWidth.toDouble(),
          AppSizes.defaultScreenHeight.toDouble(),
        ),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BuildAppScreenAnnotatedRegionBuilder(child: child!);
        },
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: true,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              title: 'Simple Paint',
              theme: darkTheme(context),
              routerConfig: appRouter.router,
            );
          },
        ),
      ),
    );
  }
}
