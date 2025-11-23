import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/profile/domain/entities/certification.dart';
import 'package:graduation_project/features/profile/domain/entities/education.dart';
import 'package:graduation_project/features/profile/domain/entities/work_experience.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  final ImagePicker _picker = ImagePicker();
  final PageController pageController = PageController();

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        emit(state.copyWith(image: File(pickedFile.path)));
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void nextPage() {
    if (state.currentPage < 2) {
      int next = state.currentPage + 1;
      emit(state.copyWith(currentPage: next));
      pageController.jumpToPage(next);
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      int prev = state.currentPage - 1;
      emit(state.copyWith(currentPage: prev));
      pageController.jumpToPage(prev);
    }
  }

  void updateSkills(List<String> newSkills) {
    emit(state.copyWith(skills: newSkills));
  }

  void removeSkill(String skill) {
    final currentSkills = List<String>.from(state.skills);
    currentSkills.remove(skill);
    emit(state.copyWith(skills: currentSkills));
  }

  void addWorkExperience(WorkExperience experience) {
    final updatedList = List<WorkExperience>.from(state.experiences)
      ..add(experience);
    updatedList.sort((a, b) => b.startDate.compareTo(a.startDate));
    emit(state.copyWith(experiences: updatedList));
  }

  void removeWorkExperience(String id) {
    final updatedList = List<WorkExperience>.from(state.experiences)
      ..removeWhere((element) => element.id == id);
    emit(state.copyWith(experiences: updatedList));
  }

  void addEducation(Education education) {
    final updatedList = List<Education>.from(state.educations)..add(education);
    updatedList.sort((a, b) => b.endDate.compareTo(a.endDate));
    emit(state.copyWith(educations: updatedList));
  }

  void removeEducation(String id) {
    final updatedList = List<Education>.from(state.educations)
      ..removeWhere((element) => element.id == id);
    emit(state.copyWith(educations: updatedList));
  }

  void addCertification(Certification certification) {
    final updatedList = List<Certification>.from(state.certifications)
      ..add(certification);
    updatedList.sort((a, b) => b.issueDate.compareTo(a.issueDate));
    emit(state.copyWith(certifications: updatedList));
  }

  void removeCertification(String id) {
    final updatedList = List<Certification>.from(state.certifications)
      ..removeWhere((element) => element.id == id);
    emit(state.copyWith(certifications: updatedList));
  }

  Future<void> pickVideo() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 30),
      );

      if (pickedFile != null) {
        emit(state.copyWith(video: File(pickedFile.path)));
      }
    } catch (e) {
      debugPrint('Error picking video: $e');
    }
  }

  void removeVideo() {
    emit(state.copyWith(clearVideo: true));
  }

  void updateAboutMe(String description) {
    emit(state.copyWith(aboutMe: description));
  }

  void toggleEmploymentType(String type) {
    final currentList = List<String>.from(state.selectedEmploymentTypes);
    if (currentList.contains(type)) {
      currentList.remove(type);
    } else {
      currentList.add(type);
    }
    emit(state.copyWith(selectedEmploymentTypes: currentList));
  }

  void updateRelocation(bool value) {
    emit(state.copyWith(canRelocate: value));
  }

  void updateStartImmediately(bool value) {
    emit(state.copyWith(canStartImmediately: value));
  }
}

extension CubitContextExtension on BuildContext {
  Future<void> Function() get pickImage => read<ProfileCubit>().pickImage;
}
