import 'package:graduation_project/features/individuals/profile/routes/certifications/domain/entities/certification.dart';

abstract class CertificationRepository {
  Future<List<Certification>> getCertifications();
Future<Certification> addCertification(Certification certification);
  Future<void> updateCertification(Certification certification);
  Future<void> deleteCertification(String id);
}
