// ignore_for_file: unnecessary_string_escapes

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:johndeereapp/services/local_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:johndeereapp/consts.dart';
import 'package:johndeereapp/login_screen.dart';
import 'package:johndeereapp/screen_widget.dart';
import 'package:johndeereapp/home.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardigState();
}

class _OnboardigState extends State<Onboarding> {
  int pageIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              itemCount: 3,
              controller: pageController,
              itemBuilder: ((context, index) {
                return ScreenWidget(index: pageIndex);
              })),
          Center(
            child: Lottie.asset("assets/animation/animation.json"),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: size.height * .25,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3,
                        (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: pageIndex == index ? btnColor : bgColor,
                              ),
                            )),
                  ),
                  Visibility(
                    visible: pageIndex == 2 ? true : false,
                    child: Column(
                      children: [Switch(
                          value: AdaptiveTheme.of(context).mode ==
                              AdaptiveThemeMode.light,
                          onChanged: (bool value) {
                            setState(() {
                              LocalStorage.prefs.setBool('tema', value);
                              tema = value;
                              if (tema) {
                                AdaptiveTheme.of(context).setLight();
                              } else {
                                AdaptiveTheme.of(context).setDark();
                              }
                            });
                          }),
                          Text('Podrás cambiarlo cuando quieras en la seccion de \npreferencias', textAlign: TextAlign.center,style: TextStyle(fontSize: 12),)]
                    ),
                  ),
                  SizedBox(
                    height: pageIndex == 2 ? 48 : 130,
                  ),
                  SizedBox(
                    height:50,
                    width: size.width - 100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 54, 124, 43),
                      ),
                      onPressed: pageIndex == 2
                          ? () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          Home()))); //LoginScreen
                            }
                          : () {
                              pageController.nextPage(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.ease);
                            },
                      child: Text(
                        pageIndex == 2 ? "PROCEED" : "NEXT",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (pageIndex != 2)
            Positioned(
              right: 30,
              top: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 54, 124, 43),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: ((context) => Home())));
                },
                child: const Text(
                  "SKIP",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
