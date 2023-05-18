import 'package:flutter_modular/flutter_modular.dart';
import './modules/home/home_page.dart';
import 'core/constants.dart';
import 'modules/login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(Constants.instance.ROUTE_LOGIN, module: LoginModule()),
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
