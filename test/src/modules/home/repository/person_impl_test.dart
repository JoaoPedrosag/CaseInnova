import 'package:case_innova/src/modules/home/repository/person_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PersonImpl controller = PersonImpl();
  test(
    'deve retornar list',
    () async {
      await controller
          .getPerson(2)
          .then((value) => {print(value.results![0].name)});
    },
  );
}
