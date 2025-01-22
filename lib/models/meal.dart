class Meal {
  final int id;
  final int category;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final String cookTime;
  final String calories;
  final bool isFeatured;

  Meal({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.cookTime,
    required this.calories,
    required this.isFeatured,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'] as int,
      category: json['category'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      rating: (json['rating'] as num).toDouble(),
      cookTime: json['cook_time'] as String,
      calories: json['calories'] as String,
      isFeatured: json['is_featured'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'price': price.toString(),
      'rating': rating,
      'cook_time': cookTime,
      'calories': calories,
      'is_featured': isFeatured,
    };
  }
}
