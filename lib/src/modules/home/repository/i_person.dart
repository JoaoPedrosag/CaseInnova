import 'package:case_innova/src/modules/home/model/todo_person.dart';

abstract class IPerson {
  Future<TodoPerson> getPerson(page);
}
