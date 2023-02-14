import 'dart:convert';

import 'package:case_innova/src/core/const/api_util.dart';
import 'package:case_innova/src/modules/home/model/todo_person.dart';
import 'package:case_innova/src/modules/home/repository/i_person.dart';
import 'package:http/http.dart' as http;

class PersonImpl implements IPerson {
  @override
  Future<TodoPerson> getPerson(page) async {
    try {
      final url = Uri.parse("${Links.base}?page=$page");
      final response = await http.get(url);
      return TodoPerson.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
