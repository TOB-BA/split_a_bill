import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/extensions/price_extensions.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:flutter/material.dart';

class SplitPageHeader extends StatelessWidget {
  final List<User> users;
  final double totalBill;
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
        Container(
          height: 120,
          width: double.infinity,
          color: Colors.white,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ColorsLibrary.appGray,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Total bill",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Left to pay",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        totalBill.addCurrencySymbolToDouble(),
                        softWrap: false,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        leftToPay.addCurrencySymbolToDouble(),
                        softWrap: false,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: leftToPay > 0
                              ? ColorsLibrary.appRed
                              : ColorsLibrary.appGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
