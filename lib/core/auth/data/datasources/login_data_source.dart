import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';

abstract class LoginDataSource {
  Future<bool> authLogin({required LoginEntity entity});
}
