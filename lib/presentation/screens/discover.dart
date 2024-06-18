import 'package:firfir_tera/models/Recipe.dart';
import 'package:firfir_tera/providers/recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firfir_tera/presentation/widgets/recipe_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/providers/discover_provider.dart';
import 'package:go_router/go_router.dart';

class Discover extends ConsumerStatefulWidget {
  const Discover({super.key});

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<Discover> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedOption = ref.read(selectedOptionProvider);
      ref.refresh(_getRecipeProvider(selectedOption));
    });
  }

  AutoDisposeFutureProvider<List<Recipe>> _getRecipeProvider(String selectedOption) {
    switch (selectedOption) {
      case 'Breakfast':
        return breakfastRecipesProvider;
      case 'Lunch':
        return lunchRecipesProvider;
      case 'Dinner':
        return dinnerRecipesProvider;
      default:
        return recipesProvider;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    final selectedOption = ref.watch(selectedOptionProvider);

    final recipeListAsync = ref.watch(_getRecipeProvider(selectedOption));

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text("Search", style: GoogleFonts.dancingScript(fontSize: 30)),
              Text("for Recipes", style: GoogleFonts.firaSans(fontSize: 40)),
              const SizedBox(height: 20),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "recipe name",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onChanged: (val) {},
                onSubmitted: (val) {},
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  buildOptionButton(ref, "All", "food"),
                  buildOptionButton(ref, "Breakfast", "breakfast"),
                  buildOptionButton(ref, "Lunch", "lunch"),
                  buildOptionButton(ref, "Dinner", "dinner"),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Trending",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              recipeListAsync.when(
                data: (recipeList) {
                  return Container(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        final recipe = recipeList[index];
                        return GestureDetector(
                          onTap: () =>
                              context.go('/home/detailed_view', extra: recipe),
                          child: RecipeCard(
                            image: recipe.image,
                            name: recipe.name,
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () {
                  return Center(child: CircularProgressIndicator());
                },
                error: (err, stack) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Oops... Unable to fetch recipes.',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            ref.invalidate(_getRecipeProvider(selectedOption));
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildOptionButton(WidgetRef ref, String option, String iconName) {
  Map<String, String> iconMap = {
    "food": "assets/icons/all_food.png",
    "breakfast": "assets/icons/breakfast.png",
    "lunch": "assets/icons/lunch.png",
    "dinner": "assets/icons/dinner.png"
  };

  String iconPath = iconMap[iconName] ?? '';
  final selectedOption = ref.watch(selectedOptionProvider);

  return InkWell(
    onTap: () {
      ref.read(selectedOptionProvider.notifier).setOption(option);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: selectedOption == option ? Colors.grey[200] : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 30,
            height: 30,
          ),
          Text(
            option,
            style: TextStyle(
              fontSize: selectedOption == option ? 15 : 12,
              fontWeight: selectedOption == option
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: selectedOption == option ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
