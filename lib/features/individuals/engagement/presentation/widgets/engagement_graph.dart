import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/theme.dart';

class EngagementGraph extends StatelessWidget {
  final List<double> dataPoints;

  const EngagementGraph({super.key, required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Profile Traffic",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Icon(Icons.bar_chart, color: AppColors.bluePrimary),
            ],
          ),
          const SizedBox(height: 16),
          // Bar Chart Area
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(dataPoints.length, (index) {
                return Container(
                  width: 30,
                  height: dataPoints[index],
                  decoration: BoxDecoration(
                    // Highlight the highest bar or specific day
                    color: index == 5 ? AppColors.bluePrimary : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          // Days Label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((day) => Text(
              day,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            )).toList(),
          ),
        ],
      ),
    );
  }
}