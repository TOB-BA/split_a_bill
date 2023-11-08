import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:flutter/material.dart';

class KeyboardWidget extends StatelessWidget {
  final Function addNumber;
  final Function clearPrice;
  final Function navigateToSplitPage;
  final String price;
  final int personsNumber;
  const KeyboardWidget(
      {super.key,
      required this.addNumber,
      required this.clearPrice,
      required this.price,
      required this.personsNumber,
      required this.navigateToSplitPage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('1'),
              },
              child: Text(
                '1',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('2'),
              },
              child: Text(
                '2',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('3'),
              },
              child: Text(
                '3',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('4'),
              },
              child: Text(
                '4',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('5'),
              },
              child: Text(
                '5',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('6'),
              },
              child: Text(
                '6',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('7'),
              },
              child: Text(
                '7',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('8'),
              },
              child: Text(
                '8',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('9'),
              },
              child: Text(
                '9',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => {
                addNumber('.'),
              },
              child: Text(
                '.',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(color: ColorsLibrary.appGray),
                  ),
                ),
              ),
              onPressed: () => {
                addNumber('0'),
              },
              child: Text(
                '0',
                style: TextStyle(
                  color: ColorsLibrary.appGray,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                clearPrice(),
              },
              child: Icon(
                Icons.backspace,
                color: ColorsLibrary.appGray,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () => {navigateToSplitPage()},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsLibrary.appGreen,
                ),
                child: const Text(
                  "SPLIT",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
