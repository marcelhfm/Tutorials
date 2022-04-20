import 'package:advisor/domain/usecases/advisor_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/advice_entity.dart';
import '../../domain/failures/failures.dart';

part 'advisor_event.dart';
part 'advisor_state.dart';

// ignore: constant_identifier_names
const GENERAL_FAILURE_MESSAGE =
    "Oops, something went wrong. Please try again later.";
// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = "Oops, Server Error. Please try again later.";

class AdvisorBloc extends Bloc<AdvisorEvent, AdvisorState> {
  final AdvisorUsecases usecases;

  AdvisorBloc({required this.usecases}) : super(AdvisorInitial()) {
    on<AdviceRequestEvent>((event, emit) async {
      emit(AdvisorStateLoading());

      Either<Failure, AdviceEntity> adviceOrFailure =
          await usecases.getAdviceUsecase();

      adviceOrFailure.fold(
        (failure) => emit(AdvisorError(message: _mapFailureToMessage(failure))),
        (advice) => emit(AdvisorStateLoaded(advice: advice.advice)),
      );
    });
  }

  String _mapFailureToMessage(failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case GeneralFailure:
        return GENERAL_FAILURE_MESSAGE;
      default:
        return GENERAL_FAILURE_MESSAGE;
    }
  }
}
