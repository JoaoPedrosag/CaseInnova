// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuration_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfigurationController on _ConfigurationController, Store {
  late final _$themeAtom =
      Atom(name: '_ConfigurationController.theme', context: context);

  @override
  ThemeMode get theme {
    _$themeAtom.reportRead();
    return super.theme;
  }

  @override
  set theme(ThemeMode value) {
    _$themeAtom.reportWrite(value, super.theme, () {
      super.theme = value;
    });
  }

  late final _$_ConfigurationControllerActionController =
      ActionController(name: '_ConfigurationController', context: context);

  @override
  void changeTheme() {
    final _$actionInfo = _$_ConfigurationControllerActionController.startAction(
        name: '_ConfigurationController.changeTheme');
    try {
      return super.changeTheme();
    } finally {
      _$_ConfigurationControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
theme: ${theme}
    ''';
  }
}
