import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/certification.dart';
import '../../domain/repositories/certification_repository.dart';
import '../datasources/certification_remote_data_source.dart';
import '../models/certification_model.dart';

@LazySingleton(as: CertificationRepository)
class CertificationRepositoryImpl implements CertificationRepository {
  final CertificationRemoteDataSource _remoteDataSource;
  final SupabaseClient _client;

  CertificationRepositoryImpl(this._remoteDataSource, this._client);

  @override
  Future<List<Certification>> getCertifications() async {
    try {
      final models = await _remoteDataSource.getCertifications();
      
      return models.map((model) => model.toEntity()).toList(); 
      
    } catch (e) {
      throw Exception('Failed to fetch certifications: $e');
    }
  }

  @override
Future<Certification> addCertification(Certification certification) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) throw Exception("User not authenticated");

      String? uploadedUrl;

    
      final model = CertificationModel.fromEntity(
        certification,
        userId,
        uploadedUrl: uploadedUrl, 
      );

      final savedModel = await _remoteDataSource.addCertification(model);

      return savedModel.toEntity(); 
    } catch (e) {
      throw Exception('Failed to add certification: $e');
    }
  }

  @override
  Future<void> updateCertification(Certification certification) async {
    try {
      final userId = _client.auth.currentUser?.id;
      if (userId == null) throw Exception("User not authenticated");

      String? uploadedUrl = certification.credentialUrl;

     
      final model = CertificationModel.fromEntity(
        certification,
        userId,
        uploadedUrl: uploadedUrl,
      );

      await _remoteDataSource.updateCertification(model);
    } catch (e) {
      throw Exception('Failed to update certification: $e');
    }
  }

  @override
  Future<void> deleteCertification(String id) async {
    try {
      await _remoteDataSource.deleteCertification(id);
    } catch (e) {
      throw Exception('Failed to delete certification: $e');
    }
  }
}
