import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';

class LoginEntityMapper {
  
  LoginEntity fromMap(Map<String, dynamic> map) {
    return LoginEntity(
      user: map['user'],
      senha: map['senha'],
    );
  }

  Map<String, dynamic> toMap(LoginEntity entity) {
    return {
      'user': entity.user,
      'senha': entity.senha,
    };
  }
}
