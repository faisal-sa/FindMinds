import 'package:equatable/equatable.dart';

abstract class MatchStrengthState extends Equatable {
  const MatchStrengthState();
  @override
  List<Object> get props => [];
}

class MatchStrengthInitial extends MatchStrengthState {}

class MatchStrengthLoading extends MatchStrengthState {}

class MatchStrengthLoaded extends MatchStrengthState {
  final int score;
  final List<String> strengths;
  final List<Map<String, String>> improvements; // {'issue': '...', 'action': '...'}

  const MatchStrengthLoaded({
    required this.score,
    required this.strengths,
    required this.improvements,
  });

  @override
  List<Object> get props => [score, strengths, improvements];
}

class MatchStrengthError extends MatchStrengthState {
  final String message;
  const MatchStrengthError(this.message);
  @override
  List<Object> get props => [message];
}