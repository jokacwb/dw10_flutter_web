import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

import '../env/env.dart';
import '../storage/storage.dart';
import 'interceptors/auth_interceptor.dart';

class CustomDio extends DioForBrowser {
  late AuthInterceptor _authInterceptor;

  CustomDio(Storage storage)
      : super(
          BaseOptions(
            baseUrl: Env.instance.get('backend_base_url'),
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
    _authInterceptor = AuthInterceptor(storage);
  }

  /// Para requisições que exigem autenticação
  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  /// Para requisições que NÃO exigem autenticação
  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
