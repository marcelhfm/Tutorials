import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/domain/repositories/auth_repository.dart';

part 'signupform_event.dart';
part 'signupform_state.dart';

class SignupformBloc extends Bloc<SignupformEvent, SignupformState> {
  final AuthRepository authRepository;

  SignupformBloc({required this.authRepository})
      : super(SignupformState(
            isSubmitting: false, showValidationMessages: false)) {
    on<RegisterWithEmailAndPasswordPressed>(((event, emit) {
      if (event.email == null || event.password == null) {
        emit(
            SignupformState(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(
            SignupformState(isSubmitting: true, showValidationMessages: false));
        // TODO: trigger auth
      }
    }));

    on<SignInWithEmailAndPasswordPressed>(((event, emit) {
      if (event.email == null || event.password == null) {
        emit(
            SignupformState(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(
            SignupformState(isSubmitting: true, showValidationMessages: false));
        // TODO: trigger auth
      }
    }));
  }
}
