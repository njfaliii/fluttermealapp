import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../services/api_service.dart';

class AppProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Category> _categories = [];
  Map<String, List<Meal>> _meals = {};
  bool _isLoading = false;
  String _error = '';

  // Getters
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Fetch categories
  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final categoriesData = await _apiService.getCategories();
      _categories =
          categoriesData.map((data) => Category.fromJson(data)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch meals by category
  Future<void> fetchMealsByCategory(String categoryId) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final mealsData = await _apiService.getMealsByCategory(categoryId);
      final meals = mealsData.map((data) => Meal.fromJson(data)).toList();
      _meals[categoryId] = meals;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get meals by category
  List<Meal> getMealsByCategory(String categoryId) {
    return _meals[categoryId] ?? [];
  }

  Future<Meal?> fetchMealDetails(String mealId) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final mealData = await _apiService.getMealDetails(mealId);
      return Meal.fromJson(mealData);
    } catch (e) {
      _error = e.toString();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
