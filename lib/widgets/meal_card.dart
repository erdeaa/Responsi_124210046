import 'package:flutter/material.dart';

class MealsCard extends StatelessWidget {
  final String mealImageUrl;
  final String mealTitle;

  const MealsCard(
      {super.key, required this.mealImageUrl, required this.mealTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffffd299),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(mealImageUrl),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Text(
              mealTitle,
              maxLines: 1,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
