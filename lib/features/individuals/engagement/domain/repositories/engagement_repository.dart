import 'package:graduation_project/features/individuals/engagement/domain/entities/engagement_stats.dart';

abstract class EngagementRepository {
  Stream<EngagementStats> getEngagementStatsStream();
}