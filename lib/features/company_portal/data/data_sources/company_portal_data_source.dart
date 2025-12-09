// lib/features/company_portal/data/data_sources/company_remote_data_source.dart
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseException implements Exception {
  final String message;
  SupabaseException(this.message);

  @override
  String toString() => 'SupabaseException: $message';
}

@LazySingleton()
class CompanyRemoteDataSource {
  final SupabaseClient supabase;
  CompanyRemoteDataSource(this.supabase);

  T _handleSupabaseCall<T>(Function() call) {
    try {
      return call();
    } on PostgrestException catch (e) {
      throw SupabaseException(e.message ?? 'A database error occurred.');
    } on AuthException catch (e) {
      throw SupabaseException(e.message ?? 'An authentication error occurred.');
    } on SupabaseException {
      rethrow;
    } catch (e) {
      throw SupabaseException('An unexpected error occurred: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> registerCompany(
    String email,
    String password,
  ) async {
    return await _handleSupabaseCall(() async {
      final authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = authResponse.user;
      if (user == null || user.id.isEmpty) {
        throw SupabaseException(
          'No valid user ID. Please verify signup and retry.',
        );
      }
      final response = await supabase
          .from('companies')
          .insert({
            'user_id': user.id,
            'email': email,
            'company_name': 'Untitled Company',
            'industry': '',
          })
          .select('*')
          .single();
      return Map<String, dynamic>.from(response);
    });
  }

  Future<Map<String, dynamic>?> getCompanyProfile(String userId) async {
    return await _handleSupabaseCall(() async {
      if (userId.isEmpty) {
        throw SupabaseException('Invalid userId: cannot be empty.');
      }

      final result = await supabase
          .from('companies')
          .select()
          .eq('user_id', userId)
          .maybeSingle();
      return result == null ? null : Map<String, dynamic>.from(result);
    });
  }

  Future<Map<String, dynamic>> updateCompanyProfile(
    Map<String, dynamic> data,
  ) async {
    return await _handleSupabaseCall(() async {
      if (supabase.auth.currentUser!.id.isEmpty) {
        throw SupabaseException('Invalid company ID: cannot be empty.');
      }

      data.addAll({
        'id': supabase.auth.currentUser!.id,
        'user_id': supabase.auth.currentUser!.id,
      });
      final result = await supabase
          .from('companies')
          .upsert(data)
          .eq('user_id', supabase.auth.currentUser!.id)
          .select()
          .single();
      return result;
    });
  }

  Future<Map<String, dynamic>> checkCompanyStatus(String userId) async {
    return await _handleSupabaseCall(() async {
      final client = supabase;
      bool hasProfile = false;
      bool hasPaid = false;

      final companyResponse = await client
          .from('companies')
          .select('id, industry')
          .eq('user_id', userId)
          .maybeSingle();

      if (companyResponse != null) {
        final industry = companyResponse['industry'] as String?;

        if (industry != null &&
            industry.trim().isNotEmpty &&
            industry != 'Pending') {
          hasProfile = true;
        } else {
          hasProfile = false;
        }
      }

      final companyId = companyResponse?['id'] as String?;
      if (companyId != null) {}

      return {'hasProfile': hasProfile, 'hasPaid': hasPaid};
    });
  }

  Future<void> verifyCompanyQR(String qrCodeData) async {
    return await _handleSupabaseCall(() async {
      await supabase.rpc('verify_company_qr', params: {'qr_data': qrCodeData});
    });
  }
}
