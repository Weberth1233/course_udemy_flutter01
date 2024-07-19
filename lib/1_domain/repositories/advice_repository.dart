import 'package:dartz/dartz.dart';

import '../entities/advice_entity.dart';
import '../failures/failures.dart';

abstract class AdviceRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource();
}
