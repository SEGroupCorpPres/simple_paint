import 'package:simple_paint/app/app_barrels.dart';
import 'package:simple_paint/features/features.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  // BLoC

  sl.registerFactory<LanguageCubit>(() => LanguageCubit());
  sl.registerFactory<ImageCubit>(() => ImageCubit());
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl
    ..registerFactory<NetworkCubit>(() => NetworkCubit(sl()))
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton<Connectivity>(() => Connectivity());

  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        signOut: sl(),
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => SignOut(sl()))
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImp(sl(), sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: sl(),
        firebaseFirestore: sl(),
        firebaseStorage: sl(),
      ),
    )
    ..registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImp(sl()))
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
  sl
    ..registerFactory<PaintBloc>(
      () => PaintBloc(
        addPaint: sl(),
        editPaint: sl(),
        removePaint: sl(),
        getPaint: sl(),
        getPaints: sl(),
      ),
    )
    ..registerLazySingleton(() => AddPaint(sl()))
    ..registerLazySingleton(() => EditPaint(sl()))
    ..registerLazySingleton(() => DeletePaint(sl()))
    ..registerLazySingleton(() => GetPaint(sl()))
    ..registerLazySingleton(() => GetPaintsList(sl()))
    ..registerLazySingleton<PaintRepository>(() => PaintRepositoryImpl(sl(), sl()))
    ..registerLazySingleton<PaintRemoteDataSource>(
      () => PaintRemoteDataSourceImpl(
        firebaseAuth: sl(),
        firebaseFirestore: sl(),
        firebaseStorage: sl(),
      ),
    )
    ..registerLazySingleton<PaintLocalDataSource>(() => PaintLocalDataSourceImpl(sl()))
    ..registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

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
}
