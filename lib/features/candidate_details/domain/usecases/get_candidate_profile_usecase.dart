import 'package:fpdart/fpdart.dart';
import 'package:graduation_project/features/candidate_details/domain/repositories/candidate_details_repository.dart';
import 'package:injectable/injectable.dart';
import '../entities/candidate_profile_entity.dart';
import '../../../../core/error/failures.dart';

@injectable
class GetCandidateProfileUseCase {
  final CandidateRepository _repository;

  GetCandidateProfileUseCase(this._repository);

  Future<Either<Failure, CandidateProfileEntity>> call({
    required String candidateId,
    required String companyId,
  }) {
    return _repository.getCandidateProfile(
      candidateId: candidateId,
      companyId: companyId,
    );
  }
}
