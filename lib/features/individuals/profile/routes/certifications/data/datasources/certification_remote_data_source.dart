import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/certification_model.dart';

abstract class CertificationRemoteDataSource {
  Future<List<CertificationModel>> getCertifications();
  Future<CertificationModel> addCertification(CertificationModel model);
  Future<void> updateCertification(CertificationModel model);
  Future<void> deleteCertification(String id);
  Future<String> uploadCredentialFile(File file, String userId);
}

@LazySingleton(as: CertificationRemoteDataSource)
class CertificationRemoteDataSourceImpl
    implements CertificationRemoteDataSource {
  final SupabaseClient _client;
  static const String _bucketName = 'certification_files';

  CertificationRemoteDataSourceImpl(this._client);

  @override
  Future<List<CertificationModel>> getCertifications() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception("User not authenticated");

    final response = await _client
        .from('certifications')
        .select()
        .eq('user_id', userId)
        .order('issue_date', ascending: false);

    return (response as List)
        .map((e) => CertificationModel.fromJson(e))
        .toList();
  }

  @override
  Future<CertificationModel> addCertification(CertificationModel model) async {
    final data = model.toJson();
    if (model.id.isEmpty) {
      data.remove('id');
    }

    final response = await _client
        .from('certifications')
        .insert(data)
        .select()
        .single();

    CertificationModel insertedModel = CertificationModel.fromJson(response);

    if (model.credentialFile != null) {
      final userId = _client.auth.currentUser!.id;

      final String publicUrl = await uploadCredentialFile(
        model.credentialFile!,
        userId,
      );

      await _client
          .from('certifications')
          .update({'credential_url': publicUrl})
          .eq('id', insertedModel.id);

      insertedModel = insertedModel.copyWith(credentialUrl: publicUrl);
    }

    return insertedModel;
  }
  @override
  Future<void> updateCertification(CertificationModel model) async {
  
    final oldRecord = await _client
        .from('certifications')
        .select('credential_url')
        .eq('id', model.id)
        .single();

    final String? oldUrl = oldRecord['credential_url'];
    
    String? finalUrl = model.credentialUrl;

    if (model.credentialFile != null) {
      final userId = _client.auth.currentUser!.id;
      
      finalUrl = await uploadCredentialFile(model.credentialFile!, userId);

      if (oldUrl != null && oldUrl.isNotEmpty) {
        final oldPath = _extractPathFromUrl(oldUrl);
        if (oldPath != null) {
          await _client.storage.from(_bucketName).remove([oldPath]);
        }
      }
    }
    else if (model.credentialUrl == null && oldUrl != null) {
      final oldPath = _extractPathFromUrl(oldUrl);
      if (oldPath != null) {
        await _client.storage.from(_bucketName).remove([oldPath]);
      }
      finalUrl = null;
    }
   
    final data = model.toJson();
    data['credential_url'] = finalUrl; 
    data.remove('id');

    await _client
        .from('certifications')
        .update(data).eq('id', model.id);
  }
  @override
  Future<void> deleteCertification(String id) async {
    try {
      final record = await _client
          .from('certifications')
          .select('credential_url')
          .eq('id', id)
          .single();

      final String? fileUrl = record['credential_url'];

      if (fileUrl != null && fileUrl.isNotEmpty) {
        final path = _extractPathFromUrl(fileUrl);

        if (path != null) {
          
          final List<FileObject> result = await _client.storage
              .from(_bucketName)
              .remove([path]);

          if (result.isEmpty) {
            debugPrint(
              'Warning: Storage file deletion returned empty. Check Path: $path or RLS policies.',
            );
          }
        }
      }

      await _client.from('certifications').delete().eq('id', id);
      
    } catch (e) {
     
      throw Exception("Error deleting certification: $e");
    }
  }

  String? _extractPathFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      final bucketIndex = segments.indexOf(_bucketName);

      if (bucketIndex != -1 && bucketIndex < segments.length - 1) {
        final rawPath = segments.sublist(bucketIndex + 1).join('/');

        
        return Uri.decodeComponent(rawPath);
      }
      return null;
    } catch (e) {
      debugPrint("Error parsing URL: $e");
      return null;
    }
  }

  @override
  Future<String> uploadCredentialFile(File file, String userId) async {
    final fileExt = file.path.split('.').last;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final filePath = '$userId/$fileName';

    await _client.storage.from(_bucketName).upload(filePath, file);

    final publicUrl = _client.storage
        .from(_bucketName)
        .getPublicUrl(filePath);

    return publicUrl;
  }

 
}
