import 'package:advisor/application/advisor/advisor_bloc.dart';
import 'package:advisor/application/theme/theme_service.dart';
import 'package:advisor/domain/repositories/advisor_repo.dart';
import 'package:advisor/domain/repositories/theme_repo.dart';
import 'package:advisor/domain/usecases/advisor_usecases.dart';
import 'package:advisor/infrastructure/datasources/advisor_remote_datasource.dart';
import 'package:advisor/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advisor/infrastructure/repositories/advisor_repo_impl.dart';
import 'package:advisor/infrastructure/repositories/theme_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs / Application Layer
  sl.registerFactory(() => AdvisorBloc(usecases: sl()));
  sl.registerLazySingleton<ThemeService>(
      () => ThemeServiceImpl(themeRepository: sl()));

  //! Use cases
  sl.registerLazySingleton(() => AdvisorUsecases(advisorRepository: sl()));

  //! Repository
  sl.registerLazySingleton<AdvisorRepository>(
      () => AdvisorRepositoryImpl(advisorRemoteDatasource: sl()));

  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositroyImpl(themeLocalDatasource: sl()));

  //! Data sources
  sl.registerLazySingleton<AdvisorRemoteDatasource>(
      () => AdvisorRemoteDatasourceImpl(client: sl()));

  sl.registerLazySingleton<ThemeLocalDatasource>(
      () => ThemeLocalDatasourceImpl(sharedPreferences: sl()));

  //! Extern
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
