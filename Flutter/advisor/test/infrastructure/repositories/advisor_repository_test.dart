import 'package:advisor/domain/entities/advice_entity.dart';
import 'package:advisor/domain/failures/failures.dart';
import 'package:advisor/domain/repositories/advisor_repo.dart';
import 'package:advisor/infrastructure/datasources/advisor_remote_datasource.dart';
import 'package:advisor/infrastructure/exceptions/exceptions.dart';
import 'package:advisor/infrastructure/models/advice_models.dart';
import 'package:advisor/infrastructure/repositories/advisor_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advisor_repository_test.mocks.dart';

@GenerateMocks([AdvisorRemoteDatasource])
void main() {
  late AdvisorRepository repository;
  late MockAdvisorRemoteDatasource datasource;

  setUp(() {
    datasource = MockAdvisorRemoteDatasource();
    repository = AdvisorRepositoryImpl(advisorRemoteDatasource: datasource);
  });

  group("getAdviceFromAPI", () {
    // ignore: non_constant_identifier_names
    final t_AdviceModel = AdviceModel(id: 1, advice: "test");
    // ignore: non_constant_identifier_names
    final AdviceEntity t_Advice = t_AdviceModel;

    test("should return remoteData if call to remote datasource is successfull",
        () async {
      // arrange
      when(datasource.getRandomAdviceFromAPI())
          .thenAnswer((_) async => t_AdviceModel);

      // act
      final result = await repository.getAdviceFromAPI();

      // assert
      verify(datasource.getRandomAdviceFromAPI());
      expect(result, Right(t_Advice));
      verifyNoMoreInteractions(datasource);
    });

    test("should return ServerFailure if datasource throws ServerException",
        () async {
      // arrange
      when(datasource.getRandomAdviceFromAPI())
          .thenAnswer((_) async => throw (ServerException()));

      // act
      final result = await repository.getAdviceFromAPI();

      // assert
      verify(datasource.getRandomAdviceFromAPI());
      expect(result, Left(ServerFailure()));
      verifyNoMoreInteractions(datasource);
    });
  });
}
