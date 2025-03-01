import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  final String apiKey = 'a6e96725c5aadc9110b37a7382d53067'; // Replace with your API key
  final String baseUrl = 'https://gnews.io/api/v4';

  Future<List<NewsModel>> fetchNews(String category) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/top-headlines?category=$category&lang=en&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('API Response: $data'); // Log the full response
      return (data['articles'] as List)
          .map((article) => NewsModel.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
