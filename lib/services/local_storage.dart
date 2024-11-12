import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async{
    
    prefs= await SharedPreferences.getInstance();
  }
  Future readCache(String user) async {
    prefs= await SharedPreferences.getInstance();
    var cache=prefs.getString('user');
    return cache;
  }
  static ValueNotifier<bool> flagTheme = ValueNotifier<bool>(true);
  static ValueNotifier<bool> flagTask = ValueNotifier<bool>(true);
  guardarValor(valor) async {
    flagTheme.value = valor;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('flagTheme', flagTheme.value);
  }

  leerValor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    flagTheme.value = prefs.getBool('flagTheme') ?? false;
  }
}
//Practica 3