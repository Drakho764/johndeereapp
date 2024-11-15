import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardPeli extends StatelessWidget {
  final String name;
  final String photo;
  final String character;

  const CardPeli(
      {super.key,
      required this.name,
      required this.photo,
      required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Image.network(
            photo,
            width: 80,
            height: 80,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: AutoSizeText(
                name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ),
          Text('Popularidad: '+character,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
