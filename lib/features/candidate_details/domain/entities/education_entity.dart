// domain/entities/education_entity.dart
import 'package:equatable/equatable.dart';

class EducationEntity extends Equatable {
  final String id;
  final String institutionName;
  final String degreeType;
  final String fieldOfStudy;
  final DateTime startDate;
  final DateTime? endDate;

  const EducationEntity({
    required this.id,
    required this.institutionName,
    required this.degreeType,
    required this.fieldOfStudy,
    required this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [id, institutionName, degreeType];
}
