import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String title;
  final String description;
  const Alert({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              title,
              style: TextStyle(color: ColorsLibrary.appGray, fontSize: 24),
            ),
            content: Text(
              description,
              style: TextStyle(color: ColorsLibrary.appGray, fontSize: 16),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: ColorsLibrary.appGreen,
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
