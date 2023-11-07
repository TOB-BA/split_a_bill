import 'package:first_flutter_project/models/user.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SplitPieChart extends StatelessWidget {
  final List<User> users;

  const SplitPieChart({
    super.key,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          width: 100,
          child: PieChart(
            PieChartData(
              sections: [
                ...users.map(
                  (user) => PieChartSectionData(
                    color: user.color,
                    value: user.sliderValue,
                    title: '${user.sliderValue.round()}%',
                    radius: 50,
                    titleStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              sectionsSpace: 0,
              centerSpaceRadius: 10,
            ),
          ),
        ),
      ],
    );
  }
}
