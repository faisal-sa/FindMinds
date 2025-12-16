import 'package:graduation_project/features/individuals/engagement/data/datasources/engagement_remote_data_source.dart';
import 'package:graduation_project/features/individuals/engagement/data/models/engagement_stats_model.dart';
import 'package:graduation_project/features/individuals/engagement/domain/entities/engagement_stats.dart';
import 'package:graduation_project/features/individuals/engagement/domain/repositories/engagement_repository.dart';

class EngagementRepositoryImpl implements EngagementRepository {
  final EngagementRemoteDataSource dataSource;
  EngagementRepositoryImpl({required this.dataSource});

  @override
  Stream<EngagementStatsModel> getEngagementStatsStream() {
    return dataSource.getStatsStream();
  }
}