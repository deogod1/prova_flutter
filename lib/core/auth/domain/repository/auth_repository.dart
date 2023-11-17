import 'package:dartz/dartz.dart';
import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';


abstract class AuthRepository {
  Future<Either<Fail, bool>> authLogin({required LoginEntity entity});
}
