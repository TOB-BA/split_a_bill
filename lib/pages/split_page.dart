import 'dart:math' as math;

import 'package:first_flutter_project/common_widgets/alert_widget.dart';
import 'package:first_flutter_project/common_widgets/split_page_header_widget.dart';
import 'package:first_flutter_project/common_widgets/user_card_widget.dart';
import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/constants/common_constants.dart';
import 'package:first_flutter_project/extensions/user_extensions.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/pages/admin_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'qr_codes_page.dart';

class SplitPage extends StatefulWidget {
  const SplitPage(this.numberOfPersons, this.price, {super.key});

  final int numberOfPersons;
  final double price;

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  List<User> users = [];
  double totalBill = 0.0;
  int touchedIndex = -1;
  double leftToPay = 0.0;
  double fadeOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    totalBill = widget.price;
    leftToPay = widget.price;
    for (int i = 0; i < widget.numberOfPersons; i++) {
      users.add(
        User(
          id: i,
          name: "User ${i + 1}",
          priceToPay: 0,
          sliderValue: 0.0,
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          isNameInEditMode: false,
        ),
      );
    }
  }

  void navigateToScanQrCodePage(List<User> listOfUsers) {
    if (leftToPay > 0) {
      showDialog(
          context: context,
          builder: (context) => Alert(
              title: 'Split whole bill',
              description:
                  'Still € ${leftToPay.toStringAsFixed(2)} left to split!'));
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QrCodesPage(listOfUsers),
      ),
    );
  }

  void calculateLeftToPay(List<User> users) {
    setState(() {
      var calculatedPrice = 0.0;

      for (var user in users) {
        calculatedPrice = calculatedPrice + user.priceToPay;
      }

      leftToPay = widget.price - calculatedPrice;
      fadeOpacity = leftToPay <= 0 ? 0.5 : 1;
    });
  }

  void onDragEnd(double sliderValue, int id) {
    setState(() {
      var userOnWhichSliderIsChanged = users.findUserById(id);

      double allPercentages = 0;
      var restOfUsers = users.where((user) => user.id != id);
      for (var user in restOfUsers) {
        allPercentages = allPercentages + user.sliderValue;
      }

      if (allPercentages + sliderValue <= 100 && allPercentages <= 100) {
        userOnWhichSliderIsChanged.sliderValue = sliderValue;
        userOnWhichSliderIsChanged.priceToPay =
            widget.price * (sliderValue / 100);

        calculateLeftToPay(users);
      } else if (allPercentages < 100 && allPercentages + sliderValue > 100) {
        var newSliderValue = 100 - allPercentages;

        userOnWhichSliderIsChanged.sliderValue = newSliderValue;
        userOnWhichSliderIsChanged.priceToPay =
            widget.price * (newSliderValue / 100);

        calculateLeftToPay(users);
        return;
      }
    });
  }

  void navigateToProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AdminDetailsPage(
            title: CommonConstants.editAdminTitle, buttonTitle: "EDIT"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLibrary.appGray,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          "Split the bill",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ).animate().fade(begin: 0.5),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              navigateToProfilePage();
            },
          ),
        ],
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
                        itemCount: users.length,
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
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
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
                        ],
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .fade(
                              end: fadeOpacity,
                              delay: const Duration(milliseconds: 700)),
                    ),
                    ElevatedButton(
                      onPressed: () => {navigateToScanQrCodePage(users)},
                      child: const Text('Generate QR code'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
