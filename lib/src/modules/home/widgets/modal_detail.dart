import 'package:flutter/material.dart';

class ModalDetail extends StatelessWidget {
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: Theme.of(context).colorScheme.scrim,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      birthYear,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      gender,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      eyesColor,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
