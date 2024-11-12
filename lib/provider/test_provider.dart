import 'package:flutter/material.dart';

class TestProvider with ChangeNotifier {
  String _user = " ";

  String get user => _user;

  set user(String value) {
    _user = value;
    notifyListeners();
  }

  bool _updatePosts = false;

  getupdatePosts() => _updatePosts;
  setupdatePosts() {
    _updatePosts = !_updatePosts;
    notifyListeners();
  }
}
