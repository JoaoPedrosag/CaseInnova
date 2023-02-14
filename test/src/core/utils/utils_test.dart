import 'package:case_innova/src/core/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deve converter a data',
      () => {expect(Utils.changeDate('2021-01-17') == '17/01/2021', true)});
}
