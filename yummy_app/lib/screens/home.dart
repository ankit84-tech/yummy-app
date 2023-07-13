import 'package:flutter/material.dart';
import 'package:yummy_app/components/drawer.dart';
import 'package:yummy_app/components/food_card.dart';
import 'package:yummy_app/models/recipe_model.dart';
import 'package:yummy_app/screens/select_ing.dart';
import 'package:yummy_app/services/recipe_service.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Yummy'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: FutureBuilder<List<Recipe>>(
          future: RecipeService.loadRecipes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Recipe>? recipes = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid view
                  mainAxisSpacing: 12.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.0, // Aspect ratio of each grid item
                ),
                itemCount: recipes?.length ?? 0,
                itemBuilder: (context, index) {
                  final Recipe recipe = recipes![index];
                  return FoodCard(
                    recipe: recipe,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading recipes.'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) {
            return const SelectIng();
          },));
        },
        child: const Icon(Icons.checklist_sharp),
      ),
    );
  }
}
