// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signupform_bloc.dart';

class SignupformState {
  final bool isSubmitting;
  final bool showValidationMessages;
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccess;

  SignupformState(
      {required this.isSubmitting,
      required this.showValidationMessages,
      required this.authFailureOrSuccess});

  SignupformState copyWith({
    bool? isSubmitting,
    bool? showValidationMessages,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccess,
  }) {
    return SignupformState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showValidationMessages:
          showValidationMessages ?? this.showValidationMessages,
      authFailureOrSuccess: authFailureOrSuccess ?? this.authFailureOrSuccess,
    );
  }
}
