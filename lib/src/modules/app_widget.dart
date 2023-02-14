import 'package:case_innova/src/core/controller/configuration_controller.dart';
import 'package:case_innova/src/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final controller = Modular.get<ConfigurationController>();
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp.router(
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        debugShowCheckedModeBanner: false,
        themeMode: controller.theme,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
