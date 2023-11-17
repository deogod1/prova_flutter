import 'package:dartz/dartz.dart';
import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';

abstract class TextRepository {
  Future<Either<Fail, void>> save({required TextEntity entity});
  Future<Either<Fail, List<TextEntity>>> loadAll();
  Future<Either<Fail, void>> delete({required TextEntity entity});
}
