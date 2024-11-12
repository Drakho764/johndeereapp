import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:johndeereapp/screens/profile/widgets/custom_elevated_button.dart';

import 'indicators.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String name='Nombre';
  String correo='Email';
  String tele='Telefono';
  String gith='GitHub';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.9,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Mi Perfil',
              style: GoogleFonts.josefinSans(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            ClipOval(
              child: Image.asset(
                'assets/me.jpg',
                width: size.width * 0.3,
              ),
            ),
            Text(
              name,
              style: GoogleFonts.josefinSans(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              correo,
              style: GoogleFonts.josefinSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              tele,
              style: GoogleFonts.josefinSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              gith,
              style: GoogleFonts.josefinSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }
}
