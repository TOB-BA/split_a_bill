import 'dart:math' as math;
import 'dart:ui';

import 'package:first_flutter_project/extensions/user_extensions.dart';
import 'package:first_flutter_project/models/user.dart';

class Split {
  List<User> users = <User>[];
  late int numberOfPersons;
  late double bill;
  late double leftToSplit;

  Split(this.numberOfPersons, this.bill) {
    for (int i = 0; i < numberOfPersons; i++) {
      users.add(
        User(
          id: i,
          name: "User ${i + 1}",
          priceToPay: 0,
          sliderValue: 0.0,
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          isNameInEditMode: false,
        ),
      );
    }

    leftToSplit = bill;
  }

  void calculateLeftToSplit() {
    var calculatedPrice = 0.0;

    for (var user in users) {
      calculatedPrice = calculatedPrice + user.priceToPay;
    }

    leftToSplit = bill - calculatedPrice;
  }

  void calculateLefToPay(double sliderValue, int id) {
    var userOnWhichSliderIsChanged = users.findUserById(id);

    double allPercentages = 0;
    var restOfUsers = users.where((user) => user.id != id);
    for (var user in restOfUsers) {
      allPercentages = allPercentages + user.sliderValue;
    }

    if (allPercentages + sliderValue <= 100 && allPercentages <= 100) {
      userOnWhichSliderIsChanged.sliderValue = sliderValue;
      userOnWhichSliderIsChanged.priceToPay = bill * (sliderValue / 100);

      calculateLeftToSplit();
    } else if (allPercentages < 100 && allPercentages + sliderValue > 100) {
      var newSliderValue = 100 - allPercentages;

      userOnWhichSliderIsChanged.sliderValue = newSliderValue;
      userOnWhichSliderIsChanged.priceToPay = bill * (newSliderValue / 100);

      calculateLeftToSplit();
      return;
    }
  }
}
