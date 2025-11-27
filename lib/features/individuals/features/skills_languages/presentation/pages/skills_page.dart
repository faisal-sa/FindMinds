import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/presentation/cubit/skills_languages_cubit.dart';
import 'package:graduation_project/features/individuals/features/skills_languages/presentation/cubit/skills_languages_state.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          serviceLocator<SkillsLanguagesCubit>()..loadProfile(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit Skills & Languages")),
        body: BlocConsumer<SkillsLanguagesCubit, SkillsLanguagesState>(
          listener: (context, state) {
            if (state is SkillsLanguagesError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is SkillsLanguagesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SkillsLanguagesLoaded) {
              return _buildBody(context, state.skillsLanguages);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, dynamic profile) {
    final skillController = TextEditingController();
    final langController = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- SKILLS SECTION ---
          const Text(
            "Skills",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8.0,
            children: profile.skills.map<Widget>((skill) {
              return Chip(label: Text(skill));
              // Add onDeleted: () => context.read<SkillsLanguagesCubit>().removeSkill(skill)
            }).toList(),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: skillController,
                  decoration: const InputDecoration(hintText: "Add Skill"),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (skillController.text.isNotEmpty) {
                    context.read<SkillsLanguagesCubit>().addSkill(
                      skillController.text,
                    );
                    skillController.clear();
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // --- LANGUAGES SECTION ---
          const Text(
            "Languages",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8.0,
            children: profile.languages.map<Widget>((lang) {
              return Chip(label: Text(lang));
            }).toList(),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: langController,
                  decoration: const InputDecoration(hintText: "Add Language"),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (langController.text.isNotEmpty) {
                    context.read<SkillsLanguagesCubit>().addLanguage(
                      langController.text,
                    );
                    langController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
