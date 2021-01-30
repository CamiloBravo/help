import 'package:flutter/material.dart';
import 'package:Fluttaxi/src/infra/infra.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

import 'widgets/pageview.widget.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final pages = [
    PageviewWidget.buildViewModel(
        'assets/images/intro/pick.png',
        'assets/images/intro/splash1.jpg',
        'Bienvenido a ¡Help me! Servicios de emergencia y seguridad ciudadana'),
    PageviewWidget.buildViewModel(
        'assets/images/intro/pick.png',
        'assets/images/intro/splash2.jpg',
        '¡Help me! Te ayuda a reportar emergencias de manera fácil y rápida'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroViewsFlutter(pages,
          doneText: const Text(
              'Entendido', style: TextStyle(fontWeight: FontWeight.bold)
          ),
          showNextButton: true,
          pageButtonsColor: Colors.black,
          pageButtonTextSize: 18,
          showBackButton: true,
          nextText: const Text(
            "Siguiente", style: TextStyle(fontWeight: FontWeight.bold),),
          skipText: const Text(
              "Omitir", style: TextStyle(fontWeight: FontWeight.bold)),
          backText: const Text(
              "Regresar", style: TextStyle(fontWeight: FontWeight.bold)),
          onTapSkipButton: () => NavigationPagesRace.goToAccount(context),
          onTapDoneButton: () => NavigationPagesRace.goToAccount(context),
          pageButtonTextStyles: const TextStyle(color: Colors.black)),
    ); //Material App
  }
}
