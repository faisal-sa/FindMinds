part of 'profile_cubit.dart';

@immutable
class ProfileState extends Equatable {
  final File? image;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String location;

  const ProfileState({
    this.image,
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.location = '',
  });

  ProfileState copyWith({
    File? image,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? location,
  }) {
    return ProfileState(
      image: image ?? this.image,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
    );
  }

  @override
  bool get stringify => true;
  @override
  List<Object?> get props => [image, fullName, email, phoneNumber, location];
}
