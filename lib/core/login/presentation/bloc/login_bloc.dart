import 'dart:async';
import 'package:get/get.dart';
import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';
import 'package:prova_flutter/core/auth/domain/usecases/auth_login_use_case.dart';
import 'package:prova_flutter/core/login/presentation/bloc/login_events.dart';
import 'package:prova_flutter/screens/home_screen/home_screen.dart';

class LoginBloC {
  LoginBloC(this.authLoginUseCase) {
    loginDataStream.listen((event) {
      if (event is DoLoginEvent) {
        _handleDoLoginEvent(event.entity);
      }
    });
  }

  final AuthLoginUseCase authLoginUseCase;
  final _loginData = StreamController<LoginEvent>();
  Sink get loginDataSink => _loginData.sink;
  Stream<LoginEvent> get loginDataStream => _loginData.stream;

  void _handleDoLoginEvent(LoginEntity entity) async {
    final result = await authLoginUseCase.call(entity: entity);

    result.fold((l) {}, (r) {
      if (r) {
        Get.to(() => const HomeScreen());
      }
    });
  }
}
