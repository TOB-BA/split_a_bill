import 'package:first_flutter_project/common_widgets/keyboard_widget.dart';
import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/constants/common_constants.dart';
import 'package:first_flutter_project/extensions/price_extensions.dart';
import 'package:first_flutter_project/models/split.dart';
import 'package:first_flutter_project/pages/admin_details_page.dart';
import 'package:first_flutter_project/pages/split_page.dart';
import 'package:flutter/material.dart';

import '../common_widgets/alert_widget.dart';
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
  String price = CommonConstants.initialPrice;

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

  bool getLastCharacterInString(String text) {
    return text.contains(CommonConstants.dot);
  }

  void addNumber(String number) {
    setState(() {
      if (price == CommonConstants.initialPrice) {
        if (number == CommonConstants.dot) {
          price = CommonConstants.initialPriceWithDot;
          return;
        }
        price = CommonConstants.emptyString;
      } else if (getLastCharacterInString(price) &&
          number == CommonConstants.dot) {
        return;
      }

      price = price + number;
    });
  }

  void clearPrice() {
    setState(() {
      if (price.length > 1) {
        price = price.substring(0, price.length - 1);
      } else {
        price = CommonConstants.initialPrice;
      }
    });
  }

  void increasePersonsNumberDialog() {
    showDialog(
      context: context,
      builder: (context) => Alert(
        title: 'Increase number of persons',
        description: 'You can\'t split the bill with $personsNumber person(s)!',
      ),
    );
  }

  void increasePriceDialog() {
    var bill = CommonConstants.emptyString;
    if (price == CommonConstants.initialPriceWithDot) {
      bill = CommonConstants.initialPrice;
    } else {
      bill = price;
    }

    showDialog(
      context: context,
      builder: (context) => Alert(
        title: 'Increase price',
        description:
            'You can\'t split the bill which is ${bill.addCurrencySymbolToString()}!',
      ),
    );
  }

  void navigateToProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AdminDetailsPage(
          title: CommonConstants.editAdminTitle,
          buttonTitle: "EDIT",
        ),
      ),
    );
  }

  void navigateToSplitPage() {
    if (double.parse(price) <= 0) {
      increasePriceDialog();
      return;
    }

    if (personsNumber <= 1) {
      increasePersonsNumberDialog();
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SplitPage(
          Split(
            personsNumber,
            double.parse(price),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(color: ColorsLibrary.appGray),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle_rounded,
              color: ColorsLibrary.appGray,
            ),
            onPressed: () {
              navigateToProfilePage();
            },
          ),
        ],
        iconTheme: const IconThemeData(size: 30),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white38,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
