import 'package:advisor/domain/entities/advice_entity.dart';
import 'package:advisor/domain/failures/failures.dart';
import 'package:advisor/domain/repositories/advisor_repo.dart';
import 'package:advisor/domain/usecases/advisor_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advisor_usecases_test.mocks.dart';

@GenerateMocks([AdvisorRepository])
void main() {
  late AdvisorUsecases advisorUsecases;
  late MockAdvisorRepository mockAdvisorRepository;

  setUp(() {
    mockAdvisorRepository = MockAdvisorRepository();
    advisorUsecases = AdvisorUsecases(advisorRepository: mockAdvisorRepository);
  });

  group('getAdviceUsecase', () {
    // ignore: non_constant_identifier_names
    final t_Advice = AdviceEntity(id: 1, advice: "test");

    test('should return the same Advice as repo', () async {
      //arrange
      when(mockAdvisorRepository.getAdviceFromAPI())
          .thenAnswer((_) async => Right(t_Advice));

      //act
      final result = await advisorUsecases.getAdviceUsecase();

      //assert
      expect(result, Right(t_Advice));
      verify(mockAdvisorRepository.getAdviceFromAPI());
      verifyNoMoreInteractions(mockAdvisorRepository);
    });

    test('should return the same failure as repo', () async {
      //arrange
      when(mockAdvisorRepository.getAdviceFromAPI())
          .thenAnswer((_) async => Left(ServerFailure()));

      //act
      final result = await advisorUsecases.getAdviceUsecase();

      //assert
      expect(result, Left(ServerFailure()));
      verify(mockAdvisorRepository.getAdviceFromAPI());
      verifyNoMoreInteractions(mockAdvisorRepository);
    });
  });
}
