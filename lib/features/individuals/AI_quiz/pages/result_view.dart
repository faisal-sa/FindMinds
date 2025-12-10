import 'package:flutter/material.dart';
import 'package:graduation_project/features/individuals/AI_quiz/models/skill_category_result.dart';

class ResultView extends StatelessWidget {
  final int score;
  final List<SkillCategoryResult> breakdown;
  final VoidCallback onRetake;

  const ResultView({
    super.key,
    required this.score,
    required this.breakdown,
    required this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Header Section
          const Text(
            "AI Skill Check",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Completed on ${DateTime.now().toString().split(' ')[0]}",
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 32),

          // Circular Score (Custom build for simplicity)
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "$score%",
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF212121),
                    ),
                  ),
                  Text(
                    score >= 70 ? "Proficient" : "Keep Learning",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Text(
            "Excellent work! You've shown strong proficiency in several key areas.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF455A64), height: 1.5),
          ),
          const SizedBox(height: 32),

          // Detailed Breakdown
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Detailed Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),

          // List of Skills
          ...breakdown.map((item) => _buildSkillCard(item)),

          const SizedBox(height: 32),
          
          // Retake Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onRetake,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Retake Quiz",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(SkillCategoryResult item) {
    Color iconBg;
    Color iconColor;
    IconData icon;

    // Style logic based on status
    if (item.status == "Strong") {
      iconBg = Colors.green.shade50;
      iconColor = Colors.green;
      icon = Icons.check_circle_outline;
    } else if (item.status == "Proficient") {
      iconBg = Colors.blue.shade50;
      iconColor = Colors.blue;
      icon = Icons.emoji_events_outlined;
    } else {
      iconBg = Colors.orange.shade50;
      iconColor = Colors.orange;
      icon = Icons.error_outline;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  item.status,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${item.scorePercentage}%",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF212121),
            ),
          ),
        ],
      ),
    );
  }
}