part of 'basic_info_cubit.dart';

enum FormStatus { initial, loading, success, failure }

class BasicInfoState extends Equatable {
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String phoneNumber;
  final String email;
  final String location;
  final FormStatus status;

  const BasicInfoState({
    this.firstName = '',
    this.lastName = '',
    this.jobTitle = '',
    this.phoneNumber = '',
    this.email = '',
    this.location = '',
    this.status = FormStatus.initial,
  });

  BasicInfoState copyWith({
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? phoneNumber,
    String? email,
    String? location,
    FormStatus? status,
  }) {
    return BasicInfoState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobTitle: jobTitle ?? this.jobTitle,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      location: location ?? this.location,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
    firstName,
    lastName,
    jobTitle,
    phoneNumber,
    email,
    location,
    status,
  ];
}
