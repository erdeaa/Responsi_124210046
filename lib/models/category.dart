class Category {
  final String id;
  final String title;
  final String imageUrl;
  final String categoryDescription;

  Category(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.categoryDescription});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      title: json['strCategory'],
      imageUrl: json['strCategoryThumb'],
      categoryDescription: json['strCategoryDescription'],
    );
  }
}
