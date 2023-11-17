import 'package:injector/injector.dart';
import 'package:prova_flutter/core/auth/data/datasources/login_data_source.dart';
import 'package:prova_flutter/core/auth/data/datasources/login_remote_data_source.dart';
import 'package:prova_flutter/core/auth/data/repository/auth_repository_impl.dart';
import 'package:prova_flutter/core/auth/domain/repository/auth_repository.dart';
import 'package:prova_flutter/core/auth/domain/usecases/auth_login_use_case.dart';
import 'package:prova_flutter/core/home/data/datasources/text_data_source.dart';
import 'package:prova_flutter/core/home/data/datasources/text_local_data_source.dart';
import 'package:prova_flutter/core/home/data/mapper/text_entity_mapper.dart';
import 'package:prova_flutter/core/home/data/repository/text_repository_impl.dart';
import 'package:prova_flutter/core/home/domain/repository/text_repository.dart';
import 'package:prova_flutter/core/home/domain/usecases/delete_text_use_case.dart';
import 'package:prova_flutter/core/home/domain/usecases/load_all_text_use_case.dart';
import 'package:prova_flutter/core/home/domain/usecases/save_text_use_case.dart';
import 'package:prova_flutter/core/home/presentation/home_bloc.dart';
import 'package:prova_flutter/core/login/presentation/bloc/login_bloc.dart';

void injectAll() {
  final injector = Injector.appInstance;

  injector.registerDependency(() => TextEntityMapper());

  injector.registerDependency<TextDataSource>(
      () => TextLocalDataSource(mapper: injector.get()));
  injector.registerDependency<LoginDataSource>(() => LoginRemoteDataSource());

  injector.registerDependency<TextRepository>(
      () => TextRepositoryImpl(dataSource: injector.get()));

  injector.registerDependency<AuthRepository>(
      () => AuthRepositoryImpl(injector.get()));

  injector
      .registerDependency(() => DeleteTextUseCase(repository: injector.get()));
  injector.registerDependency(
      () => LoadAllTextsUseCase(repository: injector.get()));
  injector
      .registerDependency(() => SaveTextUseCase(repository: injector.get()));
  injector
      .registerDependency(() => AuthLoginUseCase(repository: injector.get()));

  injector.registerDependency(() => HomeBloC(
        deleteTextUseCase: injector.get(),
        saveTextUseCase: injector.get(),
        loadAllTextsUseCase: injector.get(),
      ));
  injector.registerDependency(() => LoginBloC(injector.get()));
}
