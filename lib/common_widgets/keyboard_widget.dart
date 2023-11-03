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
              onPressed: () => {
                addNumber('1'),
              },
              child: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                addNumber('2'),
              },
              child: const Text(
                '2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                addNumber('3'),
              },
              child: const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
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
                addNumber('4'),
              },
              child: const Text(
                '4',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                addNumber('5'),
              },
              child: const Text(
                '5',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                addNumber('6'),
              },
              child: const Text(
                '6',
                style: TextStyle(
                  color: Colors.white,
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
                addNumber('7'),
              },
              child: const Text(
                '7',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                addNumber('8'),
              },
              child: const Text(
                '8',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                addNumber('9'),
              },
              child: const Text(
                '9',
                style: TextStyle(
                  color: Colors.white,
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
              child: const Text(
                '.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                addNumber('0'),
              },
              child: const Text(
                '0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () => {
                clearPrice(),
              },
              child: const Icon(
                Icons.cancel_outlined,
                color: Colors.white,
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
                  primary: Colors.green,
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
