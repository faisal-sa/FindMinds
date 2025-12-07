import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/candidate_details_repository.dart';
import 'candidate_details_state.dart';

@injectable
class CandidateProfileCubit extends Cubit<CandidateProfileState> {
  final CandidateRepository _repository;

  CandidateProfileCubit(this._repository)
    : super(const CandidateProfileState.loading());

  Future<void> loadProfile(String candidateId, String companyId) async {
    emit(const CandidateProfileState.loading());

    final result = await _repository.getCandidateProfile(
      candidateId: candidateId,
      companyId: companyId,
    );

    result.fold(
      (failure) => emit(CandidateProfileState.error(failure.message)),
      (profile) => emit(CandidateProfileState.loaded(profile)),
    );
  }

  Future<void> unlockProfile({
    required String candidateId,
    required String companyId,
  }) async {
    final currentProfile = state.maybeMap(
      loaded: (s) => s.profile,
      orElse: () => null,
    );

    if (currentProfile == null) return;

    emit(const CandidateProfileState.unlocking());

    final result = await _repository.unlockCandidateProfile(
      candidateId: candidateId,
      companyId: companyId,
    );

    result.fold(
      (failure) {
        emit(CandidateProfileState.error(failure.message));
        emit(CandidateProfileState.loaded(currentProfile));
      },
      (_) async {
        await loadProfile(candidateId, companyId);
      },
    );
  }

  Future<void> toggleBookmark(String candidateId, String companyId) async {
    final currentProfile = state.maybeMap(
      loaded: (s) => s.profile,
      orElse: () => null,
    );

    if (currentProfile == null) return;

    final newStatus = !currentProfile.isBookmarked;
    final updatedProfile = currentProfile.copyWith(isBookmarked: newStatus);

    emit(CandidateProfileState.loaded(updatedProfile));

    final result = await _repository.toggleBookmark(
      candidateId: candidateId,
      companyId: companyId,
    );

    result.fold((failure) {
      emit(CandidateProfileState.error("Failed to update bookmark"));
      emit(CandidateProfileState.loaded(currentProfile));
    }, (_) {});
  }
}
