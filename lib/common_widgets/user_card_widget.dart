import 'package:first_flutter_project/models/user.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Function(double, int) onDragEnd;
  final User user;
  final Function setInputFieldState;
  final TextEditingController editingController;
  final Function setEditingStateOnTrue;

  const CustomCard({
    super.key,
    required this.user,
    required this.onDragEnd,
    required this.setInputFieldState,
    required this.editingController,
    required this.setEditingStateOnTrue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 300,
          height: 100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _editTitleTextField(user),
                          Row(
                            children: [
                              Text(
                                user.sliderValue.round().toString(),
                              ),
                              const Text("%"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "€ ${user.priceToPay.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: Slider(
                      divisions: 100,
                      value: user.sliderValue,
                      max: user.maxSliderValue,
                      onChanged: (double value) => {
                        onDragEnd(value, user.id),
                      },
                      activeColor: user.color,
                      inactiveColor: user.color,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editTitleTextField(user) {
    if (user.isNameInEditMode) {
      return Positioned(
        child: Container(
          width: 150,
          height: 20.0,
          child: TextField(
            onSubmitted: (newValue) => {
              setInputFieldState(user, newValue),
            },
            autofocus: true,
            controller: editingController,
            maxLines: 1,
          ),
        ),
      );
    }
    return InkWell(
      onTap: () => {
        setEditingStateOnTrue(user),
      },
      child: Text(
        user.name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
