import 'package:case_innova/src/core/const/constantes.dart';
import 'package:case_innova/src/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/widgets/container_modal/container_modal.dart';

class ModalDetail extends StatefulWidget {
  String name;
  String birthYear;
  String gender;
  String eyesColor;
  List<String> films;
  ModalDetail({
    Key? key,
    required this.name,
    required this.birthYear,
    required this.gender,
    required this.eyesColor,
    required this.films,
  }) : super(key: key);

  @override
  State<ModalDetail> createState() => _ModalDetailState();
}

class _ModalDetailState extends State<ModalDetail> {
  final controller = Modular.get<HomeController>();
  @override
  void initState() {
    super.initState();
    controller.getFilm(widget.films);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .9,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            height: MediaQuery.of(context).size.height * .9,
            width: MediaQuery.of(context).size.width,
            child: Container(
              color: Theme.of(context).colorScheme.scrim,
              child: SingleChildScrollView(
                child: Observer(
                  builder: (_) => Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.97,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star_purple500_outlined),
                            Text(
                              'Especificações: ',
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ContainerModal(
                        icon: Icons.person,
                        label: 'Nome: ',
                        name: widget.name,
                      ),
                      ContainerModal(
                        icon: Icons.calendar_today,
                        label: 'Ano de aniversário: ',
                        name: widget.birthYear,
                      ),
                      ContainerModal(
                        icon: Icons.person,
                        label: 'Gênero: ',
                        name: widget.gender,
                      ),
                      ContainerModal(
                        icon: Icons.remove_red_eye_sharp,
                        label: 'Cor dos olhos: ',
                        name: widget.eyesColor,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      controller.loading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * .4,
                              width: MediaQuery.of(context).size.width * .8,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.listIds.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.asset(
                                              Constants.images.poster,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Título: ${controller.listIds[index].title!}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .fontSize,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Data de lancamento: ${controller.dateFormat(controller.listIds[index].releaseDate!)}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .fontSize,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
