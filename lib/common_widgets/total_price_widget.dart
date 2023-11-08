import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:flutter/material.dart';

class TotalPriceWidget extends StatelessWidget {
  final String price;

  const TotalPriceWidget({super.key, required this.price});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Total (incl. tax & fees)',
          style: TextStyle(color: ColorsLibrary.appGray),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15,
              top: 0,
              right: 15,
              bottom: 0), //apply padding to all four sides
          child: Text(
            "€ $price",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              color: ColorsLibrary.appGray,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
