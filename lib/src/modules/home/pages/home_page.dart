import 'package:case_innova/src/core/controller/configuration_controller.dart';
import 'package:case_innova/src/modules/home/controller/home_controller.dart';
import 'package:case_innova/src/modules/home/model/todo_person.dart';
import 'package:case_innova/src/modules/home/widgets/modal_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  final controller = Modular.get<HomeController>();
  final controllerTheme = Modular.get<ConfigurationController>();
  List<Results> list = [];

  @override
  void initState() {
    super.initState();
    controller.getAllPerson();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      infiniteScroll();
    });
  }

  infiniteScroll() async {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        controller.state != HomeState.loading) {
      await controller.getAllPerson();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stateManagement(HomeState state) {
      switch (state) {
        case HomeState.start:
          return _start();
        case HomeState.success:
          return _success();
        case HomeState.loading:
          return _loading();
        case HomeState.error:
          return _error();

        default:
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Observer(
            builder: (context) => IconButton(
              icon: Icon(controllerTheme.theme == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                controllerTheme.changeTheme();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                onChanged: _search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Informe o nome do personagem',
                  hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
            Observer(
              builder: (_) {
                return stateManagement(controller.state);
              },
            ),
          ],
        ),
      ),
    );
  }

  _success() {
    return Expanded(
      child: ListView.separated(
          controller: _scrollController,
          itemCount: list.isEmpty ? controller.list.length : list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        isDismissible: true,
                        isScrollControlled: true,
                        builder: (context) => ModalDetail(
                            name: controller.list[index].name!,
                            birthYear: controller.list[index].birthYear!,
                            gender: controller.list[index].gender!,
                            eyesColor: controller.list[index].eyeColor!,
                            films: controller.list[index].films!),
                      );
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.1),
                              spreadRadius: 3,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Observer(
                                builder: (_) => Text(
                                  list.isEmpty
                                      ? controller.list[index].name!
                                      : list[index].name!,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              Icon(
                                Icons.list,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider()),
    );
  }

  _start() {
    return Container();
  }

  _error() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .8,
          child: Center(
            child: ElevatedButton(
                child: const Text('Tentar novamente',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                onPressed: () {
                  controller.getAllPerson();
                }),
          ),
        ),
      ],
    );
  }

  _loading() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .60,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _search(String search) {
    if (search.length > 3) {
      for (var value in controller.list) {
        if (value.name!.toLowerCase().contains(search.toLowerCase())) {
          list = value.name!.toLowerCase().contains(search.toLowerCase())
              ? [value]
              : [];
          print(list);
        }

        // if (value.name!.toLowerCase().contains(value as Pattern)) {
        //   controller.personTodo.results!.add(value);
        // }
      }
    }

    // final search = controller.list.where((element) {
    //   return element.name!.toLowerCase().contains(value.toLowerCase());
    // }).toList();
  }
}
