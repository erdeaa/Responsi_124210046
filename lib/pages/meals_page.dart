import 'package:flutter/material.dart';
import 'package:meals_app/pages/meal_detail.dart';

import '../helpers/api_handler.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';

class MealsPage extends StatefulWidget {
  final String title;
  const MealsPage({super.key, required this.title});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Meal> meals = [];

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    try {
      final response = await getRequest('filter.php?c=${widget.title}');
      final data = response['meals'];
      List<Meal> tempMeals = [];

      for (var mealData in data) {
        tempMeals.add(Meal.fromJson(mealData));
      }
      setState(() {
        meals = tempMeals;
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
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.title} Meals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: meals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MealDetail(
                      mealId: meals[index].mealId,
                      title: meals[index].mealTitle,
                    ),
                  ),
                );
              },
              child: MealsCard(
                  mealImageUrl: meals[index].mealImageUrl,
                  mealTitle: meals[index].mealTitle),
            );
          },
        ),
      ),
    );
  }
}
