import 'package:case_innova/src/core/controller/configuration_controller.dart';
import 'package:case_innova/src/core/controller/internet_controller.dart';
import 'package:case_innova/src/modules/home/controller/home_controller.dart';
import 'package:case_innova/src/modules/home/home_module.dart';
import 'package:case_innova/src/modules/splash/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => HomeController()),
        Bind.singleton((i) => ConfigurationController()),
        Bind.lazySingleton(
          (i) => InternetController(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashPage()),
        ModuleRoute(
          '/home',
          module: HomeModule(),
          transition: TransitionType.downToUp,
          duration: const Duration(milliseconds: 800),
        ),
      ];
}
