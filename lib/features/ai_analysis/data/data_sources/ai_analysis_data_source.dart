import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/ai_score_model.dart';

@lazySingleton
class AiRemoteDataSource {
  final SupabaseClient supabase;

  AiRemoteDataSource(this.supabase);

  // ... imports

  Future<AiScoreModel> analyzeCandidate({
    required Map<String, dynamic> candidateData,
    required Map<String, dynamic> jobRequirements,
  }) async {
    try {
      print(" Sending request to AI...");
      print(" Data: $candidateData");

      final response = await supabase.functions.invoke(
        'analyze-candidate',
        body: {
          'candidateData': candidateData,
          'jobRequirements': jobRequirements,
        },
      );

      print(" Response Status: ${response.status}");

      if (response.status != 200) {
        print(" Server Error Body: ${response.data}");
        throw Exception('AI Analysis Failed: ${response.status}');
      }

      print(" AI Success Data: ${response.data}");
      return AiScoreModel.fromJson(response.data);
    } catch (e) {
      print(" FLUTTER ERROR: $e");
      return AiScoreModel(score: 0, summary: "Error: $e", pros: [], cons: []);
    }
  }
}
