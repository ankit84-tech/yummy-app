import 'package:flutter/material.dart';
import 'package:yummy_app/models/recipe_model.dart';
import 'package:yummy_app/screens/result_recipes.dart';
import 'package:yummy_app/services/recipe_service.dart';

class SelectIng extends StatefulWidget {
  const SelectIng({super.key});

  @override
  State<SelectIng> createState() => _SelectIngState();
}

class _SelectIngState extends State<SelectIng> {
  List<String> selectedIngredients = [];
  List<Recipe> recipes = []; // Your list of recipes goes here
  List<String> allIngredients = [];

  Future<List<String>> getAllRec() async {
    recipes = await RecipeService.loadRecipes();
    for (var recipe in recipes) {
      final recipeIngredients = List<String>.from(recipe.ingredients);
      allIngredients.addAll(recipeIngredients);
    }
    return allIngredients.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Ingredients'),
      ),
      body: FutureBuilder(
          future: getAllRec(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return const Text("loading");
            }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final ingredient = snapshot.data?[index];

                return CheckboxListTile(
                  title: Text(ingredient!),
                  value: selectedIngredients.contains(ingredient),
                  onChanged: (value) {
                    if (value!) {
                      selectedIngredients.add(ingredient);
                    } else {
                      selectedIngredients.remove(ingredient);
                    }
                  },
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showSelectedRecipes();
        },
        label: const Text('Select Ingredients'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showSelectedRecipes() {
    List<Recipe> selectedRecipes = [];

    // Filter recipes based on selected ingredients
    for (var recipe in recipes) {
      final recipeIngredients = List<String>.from(recipe.ingredients);
      final containsAllIngredients = selectedIngredients.any(
        (ingredient) => recipeIngredients.contains(ingredient),
      );

      if (containsAllIngredients) {
        selectedRecipes.add(recipe);
      }
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ResultRecipe(recipes: selectedRecipes);
      },
    ));
  }
}
