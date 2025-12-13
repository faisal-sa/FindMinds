import 'package:fl_chart/fl_chart.dart';
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
              // Changed icon to represent a line graph
              Icon(Icons.show_chart, color: AppColors.bluePrimary),
            ],
          ),
          const SizedBox(height: 24), // Increased spacing for the graph
          // LINE CHART AREA
          SizedBox(
            height: 120, // Slightly taller to accommodate line curves
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false), // Clean look, no grid
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        // Map the index (0, 1, 2) to the day string
                        final index = value.toInt();
                        if (index >= 0 && index < days.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              days[index],
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: dataPoints.length.toDouble() - 1,
                minY: 0,
                // Add some buffer to the top Y value so the line doesn't hit the ceiling
                maxY: dataPoints.reduce((a, b) => a > b ? a : b) * 1.2,

                // THE LINE CONFIGURATION
                lineBarsData: [
                  LineChartBarData(
                    spots: dataPoints.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value);
                    }).toList(),
                    isCurved: true, // Smooth bezier curve
                    color: AppColors.bluePrimary, // Matches your theme
                    barWidth: 3,
                    isStrokeCapRound: true,

                    // The dots on the line
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: AppColors.bluePrimary,
                        );
                      },
                    ),

                    // The gradient fill below the line
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.bluePrimary.withOpacity(0.3),
                          AppColors.bluePrimary.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}