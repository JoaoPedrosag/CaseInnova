import 'package:case_innova/src/core/const/constantes.dart';
import 'package:case_innova/src/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = Modular.get<HomeController>();
  @override
  void initState() {
    controller.getAllPerson();
    Future.delayed(
      const Duration(seconds: 3),
      (() {
        Modular.to.navigate('/home/');
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(Constants.images.logo),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.09),
        ],
      ),
    );
  }
}
