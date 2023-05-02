import 'package:flutter/material.dart';

class Movies with ChangeNotifier {
  List<dynamic> _movie = [];

  void updateMovie(List<dynamic> c) {
    _movie = c;
    notifyListeners();
  }

  List<dynamic> get movie {
    return [..._movie];
  }
}
