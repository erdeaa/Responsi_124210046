import 'package:flutter/material.dart';
import 'package:meals_app/helpers/api_handler.dart';
import 'package:meals_app/pages/meals_page.dart';

import '../models/category.dart';
import '../widgets/category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await getRequest('categories.php');
      final data = response['categories'];
      List<Category> tempCategories = [];

      for (var categoryData in data) {
        tempCategories.add(Category.fromJson(categoryData));
      }
      setState(() {
        categories = tempCategories;
      });
    } catch (e) {
      showSnackbar(e.toString());
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Meals Categories')),
      body: Center(
        child: SizedBox(
          child: ListView.separated(
            itemCount: categories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          MealsPage(title: categories[index].title)));
                },
                child: CategoryCard(
                    imageUrl: categories[index].imageUrl,
                    title: categories[index].title,
                    categoryDetail: categories[index].categoryDescription),
              );
            },
          ),
        ),
      ),
    );
  }
}
