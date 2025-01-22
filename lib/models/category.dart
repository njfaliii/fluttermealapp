import 'package:flutter/material.dart';

class Category {
  final int id;
  final String title;
  final Color color;
  final String imageUrl;
  final int mealCount;

  Category({
    required this.id,
    required this.title,
    required this.color,
    required this.imageUrl,
    required this.mealCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    String colorString = json['color'] as String;
    Color parsedColor;
    try {
      if (colorString.startsWith('0x')) {
        parsedColor = Color(int.parse(colorString));
      } else if (colorString.startsWith('#')) {
        parsedColor = Color(int.parse('0xFF${colorString.substring(1)}'));
      } else {
        parsedColor = Color(int.parse('0xFF${colorString}'));
      }
    } catch (e) {
      print('Error parsing color: $e');
      parsedColor = Colors.blue; // Default color
    }

    return Category(
      id: json['id'] as int,
      title: json['title'] as String,
      color: parsedColor,
      imageUrl: json['image_url'] as String,
      mealCount: json['meal_count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'color': color.value.toRadixString(16),
      'image_url': imageUrl,
      'meal_count': mealCount,
    };
  }
}
