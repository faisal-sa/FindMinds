class EngagementStats {
  final int searchAppearances;
  final int profileViews;
  final List<double> weeklyTraffic; // 7 days of data

  const EngagementStats({
    required this.searchAppearances,
    required this.profileViews,
    required this.weeklyTraffic,
  });
}
