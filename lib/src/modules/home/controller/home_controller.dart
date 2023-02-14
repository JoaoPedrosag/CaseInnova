import 'package:case_innova/src/core/utils/utils.dart';
import 'package:case_innova/src/modules/home/model/todo_film.dart';
import 'package:case_innova/src/modules/home/model/todo_person.dart';
import 'package:case_innova/src/modules/home/repository/person_impl.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  PersonImpl personImpl = PersonImpl();
  TodoPerson personTodo = TodoPerson(persons: []);

  ObservableList<Results> list = ObservableList<Results>.of([]);

  ObservableList<Results> listSearch = ObservableList<Results>.of([]);

  ObservableList<TodoFilm> listIds = ObservableList<TodoFilm>.of([]);
  @observable
  int page = 0;

  @observable
  bool loading = false;

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
      state = HomeState.success;
    } catch (e) {
      state = HomeState.error;
    }
  }

  @action
  search(String search) {
    if (search.length >= 2) {
      for (var value in list) {
        if (value.name!.toLowerCase().contains(search.toLowerCase()) &&
            !listSearch.contains(value)) {
          listSearch.add(value);
        }
      }
    } else {
      listSearch.clear();
    }
  }

  @action
  void changeLoading(value) => loading = value;

  Future getFilm(List<String> films) async {
    try {
      changeLoading(true);

      for (var i = 0; i < films.length; i++) {
        listIds.add(await personImpl.getFilms(films[i]));
      }

      changeLoading(false);
    } catch (e) {
      changeLoading(false);
    }
  }

  dateFormat(String date) {
    return Utils.changeDate(date);
  }
}

enum HomeState { start, loading, success, error }
