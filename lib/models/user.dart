import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  double priceToPay;
  double sliderValue;
  Color color;
  bool isNameInEditMode;

  User(
      {required this.id,
      required this.name,
      required this.priceToPay,
      required this.sliderValue,
      required this.color,
      required this.isNameInEditMode});
}
