import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    //duplicated with core/utils
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
}

extension CubitContextExtension on BuildContext {
  Future<void> Function() get pickImage => read<ProfileCubit>().pickImage;
}
