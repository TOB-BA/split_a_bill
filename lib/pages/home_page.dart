import 'package:first_flutter_project/common_widgets/keyboard_widget.dart';
import 'package:first_flutter_project/pages/split_page.dart';
import 'package:flutter/material.dart';

import '../common_widgets/persons_number_widget.dart';
import '../common_widgets/total_price_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int personsNumber = 0;
  String price = "0.0";

  void incrementCounter() {
    setState(() {
      personsNumber++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (personsNumber > 0) {
        personsNumber--;
      }
    });
  }

  void addNumber(String number) {
    setState(() {
      if (price == "0.0") {
        price = "";
      }

      price = price + number;
    });
  }

  void clearPrice() {
    setState(() {
      price = "0.0";
    });
  }

  void navigateToSplitPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SplitPage(personsNumber, price),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0d39d8),
        centerTitle: true,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xff3675e8)),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff0d39d8),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TotalPriceWidget(price: price),
              PersonsNumberWidget(
                  incrementCounter: incrementCounter,
                  decrementCounter: decrementCounter,
                  personsNumber: personsNumber),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 0, right: 10, bottom: 0),
                child: KeyboardWidget(
                  addNumber: addNumber,
                  clearPrice: clearPrice,
                  navigateToSplitPage: navigateToSplitPage,
                  price: price,
                  personsNumber: personsNumber,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
