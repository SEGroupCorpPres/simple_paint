import 'package:simple_paint/core/core.dart';
final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();

  // BLoC
  sl.registerFactory<LanguageCubit>(() => LanguageCubit());
  // // sl.registerFactory<AuthBloc>(() => AuthBloc(repository: sl(), logger: sl()));

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // sl.registerLazySingleton<LocationRepository>(() => LocationRepository());
  // sl.registerLazySingleton<LocationCubit>(() => LocationCubit(sl<LocationRepository>()));

  // // Repository
  // // sl.registerLazySingleton<AuthRepository>(
  // //   () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  // // );
  // // Data sources
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSource(sl<Dio>(instanceName: 'apiDio')),
  // );
  // // sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(prefs: sl()));
  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );
  sl.registerLazySingleton<Logger>(() => logger);
  // AuthInterceptor ni ulash
  // sl.registerLazySingleton<AuthInterceptor>(
  //   () => AuthInterceptor(
  //     local: sl<AuthLocalDataSource>(),
  //     refreshApi: sl<RefreshApi>(),
  //     logger: sl<Logger>(),
  //     dio: sl<Dio>(instanceName: 'apiDio'),
  //   ),
  // );

}