import 'package:graduation_project/features/individuals/engagement/domain/entities/engagement_stats.dart';

abstract class EngagementState {}

class EngagementInitial extends EngagementState {}

class EngagementLoading extends EngagementState {}

class EngagementLoaded extends EngagementState {
  final EngagementStats stats;
  EngagementLoaded(this.stats);
}

class EngagementError extends EngagementState {
  final String message;
  EngagementError(this.message);
}

