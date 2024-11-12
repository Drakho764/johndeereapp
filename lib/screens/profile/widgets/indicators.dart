import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Indicators extends StatelessWidget {
  const Indicators({Key? key, required this.number, required this.text})
      : super(key: key);

  final String number, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.josefinSans(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 54, 124, 43),
          ),
        ),
        Text(
          text,
          style: GoogleFonts.josefinSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
