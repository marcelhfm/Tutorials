part of 'advisor_bloc.dart';

@immutable
abstract class AdvisorEvent {}

/// Event when Button is pressed
class AdviceRequestEvent extends AdvisorEvent {}
