import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';

abstract class LoginEvent {}

class DoLoginEvent extends LoginEvent {
  final LoginEntity entity;

  DoLoginEvent(this.entity);
}
