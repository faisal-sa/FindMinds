import 'package:equatable/equatable.dart';

class SkillCategoryResult extends Equatable {
  final String category;
  final int scorePercentage;
  final String status; // Strong, Proficient, Needs Improvement

  const SkillCategoryResult({
    required this.category,
    required this.scorePercentage,
    required this.status,
  });

  @override
  List<Object> get props => [category, scorePercentage, status];
}
