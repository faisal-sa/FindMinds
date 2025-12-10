import 'package:graduation_project/features/individuals/engagement/domain/entities/engagement_stats.dart';

class EngagementStatsModel extends EngagementStats {
  const EngagementStatsModel({
    required super.searchAppearances,
    required super.profileViews,
    required super.weeklyTraffic,
  });

  factory EngagementStatsModel.fromJson(Map<String, dynamic> json) {
    return EngagementStatsModel(
      searchAppearances: json['search_appearances'] ?? 0,
      profileViews: json['profile_views'] ?? 0,
      weeklyTraffic: List<double>.from(
          (json['weekly_traffic'] ?? []).map((x) => x.toDouble())),
    );
  }
}
