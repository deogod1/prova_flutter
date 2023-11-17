import 'package:dartz/dartz.dart';
import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';
import 'package:prova_flutter/core/auth/domain/repository/auth_repository.dart';

class AuthLoginUseCase {
  final AuthRepository repository;

  AuthLoginUseCase({required this.repository});

  Future<Either<Fail, bool>> call({required LoginEntity entity}) async {
    return repository.authLogin(entity: entity);
  }
}
