import 'dart:io';

class Certification {
  final String id;
  final String name;
  final String issuingInstitution;
  final DateTime issueDate;
  final DateTime? expirationDate;
  final File? credentialFile;

  Certification({
    required this.id,
    required this.name,
    required this.issuingInstitution,
    required this.issueDate,
    this.expirationDate,
    this.credentialFile,
  });
}
