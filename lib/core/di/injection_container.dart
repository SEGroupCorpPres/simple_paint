
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();

  // BLoC
  // sl.registerFactory<LanguageCubit>(() => LanguageCubit());
  // // sl.registerFactory<AuthBloc>(() => AuthBloc(repository: sl(), logger: sl()));
  // sl.registerFactory<GenderCubit>(() => GenderCubit());
  // sl.registerFactory<TabCubit>(() => TabCubit());
  // sl.registerFactory<WorktimeCubit>(() => WorktimeCubit());
  // sl.registerFactory<SalonPhotosCubit>(() => SalonPhotosCubit());



  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // sl.registerLazySingleton<LocationRepository>(() => LocationRepository());
  // sl.registerLazySingleton<LocationCubit>(() => LocationCubit(sl<LocationRepository>()));
  // // Asosiy Dio (API)
  // sl.registerLazySingleton<Dio>(() {
  //   final dio = Dio(
  //     BaseOptions(
  //       baseUrl: ApiConstants.baseUrl,
  //       connectTimeout: const Duration(seconds: 30),
  //       receiveTimeout: const Duration(seconds: 30),
  //       headers: const {'Content-Type': 'application/json', 'Accept': 'application/json'},
  //     ),
  //   );
  //   return dio;
  // }, instanceName: 'apiDio');
  // // Repository
  // // sl.registerLazySingleton<AuthRepository>(
  // //   () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  // // );
  // // Data sources
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSource(sl<Dio>(instanceName: 'apiDio')),
  // );
  // // sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(prefs: sl()));
  // // RefreshApi uchun plain Dio (interceptorsiz)
  // // sl.registerLazySingleton<Dio>(() => Dio()); // plain for refresh
  // sl.registerLazySingleton<RefreshApi>(() => RefreshApi(sl<Dio>()));
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

  // Endi interceptorni qo‘shamiz
  // sl<Dio>(instanceName: 'apiDio').interceptors.addAll([
  //   sl<AuthInterceptor>(),
  //   LogInterceptor(requestBody: true, responseBody: true),
  // ]);

  // Network
  // sl.registerLazySingleton<DioClient>(() => DioClient(logger: sl(), local: sl(), refreshApi: sl()));
}