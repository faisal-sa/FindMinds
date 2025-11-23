part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable {
  final File? image;
  final File? video;
  final String aboutMe;

  final List<String> selectedEmploymentTypes;
  final bool canRelocate;
  final bool canStartImmediately;

  final String fullName;
  final String email;
  final String phoneNumber;
  final String location;
  final int currentPage;
  final List<String> skills;
  final List<WorkExperience> experiences;
  final List<Education> educations;
  final List<Certification> certifications;

  const ProfileState({
    this.image,
    this.video,
    this.aboutMe = '',
    this.selectedEmploymentTypes = const [],
    this.canRelocate = false,
    this.canStartImmediately = false,
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.location = '',
    this.currentPage = 0,
    this.skills = const [],
    this.experiences = const [],
    this.educations = const [],
    this.certifications = const [],
  });

  ProfileState copyWith({
    File? image,
    File? video,
    bool clearVideo = false,
    String? aboutMe,
    List<String>? selectedEmploymentTypes,
    bool? canRelocate,
    bool? canStartImmediately,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? location,
    int? currentPage,
    List<String>? skills,
    List<WorkExperience>? experiences,
    List<Education>? educations,
    List<Certification>? certifications,
  }) {
    return ProfileState(
      image: image ?? this.image,
      video: clearVideo ? null : (video ?? this.video),
      aboutMe: aboutMe ?? this.aboutMe,
      selectedEmploymentTypes:
          selectedEmploymentTypes ?? this.selectedEmploymentTypes,
      canRelocate: canRelocate ?? this.canRelocate,
      canStartImmediately: canStartImmediately ?? this.canStartImmediately,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      currentPage: currentPage ?? this.currentPage,
      skills: skills ?? this.skills,
      experiences: experiences ?? this.experiences,
      educations: educations ?? this.educations,
      certifications: certifications ?? this.certifications,
    );
  }

  @override
  List<Object?> get props => [
    image,
    video,
    aboutMe,
    selectedEmploymentTypes,
    canRelocate,
    canStartImmediately,
    fullName,
    email,
    phoneNumber,
    location,
    currentPage,
    skills,
    experiences,
    educations,
    certifications,
  ];
}
