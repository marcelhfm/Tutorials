import 'package:advisor/application/advisor/advisor_bloc.dart';
import 'package:advisor/domain/entities/advice_entity.dart';
import 'package:advisor/domain/failures/failures.dart';
import 'package:advisor/domain/usecases/advisor_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_bloc_test.mocks.dart';

@GenerateMocks([AdvisorUsecases])
void main() {
  late AdvisorBloc advisorBloc;
  late MockAdvisorUsecases mockAdvisorUsecases;

  setUp(() {
    mockAdvisorUsecases = MockAdvisorUsecases();
    advisorBloc = AdvisorBloc(usecases: mockAdvisorUsecases);
  });

  test("initState should be AdvisorInitial", () {
    //assert
    expect(advisorBloc.state, equals(AdvisorInitial()));
  });

  group("AdviceRequestEvent", () {
    final t_Advice = AdviceEntity(id: 1, advice: "test");
    final t_AdviceString = "test";

    test("should call usecase if event is triggered", () async {
      // Arrange
      when(mockAdvisorUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(t_Advice));

      // Act
      advisorBloc.add(AdviceRequestEvent());
      await untilCalled(mockAdvisorUsecases.getAdviceUsecase());

      //Assert
      verify(mockAdvisorUsecases.getAdviceUsecase());
      verifyNoMoreInteractions(mockAdvisorUsecases);
    });

    test("should emit loading loaded after event is triggered", () async {
      // Arrange
      when(mockAdvisorUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(t_Advice));

      // Assert later
      final expected = [
        AdvisorStateLoading(),
        AdvisorStateLoaded(advice: t_AdviceString),
      ];

      expectLater(advisorBloc.stream, emitsInOrder(expected));

      // Act
      advisorBloc.add(AdviceRequestEvent());
    });

    test("should emit loading ServerError after event is triggered", () async {
      // Arrange
      when(mockAdvisorUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(ServerFailure()));

      // Assert later
      final expected = [
        AdvisorStateLoading(),
        AdvisorError(message: SERVER_FAILURE_MESSAGE),
      ];

      expectLater(advisorBloc.stream, emitsInOrder(expected));

      // Act
      advisorBloc.add(AdviceRequestEvent());
    });

    test("should emit loading GeneralError after event is triggered", () async {
      // Arrange
      when(mockAdvisorUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(GeneralFailure()));

      // Assert later
      final expected = [
        AdvisorStateLoading(),
        AdvisorError(message: GENERAL_FAILURE_MESSAGE),
      ];

      expectLater(advisorBloc.stream, emitsInOrder(expected));

      // Act
      advisorBloc.add(AdviceRequestEvent());
    });
  });
}
