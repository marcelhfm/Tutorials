import 'package:advisor/domain/failures/failures.dart';
import 'package:advisor/domain/entities/advice_entity.dart';
import 'package:advisor/domain/repositories/advisor_repo.dart';
import 'package:advisor/infrastructure/datasources/advisor_remote_datasource.dart';
import 'package:advisor/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class AdvisorRepositoryImpl implements AdvisorRepository {
  final AdvisorRemoteDatasource advisorRemoteDatasource;

  AdvisorRepositoryImpl({required this.advisorRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromAPI() async {
    try {
      final remoteAdvice =
          await advisorRemoteDatasource.getRandomAdviceFromAPI();
      return Right(remoteAdvice);
    } catch (e) {
      if (e.runtimeType is ServerException) {
        return left(ServerFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }
}
