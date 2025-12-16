import 'package:equatable/equatable.dart';

class QuizQuestion extends Equatable {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String category; 

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.category,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      question: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctIndex: map['correctIndex'] ?? 0,
      category: map['category'] ?? 'General',
    );
  }

  @override
  List<Object> get props => [question, options, correctIndex, category];
}
