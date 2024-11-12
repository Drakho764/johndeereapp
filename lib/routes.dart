import 'package:flutter/material.dart';
import 'package:johndeereapp/home.dart';
import 'package:johndeereapp/screens/add_carrera.dart';
import 'package:johndeereapp/screens/add_profe.dart';
import 'package:johndeereapp/screens/add_task.dart';
import 'package:johndeereapp/screens/carrera_screen.dart';
import 'package:johndeereapp/screens/profesor_screen.dart';
import 'package:johndeereapp/screens/profile/profile_screen.dart';
import 'package:johndeereapp/task_screen.dart';


Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash': (BuildContext context) =>  Home(),
    '/task' : (BuildContext context) => const TaskScreen(),
    '/profile' : (BuildContext context) => const ProfileScreen(),
    '/add' : (BuildContext context) => AddTask(),
    '/addProfe': (BuildContext context) => AddProfesor(),
    '/profesor': (BuildContext context) => const ProfesorScreen(),
    '/carrera': (BuildContext context) => const CarreraScreen(),
    '/addCarrera': (BuildContext context) => AddCarrera(),
  };
}
