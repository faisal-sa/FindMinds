import 'package:equatable/equatable.dart';
import 'package:graduation_project/features/individuals/AI_quiz/models/quiz_question.dart';
import 'package:graduation_project/features/individuals/AI_quiz/models/skill_category_result.dart';

abstract class AiSkillCheckState extends Equatable {
  const AiSkillCheckState();
  @override
  List<Object> get props => [];
}

class AiSkillCheckInitial extends AiSkillCheckState {}

class AiSkillCheckLoading extends AiSkillCheckState {}

class AiSkillCheckQuestionsLoaded extends AiSkillCheckState {
  final List<QuizQuestion> questions;
  const AiSkillCheckQuestionsLoaded(this.questions);
  @override
  List<Object> get props => [questions];
}

class AiSkillCheckCompleted extends AiSkillCheckState {
  final int totalScore; // 0-100
  final List<SkillCategoryResult> breakdown;

  const AiSkillCheckCompleted({required this.totalScore, required this.breakdown});
  @override
  List<Object> get props => [totalScore, breakdown];
}

class AiSkillCheckError extends AiSkillCheckState {
  final String message;
  const AiSkillCheckError(this.message);
  @override
  List<Object> get props => [message];
}