class AiScoreModel {
  final int score;
  final String summary;
  final List<String> pros;
  final List<String> cons;

  AiScoreModel({
    required this.score,
    required this.summary,
    required this.pros,
    required this.cons,
  });

  factory AiScoreModel.fromJson(Map<String, dynamic> json) {
    return AiScoreModel(
      score: json['score'] ?? 0,
      summary: json['summary'] ?? 'No summary provided.',
      pros: List<String>.from(json['pros'] ?? []),
      cons: List<String>.from(json['cons'] ?? []),
    );
  }
}
