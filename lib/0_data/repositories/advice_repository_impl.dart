import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/repositories/advice_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/advice_remote_datasources.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdviceRemoteDatasource adviceRemoteDatasource;

  AdviceRepositoryImpl({required this.adviceRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource() async {
    try {
      final result = await adviceRemoteDatasource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
