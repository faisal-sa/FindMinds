import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/profile/routes/skills_languages/domain/entities/skills_and_languages_entity.dart';
import 'package:graduation_project/features/individuals/profile/routes/skills_languages/domain/repositories/skills_languages_repository.dart';
import 'package:graduation_project/features/individuals/profile/routes/skills_languages/presentation/cubit/skills_languages_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SkillsLanguagesCubit extends Cubit<SkillsLanguagesState> {
  final SkillsLanguagesRepository _repository;

  SkillsLanguagesCubit(this._repository) : super(SkillsLanguagesInitial());

  void initialize(List<String> skills, List<String> languages) {

    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: '',
          skills: List<String>.from(skills), 
          languages: List<String>.from(languages), 
        ),
      ),
    );
  }

  Future<void> loadProfile() async {
    emit(SkillsLanguagesLoading());
    final result = await _repository.getData();

    result.fold(
      (failure) => emit(SkillsLanguagesError(failure.message)),
      (profile) => emit(SkillsLanguagesLoaded(profile)),
    );
  }


  Future<void> addSkill(String newSkill) async {
    if (state is! SkillsLanguagesLoaded) return;
    
    final currentState = (state as SkillsLanguagesLoaded);
    final currentData = currentState.skillsLanguages;

    if (currentData.skills.contains(newSkill)) return;

    final updatedSkills = List<String>.from(currentData.skills)..add(newSkill);

    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: currentData.id,
          skills: updatedSkills,
          languages: currentData.languages,
        ),
      ),
    );

    final result = await _repository.updateSkills(updatedSkills);

    result.fold(
      (failure) {
        emit(SkillsLanguagesError(failure.message)); 
        emit(currentState);
      },
      (_) {
      },
    );
  }

  Future<void> removeSkill(String skillToRemove) async {
    if (state is! SkillsLanguagesLoaded) return;

    final currentState = (state as SkillsLanguagesLoaded);
    final currentData = currentState.skillsLanguages;

    final updatedSkills = List<String>.from(currentData.skills)
      ..remove(skillToRemove);

    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: currentData.id,
          skills: updatedSkills,
          languages: currentData.languages,
        ),
      ),
    );

    final result = await _repository.updateSkills(updatedSkills);

    result.fold((failure) {
      emit(SkillsLanguagesError(failure.message));
      emit(currentState);
    }, (_) => null);
  }


  Future<void> addLanguage(String newLanguage) async {
    if (state is! SkillsLanguagesLoaded) return;

    final currentState = (state as SkillsLanguagesLoaded);
    final currentData = currentState.skillsLanguages;

    if (currentData.languages.contains(newLanguage)) return;

    final updatedLanguages = List<String>.from(currentData.languages)
      ..add(newLanguage);

    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: currentData.id,
          skills: currentData.skills,
          languages: updatedLanguages,
        ),
      ),
    );

    final result = await _repository.updateLanguages(updatedLanguages);

    result.fold(
      (failure) {
        emit(SkillsLanguagesError(failure.message));
      emit(currentState); 
      },
      (_) => null,
    );
  }

  Future<void> removeLanguage(String languageToRemove) async {
    if (state is! SkillsLanguagesLoaded) return;

    final currentState = (state as SkillsLanguagesLoaded);
    final currentData = currentState.skillsLanguages;

    final updatedLanguages = List<String>.from(currentData.languages)
      ..remove(languageToRemove);

    emit(
      SkillsLanguagesLoaded(
        SkillsAndLanguages(
          id: currentData.id,
          skills: currentData.skills,
          languages: updatedLanguages,
        ),
      ),
    );

    final result = await _repository.updateLanguages(updatedLanguages);

    result.fold((failure) {
      emit(SkillsLanguagesError(failure.message));
      emit(currentState);
    }, (_) => null);
  }
}
