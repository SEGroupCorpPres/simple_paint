import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/features/features.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  widgetsBinding;
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await EasyLocalization.ensureInitialized();
  await initializeDependencies();
  await Future.delayed(const Duration(seconds: 2)); // splash delay
  NotificationService().init();
  FlutterNativeSplash.remove();
  runApp(
    EasyLocalization(
      supportedLocales: SupportedLocales.all,
      path: 'assets/l10n',
      fallbackLocale: SupportedLocales.ru,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<LanguageCubit>()),
          BlocProvider(create: (context) => sl<AuthBloc>()..add(CheckIfUserIsFirstTimerEvent())),
          BlocProvider(create: (context) => sl<PaintBloc>()..add(GetPaintsListEvent())),
          BlocProvider(create: (context) => sl<ImageCubit>())
        ],
        child: MyApp(),
      ),
    ),
  );
}
