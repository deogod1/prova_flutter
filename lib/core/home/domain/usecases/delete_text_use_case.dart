import 'package:dartz/dartz.dart';
import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';
import 'package:prova_flutter/core/home/domain/repository/text_repository.dart';

class DeleteTextUseCase {
  final TextRepository repository;

  DeleteTextUseCase({required this.repository});

  Future<Either<Fail, void>> call({required TextEntity entity}) async {
    return repository.delete(entity: entity);
  }
}
