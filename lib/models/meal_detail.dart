class MealDetail {
  final String id;
  final String name;
  final String drinkAlternate;
  final String category;
  final String area;
  final String instructions;
  final String mealThumb;
  final String tags;
  final String youtube;
  final List<String?> ingredients;
  final List<String?> measures;

  MealDetail({
    required this.id,
    required this.name,
    required this.drinkAlternate,
    required this.category,
    required this.area,
    required this.instructions,
    required this.mealThumb,
    required this.tags,
    required this.youtube,
    required this.ingredients,
    required this.measures,
  });

  // Named constructor for creating a MealDetail instance from JSON
  factory MealDetail.fromJson(Map<String, dynamic> json) {
    List<String?> ingredients = [];
    List<String?> measures = [];

    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];

      if (ingredient == null ||
          measure == null ||
          ingredient.isEmpty ||
          measure.isEmpty) {
        break;
      }

      ingredients.add(ingredient);
      measures.add(measure);
    }

    return MealDetail(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      drinkAlternate: json['strDrinkAlternate'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      mealThumb: json['strMealThumb'] ?? '',
      tags: json['strTags'] ?? '',
      youtube: json['strYoutube'] ?? '',
      ingredients: ingredients,
      measures: measures,
    );
  }
}
