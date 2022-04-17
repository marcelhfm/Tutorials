import 'package:advisor/application/advisor/advisor_bloc.dart';
import 'package:advisor/domain/repositories/advisor_repo.dart';
import 'package:advisor/domain/usecases/advisor_usecases.dart';
import 'package:advisor/infrastructure/datasources/advisor_remote_datasource.dart';
import 'package:advisor/infrastructure/repositories/advisor_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Blocs
  sl.registerFactory(() => AdvisorBloc(usecases: sl()));

  //! Use cases
  sl.registerLazySingleton(() => AdvisorUsecases(advisorRepository: sl()));

  //! Repository
  sl.registerLazySingleton<AdvisorRepository>(
      () => AdvisorRepositoryImpl(advisorRemoteDatasource: sl()));

  //! Data sources
  sl.registerLazySingleton<AdvisorRemoteDatasource>(
      () => AdvisorRemoteDatasourceImpl(client: sl()));

  //! Extern
  sl.registerLazySingleton(() => http.Client());
}
