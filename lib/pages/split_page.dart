import 'dart:math' as math;

import 'package:first_flutter_project/common_widgets/split_page_header_widget.dart';
import 'package:first_flutter_project/common_widgets/user_card_widget.dart';
import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:flutter/material.dart';

class SplitPage extends StatefulWidget {
  const SplitPage(this.numberOfPersons, this.price, {super.key});

  final int numberOfPersons;
  final String price;

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  List<User> users = [];
  String totalBill = "";
  int touchedIndex = -1;
  double leftToPay = 0.0;

  @override
  void initState() {
    super.initState();
    totalBill = widget.price;
    leftToPay = double.parse(widget.price);
    for (int i = 0; i < widget.numberOfPersons; i++) {
      users.add(User(
        id: i,
        name: "User ${i + 1}",
        priceToPay: 0,
        sliderValue: 0.0,
        maxSliderValue: 100,
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        isNameInEditMode: false,
      ));
    }
  }

  User findUserById(int id) {
    return users.firstWhere((user) => user.id == id);
  }

  void calculateLeftToPay(List<User> users) {
    setState(() {
      var calculatedPrice = 0.0;
      for (var user in users) {
        calculatedPrice = calculatedPrice + user.priceToPay;
      }

      leftToPay = double.parse(
          (double.parse(widget.price) - calculatedPrice).toStringAsFixed(2));
    });
  }

  void onDragEnd(double sliderValue, int id) {
    setState(() {
      var userOnWhichSliderIsChanged = findUserById(id);
      calculateLeftToPay(users);

      double allPercentages = 0;
      var restOfUsers = users.where((user) => user.id != id);
      for (var user in restOfUsers) {
        allPercentages = allPercentages + user.sliderValue;
      }

      if (allPercentages + sliderValue <= 100) {
        userOnWhichSliderIsChanged.sliderValue = sliderValue;
        double priceConvertedToDouble = double.parse(widget.price);
        userOnWhichSliderIsChanged.priceToPay = double.parse(
            (priceConvertedToDouble * (sliderValue / 100)).toStringAsFixed(2));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLibrary.appGray,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 40),
        title: const Text(
          "Split the bill",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorsLibrary.appGray,
        child: SafeArea(
          child: Column(
            children: [
              SplitPageHeader(
                  users: users, totalBill: totalBill, leftToPay: leftToPay),
              Expanded(
                child: SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 40),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: users?.length,
                        itemBuilder: (BuildContext context, int index) {
                          User user = users[index];
                          return CustomCard(
                            user: user,
                            onDragEnd: onDragEnd,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(0.2),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Generate QR code'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
