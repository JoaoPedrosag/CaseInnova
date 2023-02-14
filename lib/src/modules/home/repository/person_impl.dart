import 'dart:convert';
import 'package:case_innova/src/core/const/constantes.dart';
import 'package:case_innova/src/modules/home/model/todo_film.dart';
import 'package:case_innova/src/modules/home/model/todo_person.dart';
import 'package:case_innova/src/modules/home/repository/i_person.dart';
import 'package:http/http.dart' as http;

class PersonImpl implements IPerson {
  @override
  Future<TodoPerson> getPerson(page) async {
    try {
      final url = Uri.parse(
          "${Constants.links.base}${Constants.links.people}?page=$page");
      final response = await http.get(url);
      return TodoPerson.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<TodoFilm> getFilms(value) async {
    try {
      final url = Uri.parse(value);
      final response = await http.get(url);
      return TodoFilm.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
