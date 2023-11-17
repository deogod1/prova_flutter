import 'package:prova_flutter/core/auth/data/datasources/login_data_source.dart';
import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';

class LoginRemoteDataSource extends LoginDataSource {
  @override
  Future<bool> authLogin({required LoginEntity entity}) async {
    //consultar api
    return true;
  }
}
