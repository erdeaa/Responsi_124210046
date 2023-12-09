import 'package:flutter/material.dart';
import 'package:meals_app/helpers/api_handler.dart';
import 'package:url_launcher/link.dart';

import '../models/meal_detail.dart' as model;

class MealDetail extends StatefulWidget {
  final String mealId;
  final String title;

  const MealDetail({Key? key, required this.mealId, required this.title})
      : super(key: key);

  @override
  State<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  late Future<model.MealDetail?>
      _mealDetailFuture; // Declare a Future for meal detail

  @override
  void initState() {
    super.initState();
    _mealDetailFuture =
        fetchMealDetail(widget.mealId); // Initiate the fetch on initState
  }

  Future<model.MealDetail?> fetchMealDetail(String mealId) async {
    try {
      final response = await getRequest('lookup.php?i=$mealId');

      if (response is Map<String, dynamic>) {
        if (response.containsKey('meals')) {
          final List<dynamic> meals = response['meals'];
          if (meals.isNotEmpty) {
            return model.MealDetail.fromJson(meals.first);
          }
        }
      }

      return null;
    } catch (e) {
      showSnackbar('Error fetching meal detail: $e');
      return null;
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
        title: Text(widget.title),
      ),
      body: FutureBuilder<model.MealDetail?>(
        future: _mealDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return const Center(
                child: Text('Meal not found or failed to fetch meal detail.'));
          }

          final mealDetail = snapshot.data!;

          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      mealDetail.mealThumb,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Category: ${mealDetail.category}'),
                        Text('Country: ${mealDetail.area}'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Ingredients:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(mealDetail.ingredients.join(", \n")),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Measurements:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(mealDetail.measures.join(", \n")),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Instructions:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(mealDetail.instructions),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Link(
                        uri: Uri.parse(mealDetail.youtube),
                        builder: (context, openLink) => ElevatedButton.icon(
                          icon: const Icon(Icons.play_arrow),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFF7F00),
                              foregroundColor: Colors.black87),
                          onPressed: openLink,
                          label: const Text('Watch Tutorial'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
