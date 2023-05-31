import 'package:http/http.dart' as http;

class ChatGptApi {
  static Future<String> getFoodRecommendations(String userId) async {
    // Make an API request to ChatGPT API to get food recommendations based on user preferences
    // Modify the URL and request body as per the API documentation
    final url = Uri.parse('https://api.chatgpt.com/food/recommendations');
    final response = await http.post(
      url,
      body: {
        'user_id': userId,
        // Add any required parameters for user preferences
      },
    );

    if (response.statusCode == 200) {
      // Extract and return the food recommendations from the response
      return response.body;
    } else {
      throw Exception('Failed to get food recommendations');
    }
  }
}
