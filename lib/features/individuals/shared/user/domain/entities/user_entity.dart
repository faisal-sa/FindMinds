
import 'package:graduation_project/features/individuals/profile/routes/certifications/domain/entities/certification.dart';
import 'package:graduation_project/features/individuals/profile/routes/education/domain/entities/education.dart';
import 'package:graduation_project/features/individuals/profile/routes/job_preferences/domain/entities/job_preferences_entity.dart';
import 'package:graduation_project/features/individuals/profile/routes/work_experience/domain/entities/work_experience.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

part 'user_entity.g.dart';

Object? _readRoot(Map<dynamic, dynamic> json, String key) => json;

@freezed
abstract class UserEntity with _$UserEntity {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory UserEntity({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String jobTitle,
    @Default('') String phoneNumber,
    @Default('') String email,
    @Default('') String location,
    
    @JsonKey(name: 'about_me') @Default('') String summary,
    @JsonKey(name: 'intro_video_url')
    String? videoUrl, 
    String? avatarUrl,

    @Default([]) List<WorkExperience> workExperiences,
    @Default([]) List<Education> educations,
    @Default([]) List<Certification> certifications,
    
    @Default([]) List<String> skills,
    @Default([]) List<String> languages,

    @JsonKey(readValue: _readRoot)
    @Default(JobPreferencesEntity())
    JobPreferencesEntity jobPreferences,
    
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
