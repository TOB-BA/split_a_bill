import 'dart:math' as math;

import 'package:first_flutter_project/common_widgets/split_page_header_widget.dart';
import 'package:first_flutter_project/common_widgets/user_card_widget.dart';
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
  TextEditingController editingController = TextEditingController();
  String initialText = "";

  @override
  void initState() {
    super.initState();
    totalBill = widget.price;
    editingController = TextEditingController(text: initialText);

    for (int i = 0; i < widget.numberOfPersons; i++) {
      users.add(User(
        id: i,
        name: "User ${i + 1}",
        priceToPay: double.parse(widget.price) / widget.numberOfPersons,
        sliderValue: 100 / widget.numberOfPersons,
        maxSliderValue: 100,
        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0),
        isNameInEditMode: false,
      ));
    }
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  User findUserById(int id) {
    return users.firstWhere((user) => user.id == id);
  }

  void setInputFieldState(User user, String newValue) {
    setState(() {
      findUserById(user.id).name = newValue;
      user.isNameInEditMode = false;
    });
  }

  void setEditingStateOnTrue(User user) {
    setState(() {
      user.isNameInEditMode = true;
      initialText = user.name;
    });
  }

  void onDragEnd(double sliderValue, int id) {
    setState(() {
      var userOnWhichSliderIsChanged = findUserById(id);

      userOnWhichSliderIsChanged.sliderValue = sliderValue;
      double priceConvertedToDouble = double.parse(widget.price);
      userOnWhichSliderIsChanged.priceToPay = double.parse(
          (priceConvertedToDouble * (sliderValue / 100)).toStringAsFixed(2));

      var restOfUsers = users.where((user) => user.id != id);
      for (var user in restOfUsers) {
        user.sliderValue =
            (100 - findUserById(id).sliderValue) / (restOfUsers.length);
        user.priceToPay = double.parse(
            (priceConvertedToDouble * (user.sliderValue / 100))
                .toStringAsFixed(2));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xff3675e8), size: 40),
        title: const Text(
          "Split the bill",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xff3675e8)),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff0d39d8),
        child: SafeArea(
          child: Column(
            children: [
              SplitPageHeader(users: users, totalBill: totalBill),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    User user = users[index];
                    return CustomCard(
                      user: user,
                      onDragEnd: onDragEnd,
                      setInputFieldState: setInputFieldState,
                      editingController: editingController,
                      setEditingStateOnTrue: setEditingStateOnTrue,
                    );
                  },
                ),
              ),
              /*         ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
