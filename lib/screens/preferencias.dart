import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:johndeereapp/home.dart';
import 'package:johndeereapp/screens/profile/widgets/custom_bottom_bar.dart';
import 'package:johndeereapp/services/local_storage.dart';

class Preferencias extends StatefulWidget {
  const Preferencias({super.key});

  @override
  State<Preferencias> createState() => _PreferenciasState();
}

class _PreferenciasState extends State<Preferencias> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ), // AppBar
      body: Container(
        width: double.infinity,
              height: size.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Preferencias',
                      style: GoogleFonts.josefinSans(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 100,),
                    Text(
                      'Selecciona el Tema',
                      style: GoogleFonts.josefinSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
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
                    SizedBox(height: 100,),

                      Text(
                        'Selecciona el tamaño de la fuente',
                        style: GoogleFonts.josefinSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),                    
                    
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
      ),
        bottomNavigationBar: CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color.fromARGB(255, 54, 124, 43),
        onPressed: () {
          Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>  Home())));
        },
        child: Icon(
          Icons.home,
          color: Colors.white,
          size: 34,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Column
    );
  }
}