import 'package:graduation_project/features/individuals/engagement/domain/entities/engagement_stats.dart';
import 'package:graduation_project/features/individuals/engagement/domain/repositories/engagement_repository.dart';

class GetEngagementStats {
  final EngagementRepository repository;

  GetEngagementStats(this.repository);

  Stream<EngagementStats> call() {
    return repository.getEngagementStatsStream();
  }
}