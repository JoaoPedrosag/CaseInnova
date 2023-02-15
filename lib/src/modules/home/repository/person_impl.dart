import 'dart:convert';
import 'dart:developer';
import 'package:case_innova/src/core/const/constantes.dart';
import 'package:case_innova/src/core/widgets/snack_bar/snack_bar_custom.dart';
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
      final response = await http.get(url).timeout(const Duration(seconds: 20),
          onTimeout: () {
        SnackBarCustom.alert('Parece que você esta sem internet');
        throw Exception('timeout');
      });
      if (response.statusCode == 200) {
        return TodoPerson.fromJson(jsonDecode(response.body));
      }
      SnackBarCustom.error('Parece que nossos servidores estão desligados');
      throw Exception('Unable to fetch movies from the REST API');
    } on Exception catch (e) {
      log(e.toString());
      throw Exception("Erro ao buscar filmes");
    }
  }

  @override
  Future<TodoFilm> getFilms(value) async {
    try {
      final url = Uri.parse(value);
      final response = await http.get(url).timeout(const Duration(seconds: 35),
          onTimeout: () {
        SnackBarCustom.alert('Parece que você esta sem internet');
        throw Exception('timeout');
      });
      if (response.statusCode == 200) {
        return TodoFilm.fromJson(jsonDecode(response.body));
      }
      SnackBarCustom.error('Parece que nossos servidores estão desligados');
      throw Exception('Unable to fetch movies from the REST API');
    } on Exception catch (e) {
      log(e.toString());
      throw Exception("Erro ao buscar filmes");
    }
  }
}
