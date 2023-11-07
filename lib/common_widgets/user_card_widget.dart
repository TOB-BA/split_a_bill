import 'package:first_flutter_project/models/user.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Function(double, int) onDragEnd;
  final User user;

  const CustomCard({
    super.key,
    required this.user,
    required this.onDragEnd,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  TextEditingController editingController = TextEditingController();
  void setEditingStateOnTrue(User user) {
    setState(() {
      editingController.text = user.name;
      user.isNameInEditMode = true;
    });
  }

  void setInputFieldState(User user) {
    setState(() {
      if (editingController.text.isNotEmpty) {
        user.name = editingController.text;
        user.isNameInEditMode = false;
      }
    });
  }

  @override
  void dispose() {
    editingController.dispose();
    super.dispose();
  }

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _editTitleTextField(widget.user),
                          Row(
                            children: [
                              Text(
                                widget.user.sliderValue.round().toString(),
                              ),
                              const Text("%"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "€ ${widget.user.priceToPay.toStringAsFixed(2)}",
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
                      value: widget.user.sliderValue,
                      max: 100,
                      onChanged: (double value) => {
                        widget.onDragEnd(value, widget.user.id),
                      },
                      activeColor: widget.user.color,
                      inactiveColor: widget.user.color,
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
        child: SizedBox(
          width: 150,
          height: 30,
          child: TextField(
            onTapOutside: (event) => {
              setInputFieldState(user),
            },
            onSubmitted: (newValue) => {
              setInputFieldState(user),
            },
            autofocus: true,
            controller: editingController,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }
    return InkWell(
      onTap: () => {
        setEditingStateOnTrue(user),
      },
      child: Expanded(
          flex: 1,
          child: Column(children: [
            Text(
              user.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ])),
    );
  }
}
