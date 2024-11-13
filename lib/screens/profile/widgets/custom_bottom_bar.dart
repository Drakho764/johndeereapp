import 'package:flutter/material.dart';
import 'package:johndeereapp/home.dart';
import 'package:johndeereapp/screens/preferencias.dart';
import 'package:johndeereapp/screens/profile/profile_screen.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 0;
              });
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>  Home())));
            },
            icon: Icon(
              Icons.home,
              size: _currentIndex == 0 ? 30 : 25,
              color: _currentIndex == 0 ? Color.fromARGB(255, 54, 124, 43) : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            icon: Icon(
              Icons.notifications,
              size: _currentIndex == 1 ? 30 : 25,
              color: _currentIndex == 1 ? Color.fromARGB(255, 54, 124, 43) : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>  Preferencias())));
            },
            icon: Icon(
              Icons.room_preferences,
              size: _currentIndex == 2 ? 30 : 25,
              color: _currentIndex == 2 ? Color.fromARGB(255, 54, 124, 43) : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _currentIndex = 3;
              });
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ProfileScreen())));
            },
            icon: Icon(
              Icons.person,
              size: _currentIndex == 3 ? 30 : 25,
              color: _currentIndex == 3 ? Color.fromARGB(255, 54, 124, 43) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
