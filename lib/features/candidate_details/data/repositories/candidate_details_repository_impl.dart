
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/candidate_profile_entity.dart';
import '../../domain/repositories/candidate_details_repository.dart';
import '../data_sources/candidate_details_data_source.dart';

@LazySingleton(as: CandidateRepository)
class CandidateRepositoryImpl implements CandidateRepository {
  final CandidateRemoteDataSource _remoteDataSource;

  CandidateRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CandidateProfileEntity>> getCandidateProfile({
    required String candidateId,
    required String companyId,
  }) async {
    try {
      final profileModel = await _remoteDataSource.getCandidateProfile(
        candidateId,
        companyId,
      );
      return Right(profileModel);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlockCandidateProfile({
    required String candidateId,
    required String companyId,
  }) async {
    try {
      await _remoteDataSource.unlockCompanyAccess(companyId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleBookmark({
    required String candidateId,
    required String companyId,
  }) async {
    try {
      await _remoteDataSource.toggleBookmark(candidateId, companyId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
