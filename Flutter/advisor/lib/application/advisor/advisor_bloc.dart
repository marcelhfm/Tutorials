import 'package:advisor/domain/usecases/advisor_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/advice_entity.dart';
import '../../domain/failures/failures.dart';

part 'advisor_event.dart';
part 'advisor_state.dart';

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
        return 'Oops, Server Error. Please try again later.';
      case GeneralFailure:
        return 'Oops, something went wrong. Please try again later.';
      default:
        return 'Oops, something went wrong. Please try again later.';
    }
  }
}
