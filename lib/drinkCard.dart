import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:johndeereapp/drink.dart';

class Drinkcard extends StatelessWidget {
  Drink drink;
  double pageOffset;
  double animation=0;
  double animate =0;
  double rotate=0;
  double columnAnimation=0;
  int index;

  Drinkcard(this.drink, this.pageOffset, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    double cardWidth =size.width-60;
    double cardHeigh = size.height*.55;
    double count =0;
    double page;
    rotate =index-pageOffset;
    for(page=pageOffset;page>1;){
      page --;
      count ++;
    }
    animation = Curves.easeInOutBack.transform(page);
    animate=100*(count+animation);
    columnAnimation =50*(count+animation);
    for (int i = 0; i < index; i++) {
      animate-=100;
      columnAnimation-=50;
    }

    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          buildTopText(),
          buildBackgroundImage(cardWidth,cardHeigh,size),
          buildAboveCard(cardWidth,cardHeigh,size),
          buildCupImage(size),
          buildBlurImage(cardWidth,size),
          buildSmallImage(size),
          buildTopImage(cardWidth,size,cardHeigh),
        ],
      ),
    );
  }
  
  Widget buildTopText() {
    return Padding(
      padding: const EdgeInsets.only(top:25),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 20,),
          Text(drink.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
          Text(drink.conName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),)
        ],
      ),
    );
  }
  
  Widget buildBackgroundImage(double cardWidth, double cardHeigh, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeigh,
      bottom: size.height*.12,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.asset(drink.backgroundImage, fit: BoxFit.cover,),
      ),
    ));
  }
  
  Widget buildAboveCard(double cardWidth, double cardHeigh, Size size) {
    return Positioned(
      width: cardWidth,
      height: cardHeigh,
      bottom: size.height*.12,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: drink.darkColor.withOpacity(.5),
          borderRadius: BorderRadius.circular(25)
        ),
        padding: EdgeInsets.all(30),
        child: Transform.translate(
          offset: Offset(-columnAnimation, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Tractor', style: TextStyle(fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white),),
              const SizedBox(height: 10,),
              Text(drink.description, style: const TextStyle(color: Colors.white70,fontSize: 18),),
              Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: 5,),
                  Image.asset('images/tractorL.png', width: 30,),
                  SizedBox(width: 10,),
                  Image.asset('images/tractorL.png', width: 25,),
                  SizedBox(width: 10,),
                  Image.asset('images/tractorL.png', width: 20,)
                ],
              ),
              SizedBox(height: 15,),
              Container(
                height: 40,
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 54, 124, 43), borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(width: 20,),
                        Text('25.2', style: TextStyle(fontSize: 20, color: Colors.white),),
                        SizedBox(width: 10,),
                        Text('hp',style: TextStyle(fontSize: 16, color: Colors.white),),
                        
                      ],
                    ),
                  ),
                ),
              )
          
          
            ],
          ),
        ),
      ),
      );
  }
  
  Widget buildCupImage(Size size) {
    return Positioned(
      bottom: 140,
      right: -size.width*.9/2+30,
      child: Transform.rotate(
        angle: -math.pi/14*rotate,
        child: Image.asset(drink.cupImage,height: size.height*.55-15,)),
    );
  }
  
  Widget buildBlurImage(double cardWidth, Size size) {
    return Positioned(
      right: cardWidth/2+45+animate,
      bottom: size.height*.42,
      child: Image.asset('images/leavein.png',width: 70,),
    );
  }
  
  Widget buildSmallImage(Size size) {
    return Positioned(
      right: -10+animate,
      top: size.height*.20,
      child: Image.asset('images/leave.png',width: 70,),
    );
  }
  
  Widget buildTopImage(double cardWidth, Size size, double cardHeigh) {
    return Positioned(
      left: cardWidth/4-animate,
      bottom: size.height*.12+cardHeigh-25,
      child: Image.asset('images/ciervo.png',width: 90,),
    );
  }
}