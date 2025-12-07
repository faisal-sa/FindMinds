// data/models/education_model.dart
import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/education_entity.dart';

part 'education_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class EducationModel extends EducationEntity with EducationModelMappable {
  const EducationModel({
    required super.id,
    required super.institutionName,
    required super.degreeType,
    required super.fieldOfStudy,
    required super.startDate,
    super.endDate,
  });
}
