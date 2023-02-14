import 'package:case_innova/src/modules/home/model/todo_film.dart';
import 'package:case_innova/src/modules/home/model/todo_person.dart';

abstract class IPerson {
  Future<TodoPerson> getPerson(page);
  Future<TodoFilm> getFilms(id);
}
