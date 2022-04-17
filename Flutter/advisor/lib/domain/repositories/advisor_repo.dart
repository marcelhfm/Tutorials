import 'package:advisor/domain/entities/advice_entity.dart';
import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class AdvisorRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromAPI();
}
