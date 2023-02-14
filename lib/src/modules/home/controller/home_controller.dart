import 'dart:convert';

import 'package:case_innova/src/modules/home/model/todo_person.dart';
import 'package:case_innova/src/modules/home/repository/person_impl.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  PersonImpl personImpl = PersonImpl();
  TodoPerson personTodo = TodoPerson(persons: []);

  ObservableList<Results> list = ObservableList<Results>.of([]);
  @observable
  int page = 0;

  @observable
  HomeState state = HomeState.start;

  Future getAllPerson() async {
    try {
      page++;
      state = HomeState.loading;
      personTodo = await personImpl.getPerson(page);
      for (var i = 0; i < personTodo.results!.length; i++) {
        list.add(personTodo.results![i]);
      }
      print(list.length);
      state = HomeState.success;
      return personTodo;
    } catch (e) {
      state = HomeState.error;
    }
  }
}

enum HomeState { start, loading, success, error }
