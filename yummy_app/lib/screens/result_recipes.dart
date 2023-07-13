import 'package:flutter/material.dart';

import '../components/food_card.dart';
import '../models/recipe_model.dart';

class ResultRecipe extends StatelessWidget {
  final List<Recipe> recipes;
  const ResultRecipe({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relevant Recipes'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid view
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0, // Aspect ratio of each grid item
                    ),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final Recipe recipe = recipes[index];
                      return FoodCard(
                        recipe: recipe,
                      );
                    },
                  ),
        ),
      )
    );
  }
}