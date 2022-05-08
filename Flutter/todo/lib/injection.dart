import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/application/auth/authbloc/auth_bloc.dart';
import 'package:todo/application/auth/signupform/signupform_bloc.dart';
import 'package:todo/application/todos/observer/observer_bloc.dart';
import 'package:todo/domain/repositories/auth_repository.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/infrastructure/repositories/auth_repository_impl.dart';
import 'package:todo/infrastructure/repositories/todo_repository_impl.dart';

final sl = GetIt.I; // sl => ServiceLocator

Future<void> init() async {
  //? #################### auth ####################
  //! state management
  sl.registerFactory(() => SignupformBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  //! repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

  //! extern
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

  //? #################### todo ####################
  //! Bloc
  sl.registerFactory(() => ObserverBloc(todoRepository: sl()));

  //! repositories
  sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(firestore: sl()));

  //! extern
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
}
