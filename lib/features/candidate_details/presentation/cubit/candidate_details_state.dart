import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/candidate_profile_entity.dart';

part 'candidate_details_state.freezed.dart';

@freezed
class CandidateProfileState with _$CandidateProfileState {
  const factory CandidateProfileState.initial() = _Initial;
  const factory CandidateProfileState.loading() = _Loading;
  const factory CandidateProfileState.loaded(CandidateProfileEntity profile) =
      _Loaded;
  const factory CandidateProfileState.unlocking() = _Unlocking;
  const factory CandidateProfileState.error(String message) = _Error;
}
