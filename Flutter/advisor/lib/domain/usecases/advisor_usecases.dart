import 'package:advisor/domain/entities/advice_entity.dart';
import 'package:advisor/domain/repositories/advisor_repo.dart';
import 'package:dartz/dartz.dart';
import '../failures/failures.dart';

class AdvisorUsecases {
  final AdvisorRepository advisorRepository;

  AdvisorUsecases({required this.advisorRepository});

  Future<Either<Failure, AdviceEntity>> getAdviceUsecase() async {
    return advisorRepository.getAdviceFromAPI();
  }
}
