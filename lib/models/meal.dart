class Meal {
  final String mealTitle;
  final String mealImageUrl;
  final String mealId;

  Meal(
      {required this.mealTitle,
      required this.mealImageUrl,
      required this.mealId});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      mealTitle: json['strMeal'],
      mealImageUrl: json['strMealThumb'],
      mealId: json['idMeal'],
    );
  }
}
