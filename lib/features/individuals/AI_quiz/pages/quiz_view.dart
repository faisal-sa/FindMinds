import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/AI_quiz/cubit/ai_skill_check_cubit.dart';
import 'package:graduation_project/features/individuals/AI_quiz/models/quiz_question.dart';

class QuizView extends StatefulWidget {
  final List<QuizQuestion> questions;

  const QuizView({super.key, required this.questions});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  int _currentIndex = 0;
  late List<int?> _userAnswers;
  
  // Timer dummy implementation for visual
  int _secondsRemaining = 120; 

  @override
  void initState() {
    super.initState();
    _userAnswers = List.filled(widget.questions.length, null);
  }

  void _onOptionSelected(int index) {
    setState(() {
      _userAnswers[_currentIndex] = index;
    });
  }

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Submit
      context.read<AiSkillCheckCubit>().submitQuizAnswers(_userAnswers);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentIndex];
    final selectedOption = _userAnswers[_currentIndex];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Question Counter & Timer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Question ${_currentIndex + 1}/${widget.questions.length}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer, size: 16, color: Colors.red.shade400),
                    const SizedBox(width: 4),
                    Text(
                      "01:25", // Static for UI demo, can implement Timer logic
                      style: TextStyle(
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 32),

          // Question Text
          Text(
            question.question,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 32),

          // Options
          Expanded(
            child: ListView.separated(
              itemCount: question.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final isSelected = selectedOption == index;
                final optionLabel = String.fromCharCode(65 + index); // A, B, C, D

                return GestureDetector(
                  onTap: () => _onOptionSelected(index),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFE3F2FD) : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            optionLabel,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: const TextStyle(fontSize: 15, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Next Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: selectedOption != null ? _nextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: Colors.grey.shade300,
              ),
              child: Text(
                _currentIndex == widget.questions.length - 1 ? "Finish" : "Next",
                style: const TextStyle(
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
}