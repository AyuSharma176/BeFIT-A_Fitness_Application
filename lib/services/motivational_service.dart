import 'package:google_generative_ai/google_generative_ai.dart';

class MotivationService {
  final GenerativeModel model;

  MotivationService(String apiKey)
      : model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: apiKey,
    generationConfig: GenerationConfig(
      temperature: 0.9, // More creative/random
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 60,
    ),
  );

  Future<String> getQuote() async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final content = [
        Content.text(

          "Give me a fresh, powerful, one-sentence motivational quote related to fitness and  dont repeat any word and do not use embrace",
        )
      ];

      final response = await model.generateContent(content);

      if (response.text != null && response.text!.trim().isNotEmpty) {
        print("✅ Gemini response: ${response.text}");
        return response.text!.trim();
      } else {
        print("⚠️ Gemini response was empty");
        return "🔥 Push harder than yesterday!";
      }
    } catch (e) {
      print("❌ Gemini Error: $e");
      return "💡 Stay strong. Rest if you must, but don’t quit.";
    }
  }
}