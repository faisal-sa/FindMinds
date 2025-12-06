import 'dart:async';

import 'package:graduation_project/features/individuals/engagement/data/models/engagement_stats_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class EngagementRemoteDataSource {
  Stream<EngagementStatsModel> getStatsStream();
}

class EngagementRemoteDataSourceImpl implements EngagementRemoteDataSource {
  final SupabaseClient supabase;

  EngagementRemoteDataSourceImpl({required this.supabase});

  @override
  Stream<EngagementStatsModel> getStatsStream() async* {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");

    // 1. Yield the initial data immediately (so the user sees data right away)
    yield await _fetchFromRpc();

    // 2. Create a Realtime Channel to listen for updates
    final channel = supabase.channel('public:daily_engagement_stats:$userId');

    // 3. Listen to UPDATE and INSERT events on this table for this specific User
    final streamController = StreamController<EngagementStatsModel>();

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all, // Listen to INSERT and UPDATE
          schema: 'public',
          table: 'daily_engagement_stats',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'user_id',
            value: userId,
          ),
          callback: (payload) async {
            // When a change happens, re-fetch the aggregated stats
            try {
              final newStats = await _fetchFromRpc();
              streamController.add(newStats);
            } catch (e) {
              print("Error refreshing realtime stats: $e");
            }
          },
        )
        .subscribe();

    // 4. Yield values coming from the realtime listener
    yield* streamController.stream;
  }

  // Helper method to call the RPC
  Future<EngagementStatsModel> _fetchFromRpc() async {
    final response = await supabase.rpc('get_my_engagement_stats');
    
    List<double> parseWeeklyTraffic(dynamic traffic) {
        if (traffic == null) return List.filled(7, 0.0);
        return (traffic as List).map((e) => (e as num).toDouble()).toList();
    }

    return EngagementStatsModel(
      searchAppearances: response['search_appearances'] ?? 0,
      profileViews: response['profile_views'] ?? 0,
      weeklyTraffic: parseWeeklyTraffic(response['weekly_traffic']),
    );
  }
}