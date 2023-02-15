import 'package:case_innova/src/core/controller/configuration_controller.dart';
import 'package:case_innova/src/core/controller/internet_controller.dart';
import 'package:case_innova/src/core/widgets/snack_bar/snack_bar_custom.dart';
import 'package:case_innova/src/modules/home/controller/home_controller.dart';
import 'package:case_innova/src/modules/home/widgets/modal_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/widgets/button/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  final controller = Modular.get<HomeController>();
  final controllerTheme = Modular.get<ConfigurationController>();
  final internetController = Modular.get<InternetController>();

  @override
  void initState() {
    super.initState();
    internetController.checkInternet();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      infiniteScroll();
    });
  }

  infiniteScroll() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
        title: Text('Personagens do Star Wars',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize)),
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
        padding: const EdgeInsets.all(4.0),
        child: Observer(
          builder: (_) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                controller.state == HomeState.loading
                    ? Container()
                    : Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.97,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextFormField(
                            onChanged: (value) {
                              controller.search(value);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(10),
                              suffixIcon: const Icon(Icons.search),
                              hintText: 'Informe o nome do personagem',
                              hintStyle: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
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
        ),
      ),
    );
  }

  _success() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: controller.listSearch.isEmpty
            ? controller.list.length
            : controller.listSearch.length,
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
                              .primary
                              .withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.listSearch.isEmpty
                                ? controller.list[index].name!
                                : controller.listSearch[index].name!,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.list,
                            color: Theme.of(context).colorScheme.onBackground,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _start() {
    return Container();
  }

  _error() {
    return Column(
      children: [
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: ButtonCustom(
                  color: Theme.of(context).colorScheme.primary,
                  label: Text('Tentar novamente',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    internetController.checkInternet();
                    if (internetController.internet) {
                      controller.getAllPerson();
                    } else {
                      SnackBarCustom.error('Parece que você sem internet');
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }

  _loading() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .7),
      child: Column(
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
    );
  }
}
