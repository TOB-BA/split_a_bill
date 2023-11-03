import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  double priceToPay;
  double sliderValue;
  double maxSliderValue;
  Color color;
  bool isNameInEditMode;

  User(
      {required this.id,
      required this.name,
      required this.priceToPay,
      required this.sliderValue,
      required this.maxSliderValue,
      required this.color,
      required this.isNameInEditMode});
}
