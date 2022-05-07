import 'package:get_it/get_it.dart';
import 'package:todo/application/auth/signupform/signupform_bloc.dart';

final sl = GetIt.I; // sl => ServiceLocator

Future<void> init() async {
  //! state management
  sl.registerFactory(() => SignupformBloc());
}
