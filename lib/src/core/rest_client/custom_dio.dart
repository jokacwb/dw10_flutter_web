import 'package:dio/browser.dart';
import 'package:dio/dio.dart';

import '../env/env.dart';

class CustomDio extends DioForBrowser {
  CustomDio()
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
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }

  /// Para requisições que exigem autenticação
  CustomDio auth() {
    return this;
  }

  /// Para requisições que NÃO exigem autenticação
  CustomDio unauth() {
    return this;
  }
}
