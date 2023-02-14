import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'configuration_controller.g.dart';

class ConfigurationController = _ConfigurationController
    with _$ConfigurationController;

abstract class _ConfigurationController with Store {
  @observable
  ThemeMode theme = ThemeMode.light;

  @action
  void changeTheme() {
    theme = theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
