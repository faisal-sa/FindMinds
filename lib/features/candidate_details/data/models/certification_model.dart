// data/models/certification_model.dart
import 'package:dart_mappable/dart_mappable.dart';
import '../../domain/entities/certification_entity.dart';

part 'certification_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class CertificationModel extends CertificationEntity
    with CertificationModelMappable {
  const CertificationModel({
    required super.id,
    required super.name,
    required super.issuingInstitution,
    required super.issueDate,
    super.expirationDate,
    super.credentialUrl,
  });
}
