import 'package:equatable/equatable.dart';

class WorkExperienceEntity extends Equatable {
  final String id;
  final String jobTitle;
  final String companyName;
  final String location;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrentlyWorking;
  final String? description; 

  const WorkExperienceEntity({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.startDate,
    this.endDate,
    required this.isCurrentlyWorking,
    this.description,
  });

  @override
  List<Object?> get props => [id, jobTitle, companyName, startDate, endDate];
}
