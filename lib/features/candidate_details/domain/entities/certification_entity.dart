// domain/entities/certification_entity.dart
import 'package:equatable/equatable.dart';

class CertificationEntity extends Equatable {
  final String id;
  final String name;
  final String issuingInstitution;
  final DateTime issueDate;
  final DateTime? expirationDate;
  final String? credentialUrl;

  const CertificationEntity({
    required this.id,
    required this.name,
    required this.issuingInstitution,
    required this.issueDate,
    this.expirationDate,
    this.credentialUrl,
  });

  @override
  List<Object?> get props => [id, name, issuingInstitution];
}
