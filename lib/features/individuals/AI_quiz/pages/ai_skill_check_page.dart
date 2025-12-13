import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/individuals/AI_quiz/cubit/ai_skill_check_cubit.dart';
import 'package:graduation_project/features/individuals/AI_quiz/cubit/ai_skill_check_state.dart';
import 'package:graduation_project/features/individuals/AI_quiz/pages/quiz_view.dart';
import 'package:graduation_project/features/individuals/AI_quiz/pages/result_view.dart';
import 'package:graduation_project/features/individuals/AI_quiz/widgets/modren_loading.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
class AiSkillCheckPage extends StatelessWidget {
  final UserEntity user;

  const AiSkillCheckPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiSkillCheckCubit()..generateQuiz(user),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "AI Skill Check",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // Actions removed as requested
        ),
        body: BlocBuilder<AiSkillCheckCubit, AiSkillCheckState>(
          builder: (context, state) {
            if (state is AiSkillCheckLoading) {
              // Using the custom loader here
              return const ModernAnalysisLoader();
            } else if (state is AiSkillCheckError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(state.message, textAlign: TextAlign.center),
                ),
              );
            } else if (state is AiSkillCheckQuestionsLoaded) {
              return QuizView(questions: state.questions);
            } else if (state is AiSkillCheckCompleted) {
              return ResultView(
                score: state.totalScore,
                breakdown: state.breakdown,
                onRetake: () {
                  context.read<AiSkillCheckCubit>().generateQuiz(user);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}