import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // For Android Emulator
  // static const String baseUrl = 'http://10.0.2.2:8000';
  // For iOS Simulator
  static const String baseUrl = 'http://127.0.0.1:8000';

  // Common headers for all requests
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  String _getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return '';
    if (imageUrl.startsWith('http')) return imageUrl;
    return '$baseUrl$imageUrl';
  }

  // Get all categories
  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      print('Fetching categories from: $baseUrl/api/categories/');
      final response = await http.get(
        Uri.parse('$baseUrl/api/categories/'),
        headers: _headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((category) {
          // Convert relative image URL to absolute URL
          if (category['image_url'] != null) {
            category['image_url'] = _getFullImageUrl(category['image_url']);
          }
          return category as Map<String, dynamic>;
        }).toList();
      } else {
        throw Exception(
            'Failed to load categories: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('Error loading categories: $e');
      throw Exception('Error: $e');
    }
  }

  // Get meals by category
  Future<List<Map<String, dynamic>>> getMealsByCategory(
      String categoryId) async {
    try {
      print('Fetching meals for category: $categoryId');
      final response = await http.get(
        Uri.parse('$baseUrl/api/meals/?category=$categoryId'),
        headers: _headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((meal) {
          // Convert relative image URL to absolute URL
          if (meal['image_url'] != null) {
            meal['image_url'] = _getFullImageUrl(meal['image_url']);
          }
          return meal as Map<String, dynamic>;
        }).toList();
      } else {
        throw Exception(
            'Failed to load meals: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('Error loading meals: $e');
      throw Exception('Error: $e');
    }
  }

  // Get meal details
  Future<Map<String, dynamic>> getMealDetails(String mealId) async {
    try {
      print('Fetching meal details for: $mealId');
      final response = await http.get(
        Uri.parse('$baseUrl/api/meals/$mealId/'),
        headers: _headers,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final meal = json.decode(response.body);
        // Convert relative image URL to absolute URL
        if (meal['image_url'] != null) {
          meal['image_url'] = _getFullImageUrl(meal['image_url']);
        }
        return meal;
      } else {
        throw Exception(
            'Failed to load meal details: ${response.statusCode}\n${response.body}');
      }
    } catch (e) {
      print('Error loading meal details: $e');
      throw Exception('Error: $e');
    }
  }
}
