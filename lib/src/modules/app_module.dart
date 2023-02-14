import 'package:case_innova/src/core/controller/configuration_controller.dart';
import 'package:case_innova/src/modules/home/home_module.dart';
import 'package:case_innova/src/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => ConfigurationController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashPage()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
