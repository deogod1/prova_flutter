import 'package:dartz/dartz.dart';
import 'package:prova_flutter/core/home/data/datasources/text_data_source.dart';
import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';
import 'package:prova_flutter/core/home/domain/repository/text_repository.dart';

class TextRepositoryImpl implements TextRepository{
  final TextDataSource dataSource;

  TextRepositoryImpl({required this.dataSource});


  @override
  Future<Either<Fail, void>> delete({required TextEntity entity}) async {
    try{
      return Right(await dataSource.delete(entity: entity));
    }on Fail {
      return Left(Fail("Error"));
    }
  }

  @override
  Future<Either<Fail, List<TextEntity>>> loadAll() async {
    try{
      return Right(await dataSource.loadAll());
    }on Fail {
      return Left(Fail("Error"));
    }
  }

  @override
  Future<Either<Fail, void>> save({required TextEntity entity}) async {
    try{
      return Right(await dataSource.save(entity: entity));
    }on Fail {
      return Left(Fail("Error"));
    }
  }

}