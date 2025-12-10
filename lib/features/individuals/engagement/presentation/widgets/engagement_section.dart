import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/features/individuals/engagement/data/datasources/engagement_remote_data_source.dart';
import 'package:graduation_project/features/individuals/engagement/data/repositories/engagement_repository_impl.dart';
import 'package:graduation_project/features/individuals/engagement/domain/usecases/get_engagement_stats.dart';
import 'package:graduation_project/features/individuals/engagement/presentation/cubit/engagement_cubit.dart';
import 'package:graduation_project/features/individuals/engagement/presentation/cubit/engagement_state.dart';
import 'package:graduation_project/features/individuals/engagement/presentation/widgets/engagement_graph.dart';
import 'package:graduation_project/features/individuals/engagement/presentation/widgets/engagement_stat_card.dart';
import 'package:graduation_project/features/individuals/insights/presentation/widgets/locked_feature_card.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class EngagementSection extends StatelessWidget {
  final bool isProfileComplete;

  const EngagementSection({super.key, required this.isProfileComplete});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Engagement",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (!isProfileComplete)
          const LockedFeatureCard(
            icon: Icons.trending_up,
            title: "Advanced Analytics",
            unlockText: "Upload resume to track engagement.",
          )
        else
          BlocProvider(
            create: (context) {
              final repository = EngagementRepositoryImpl(dataSource:  EngagementRemoteDataSourceImpl(supabase: serviceLocator.get<SupabaseClient>()));
              final useCase = GetEngagementStats(repository);
              
         return EngagementCubit(
      repository: repository,
    )..subscribeToStats(); 
            },
            child: BlocBuilder<EngagementCubit, EngagementState>(
              builder: (context, state) {
                if (state is EngagementLoading) {
                  return const Center(child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ));
                } else if (state is EngagementLoaded) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: EngagementStatCard(
                              label: "Appeared in searches",
                              count: state.stats.searchAppearances.toString(),
                              icon: Icons.person_search_rounded,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: EngagementStatCard(
                              label: "Profile Views",
                              count: state.stats.profileViews.toString(),
                              icon: Icons.visibility_rounded,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      EngagementGraph(dataPoints: state.stats.weeklyTraffic),
                    ],
                  );
                } else if (state is EngagementError) {
                  return Center(
                    child: Text(
                      state.message, 
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
      ],
    );
  }
}