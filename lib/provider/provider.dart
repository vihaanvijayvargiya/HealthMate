import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  dynamic firstSnapshot;
  dynamic secondSnapshot;
  dynamic thirdSnapshot;

  void updateFirstSnapshot(dynamic newSnapshot) {
    firstSnapshot = newSnapshot;
    notifyListeners();
  }

  void updateSecondSnapshot(dynamic newSnapshot) {
    secondSnapshot = newSnapshot;
    notifyListeners();
  }
  void updatethirdSnapshot(dynamic newSnapshot) {
    thirdSnapshot = newSnapshot;
    notifyListeners();
  }
}
