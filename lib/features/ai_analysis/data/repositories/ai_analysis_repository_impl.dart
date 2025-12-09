import 'package:graduation_project/features/ai_analysis/data/data_sources/ai_analysis_data_source.dart';
import 'package:graduation_project/features/ai_analysis/domain/repositories/ai_analysis_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../core/error/failures.dart';
import '../models/ai_score_model.dart';

@Injectable(as: AiRepository)
class AiRepositoryImpl implements AiRepository {
  final AiRemoteDataSource _remoteDataSource;

  AiRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<AiScoreModel, Failure>> getAnalysis({
    required Map<String, dynamic> candidateData,
    required Map<String, dynamic> jobRequirements,
  }) async {
    try {
      final result = await _remoteDataSource.analyzeCandidate(
        candidateData: candidateData,
        jobRequirements: jobRequirements,
      );
      return Success(result);
    } catch (e) {
      return Error(ServerFailure(e.toString()));
    }
  }
}
