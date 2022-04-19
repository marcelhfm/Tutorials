part of 'advisor_bloc.dart';

@immutable
abstract class AdvisorState {}

class AdvisorInitial extends AdvisorState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class AdvisorStateLoading extends AdvisorState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class AdvisorStateLoaded extends AdvisorState with EquatableMixin {
  @override
  List<Object> get props => [advice];
  final String advice;

  AdvisorStateLoaded({required this.advice});
}

class AdvisorError extends AdvisorState with EquatableMixin {
  @override
  List<Object> get props => [message];
  final String message;

  AdvisorError({required this.message});
}
