import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../core/exceptions/unauthorized_exception.dart';
import '../../core/services/auth/login_service.dart';
part 'login_controller.g.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  error;
}

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginService _loginService;

  @readonly
  LoginStateStatus _loginStatus = LoginStateStatus.initial;

  @readonly
  String? _errorMessage;

  LoginControllerBase(this._loginService);

  @action
  Future<void> login(String email, String password) async {
    try {
      _loginStatus = LoginStateStatus.loading;
      await _loginService.execute(email, password);
      _loginStatus = LoginStateStatus.success;
    } on UnauthorizedException {
      _errorMessage = 'Login/Senha inválidos';
      _loginStatus = LoginStateStatus.error;
    } catch (e, s) {
      log('Falha ao tentar realizar login', error: e, stackTrace: s);
      _errorMessage = 'Opss algo deu errado ao tentar login. Tente mais tarde.';
      _loginStatus = LoginStateStatus.error;
    }
  }
}
