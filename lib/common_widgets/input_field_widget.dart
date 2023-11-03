/*import 'package:flutter/cupertino.dart';

class InputField extends StatelessWidget {
  final String userName;
  final bool isEditingText;
  const InputField({super.key, required this.userName, required this.isEditingText});

*/ /*  @override
  Widget build(BuildContext context) {
    if (isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue) {
            setState(() {
              initialText = newValue;
              isEditingText = false;
            });
          },
          autofocus: true,
          controller: editingController,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          isEditingText = true;
        });
      },
      child: Text(
        initialText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }*/ /*
}*/
