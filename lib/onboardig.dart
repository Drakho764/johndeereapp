// ignore_for_file: unnecessary_string_escapes


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:johndeereapp/consts.dart';
import 'package:johndeereapp/login_screen.dart';
import 'package:johndeereapp/screen_widget.dart';
import 'package:johndeereapp/home.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState()=> _OnboardigState();
  
}

class _OnboardigState extends State<Onboarding>{
  int pageIndex=0;
  late PageController pageController;
  

  @override
  void initState() {
    super.initState();
    pageController=PageController(
      initialPage: pageIndex
    );

  }


  @override
  Widget build(BuildContext context){

    final size=MediaQuery.of(context).size;

    return Scaffold(
      
      body: Stack(
        children: [
           
          PageView.builder(
            onPageChanged: (value) {
              setState(() {
                pageIndex=value;
              });
            },
            itemCount: 3,
            controller: pageController,
            itemBuilder: ((context,index){
            return  ScreenWidget(index: pageIndex);
          })),
          Positioned(
            bottom: 0,
            child: SizedBox(
              height: size.height*.20,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: 8,width: 8,decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: pageIndex == index ? btnColor : bgColor,
                      ),
                    )),
                  ),

                  SizedBox(
                    height: 50,
                    width: size.width-100,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 192, 61, 52),
                      ),
                      onPressed: pageIndex == 2? (){
                        Navigator.push(context, MaterialPageRoute(builder: ((context)=>  Home())));//LoginScreen
                      }:(){
                        pageController.nextPage(duration: const Duration(milliseconds: 600), curve: Curves.ease);
                      },
                      child:  Text(
                        pageIndex == 2 ? "PROCEED" : "NEXT", 
                        style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white,
                      ),),
                    ),
                  )

                ],
              ),
            ),
          ),

          if(pageIndex != 2)
          Positioned(
            right: 30,
            top: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 192, 61, 52),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context)=>  Home())));
              }, child: const Text(
              "SKIP", 
              style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white,
            ),),),
          ),
          Center(
            child: Lottie.asset("assets/animation/anima.json"),
          ),

        ],
      ),
    );
  }
}