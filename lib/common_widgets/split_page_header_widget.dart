import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:flutter/material.dart';

class SplitPageHeader extends StatelessWidget {
  final List<User> users;
  final String totalBill;
  final double leftToPay;

  const SplitPageHeader(
      {super.key,
      required this.users,
      required this.totalBill,
      required this.leftToPay});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ColorsLibrary.appGray,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Total bill",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "€ $totalBill",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                leftBill(leftToPay),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget leftBill(leftToPay1) {
    if (leftToPay1 > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Left to pay",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            "€ $leftToPay1",
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorsLibrary.appRed),
          ),
        ],
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Left to pay",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Text(
          "€ $leftToPay1",
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorsLibrary.appGreen),
        ),
      ],
    );
  }
}
