// lib/features/company_portal/domain/usecases/verify_company_qr.dart
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../repositories/company_portal_repository.dart';

@injectable
class VerifyCompanyQR {
  final CompanyRepository _repository;

  VerifyCompanyQR(this._repository);

  /// Calls the repository to verify the company using QR code data (token).
  Future<Result<void, Failure>> call(String qrCodeData) async {
    // Note: The repository implementation must be updated to call the remote data source.
    return await _repository.verifyCompanyQR(qrCodeData);
  }
}
