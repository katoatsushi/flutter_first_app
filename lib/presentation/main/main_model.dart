import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier {
  String gonzaText = "gonzaだよ";
  void changeGonzaText() {
    gonzaText = "gonzaじゃないよ";
    notifyListeners();
  }
}