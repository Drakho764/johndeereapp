import 'dart:async';

import 'package:flutter/material.dart';
import 'package:johndeereapp/home.dart';
import 'package:johndeereapp/login_screen.dart';
import 'package:johndeereapp/services/local_storage.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
  
}

class SplashViewState extends State<SplashView> {
  final LocalStorage prefis =LocalStorage();
  @override
  void initState(){
     prefis.readCache('user').then((value) {
      if (value != null){
        return 
        Timer(const Duration(seconds: 2), ()=>
           Navigator.push(context, MaterialPageRoute(builder: ((context)=> Home())))
        );
      }else{
         return 
        Timer(const Duration(seconds: 2), ()=>
           Navigator.push(context, MaterialPageRoute(builder: ((context)=> Home())))//LoginScreen
        );
      }
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}