import 'package:flutter/material.dart';

class PersonsNumberWidget extends StatelessWidget {
  final Function incrementCounter;
  final Function decrementCounter;
  final int personsNumber;

  const PersonsNumberWidget(
      {super.key,
      required this.incrementCounter,
      required this.decrementCounter,
      required this.personsNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Color(0xff0932c2),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: SizedBox(
            height: 60,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => {
                    decrementCounter(),
                  },
                  child: const Text(
                    '-',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '$personsNumber',
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    const Icon(
                      Icons.supervisor_account,
                      color: Colors.white,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => {
                    incrementCounter(),
                  },
                  child: const Text(
                    '+',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
