import 'package:firfir_tera/models/Recipe.dart';
import 'package:firfir_tera/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:firfir_tera/models/User.dart';

class DetailedView extends ConsumerWidget {
  final Recipe recipe;

  const DetailedView(this.recipe, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userModelProvider);
    User? user = userAsyncValue.when(
        data: (user) => user,
        loading: () {
          const Center(child: CircularProgressIndicator());
        },
        error: (error, stack) {
          Center(child: Text('Error: $error'));
        });
    final service = ref.read(recipeServiceProvider);
    // final String role = user!.role;

    void deleteRecipe() {
      bool ans = service.DeleteRecipe((user!.id).toString()) as bool;
      if (ans == true) {
        context.go("/home/discover");
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back),
                              ),
                              Text(recipe.name),
                            ],
                          ),
                          Row(
                            children: [
                              if (user!.role == 'cook' || user!.role=='admin') ...[
                                IconButton(
                                  onPressed: () {
                                    context.go(
                                        '/home/detailed_view/edit_recipe',
                                        extra: recipe);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: deleteRecipe,
                                  icon: const Icon(Icons.delete),
                                ),
                              ]
                              else ...[
                                IconButton(
                                  onPressed: () => context.go(
                                      '/home/detailed_view/comment',
                                      extra: recipe),
                                  icon:const Icon(Icons.comment),
                                ),
                              ]
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 260,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(recipe.image),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.timer),
                              Text("${recipe.cookTime}"),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.star),
                              Text("8.5 rate"),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.food_bank),
                              Text(recipe.fasting ? "fasting" : "Non-fasting"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipe.ingredients.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              recipe.ingredients[index],
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Steps",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: recipe.steps.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              recipe.steps[index],
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
