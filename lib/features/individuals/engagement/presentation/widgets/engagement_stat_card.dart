import 'package:flutter/material.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/feature_card.dart';

class EngagementStatCard extends StatelessWidget {
  final String label;
  final String count;
  final IconData icon;

  const EngagementStatCard({
    super.key,
    required this.label,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.bluePrimary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.bluePrimary, size: 24),
          ),
          const SizedBox(height: 20),
          Text(
            count,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textSub, height: 1.4),
          ),
        ],
      ),
    );
  }
}