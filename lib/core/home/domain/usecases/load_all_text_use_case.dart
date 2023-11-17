import 'package:dartz/dartz.dart';
import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';
import 'package:prova_flutter/core/home/domain/repository/text_repository.dart';

class LoadAllTextsUseCase {
  final TextRepository repository;

  LoadAllTextsUseCase({required this.repository});

  Future<Either<Fail, List<TextEntity>>> call() async {
    return repository.loadAll();
  }
}