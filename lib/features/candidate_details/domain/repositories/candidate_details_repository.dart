// lib/features/candidate_details/domain/repositories/candidate_repository.dart
import 'package:fpdart/fpdart.dart';
import '../entities/candidate_profile_entity.dart';

import '../../../../core/error/failures.dart';

abstract class CandidateRepository {
  Future<Either<Failure, CandidateProfileEntity>> getCandidateProfile({
    required String candidateId,
    required String companyId,
  });

  Future<Either<Failure, void>> unlockCandidateProfile({
    required String candidateId,
    required String companyId,
  });
  Future<Either<Failure, void>> toggleBookmark({
    required String candidateId,
    required String companyId,
  });
}
