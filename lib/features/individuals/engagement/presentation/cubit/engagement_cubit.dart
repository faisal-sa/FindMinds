import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/engagement/data/repositories/engagement_repository_impl.dart';
import 'package:graduation_project/features/individuals/engagement/presentation/cubit/engagement_state.dart';

class EngagementCubit extends Cubit<EngagementState> {
  final EngagementRepositoryImpl repository;
  StreamSubscription? _statsSubscription;

  EngagementCubit({required this.repository}) : super(EngagementInitial());

  void subscribeToStats() {
    emit(EngagementLoading());

    _statsSubscription?.cancel();
    _statsSubscription = repository.getEngagementStatsStream().listen(
      (stats) {
        emit(EngagementLoaded(stats));
      },
      onError: (error) {
        emit(EngagementError("Could not load analytics"));
      },
    );
  }

  @override
  Future<void> close() {
    _statsSubscription?.cancel();
    return super.close();
  }
}