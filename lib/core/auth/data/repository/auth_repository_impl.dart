import 'package:dartz/dartz.dart';
import 'package:prova_flutter/core/auth/data/datasources/login_data_source.dart';
import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';
import 'package:prova_flutter/core/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final LoginDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Fail, bool>> authLogin({required LoginEntity entity}) async {
    try{
      return Right(await dataSource.authLogin(entity: entity));
    }on Fail {
      return Left(Fail("Erro"));
    }
  }
}