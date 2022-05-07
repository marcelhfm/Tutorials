import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/application/auth/signupform/signupform_bloc.dart';
import 'package:todo/domain/repositories/auth_repository.dart';
import 'package:todo/infrastructure/repositories/auth_repository_impl.dart';

final sl = GetIt.I; // sl => ServiceLocator

Future<void> init() async {
  //! state management
  sl.registerFactory(() => SignupformBloc(authRepository: sl()));

  //! repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  //! extern
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);
}
