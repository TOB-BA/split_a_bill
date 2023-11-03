import 'package:first_flutter_project/models/user.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChart1 extends StatelessWidget {
  final List<User> users;

  const PieChart1({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sections: [
                ...users.map(
                  (user) => PieChartSectionData(
                    color: user.color,
                    value: user.sliderValue,
                    title: '${user.sliderValue.round()}%',
                    radius: 50,
                    titleStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
