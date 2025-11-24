import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/feature_card.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/locked_feature_card.dart';

class UserProfile extends Equatable {
  final String? name;

  const UserProfile({this.name});

  bool get isComplete => name != null && name!.isNotEmpty;

  int get progress => isComplete ? 35 : 5;

  @override
  List<Object?> get props => [name];
}

class UserCubit extends Cubit<UserProfile> {
  UserCubit() : super(const UserProfile(name: null));

  void uploadResume() {
    emit(const UserProfile(name: "Alex Johnson"));
  }

  void resetProfile() {
    emit(const UserProfile(name: null));
  }
}
