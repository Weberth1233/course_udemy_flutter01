import 'package:advicer/1_domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/advice_entity.dart';
import '../failures/failures.dart';

class AdviceUseCases {
  final AdviceRepository adviceRepository;

  AdviceUseCases({required this.adviceRepository});

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepository.getAdviceFromDatasource();
    // return right(const AdviceEntity(advice: 'test advice 1234', id: 1));
    // return const AdviceEntity(advice: 'test advice 1', id: 1);
  }
}
