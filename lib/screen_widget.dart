import 'package:flutter/material.dart';
import 'package:johndeereapp/consts.dart';

class ScreenWidget extends StatelessWidget{
  final int index;
  const ScreenWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
      children: [
        //Lottie.asset("assets\animation\bg-1.json"),
        Expanded(flex: 2,
        child: Container(
          padding: const EdgeInsets.all(100),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 248, 239, 239),
            borderRadius: BorderRadius.vertical( bottom: Radius.circular(80)),
          ),
          child:
          Image.asset('assets/$index.png', width: 230),
          
          )),
        Expanded(child: Container(
          padding: const EdgeInsets.all(16),
          // ignore: sort_child_properties_last
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text(
                titles[index],
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                abouts[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                fontSize: 20,
                color: Colors.black54,
                
              ),
            )
          ]),
          color: Colors.white,
          )),
        Expanded(child: Container(
          color: Colors.white,
          )),
      ],

     ), 
    );
  }
}