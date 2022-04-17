part of 'advisor_bloc.dart';

@immutable
abstract class AdvisorState {}

class AdvisorInitial extends AdvisorState {}

class AdvisorStateLoading extends AdvisorState {}

class AdvisorStateLoaded extends AdvisorState {
  final String advice;

  AdvisorStateLoaded({required this.advice});
}

class AdvisorError extends AdvisorState {
  final String message;

  AdvisorError({required this.message});
}
