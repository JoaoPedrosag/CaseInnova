import 'dart:developer';

import 'package:case_innova/src/modules/home/repository/person_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PersonImpl controller = PersonImpl();
  List<String> films = [];
  test(
    'deve retornar list person',
    () async {
      await controller.getPerson(2).then((value) => {
            films.add(value.results![0].films![0]),
            log(value.results![0].name.toString())
          });
    },
  );

  test(
    'deve retornar list film',
    () async {
      await controller
          .getFilms(films[0])
          .then((value) => {log(value.title![0])});
    },
  );
}
