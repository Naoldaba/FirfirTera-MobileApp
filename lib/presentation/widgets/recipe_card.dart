import 'package:flutter/material.dart';
import 'package:firfir_tera/models/Recipe.dart';

class RecipeCard extends StatelessWidget {
  final String image;
  final String name;
  final double width;
  final double height;

  const RecipeCard({
    required this.image,
    required this.name,
    this.width = 200,
    this.height = 250,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 100,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.asset(
                  image,
                  height: height * 0.9,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Recipe {
//   final String imagePath;
//   final String recipeName;

//   Recipe({
//     required this.imagePath,
//     required this.recipeName,
//   });
// }

// List<Recipe> recipeList = [
  // Recipe(
  //   imagePath: 'assets/images/kikil.jpg',
  //   recipeName: 'Kikil',
  // ),
//   Recipe(
//     imagePath: 'assets/images/tibs.jpg',
//     recipeName: 'Tibs',
//   ),
//   Recipe(
//     imagePath: 'assets/images/beyaynet_fisik.jpg',
//     recipeName: "Yefisik Beyaynet",
//   ),
//   Recipe(
//     imagePath: 'assets/images/shiro.webp',
//     recipeName: "Shiro",
//   ),
//   Recipe(
//     imagePath: 'assets/images/pasta.jpg',
//     recipeName: "Pasta",
//   ),
//   Recipe(
//     imagePath: 'assets/images/beyaynet_tsom.jpg',
//     recipeName: "Yetsom Beyaynet",
//   ),
//   Recipe(
//     imagePath: 'assets/images/firfir.jpg',
//     recipeName: "Firfir",
//   ),
//   Recipe(
//     imagePath: 'assets/images/Tegabino.png',
//     recipeName: "Tegabino",
//   ),
//   Recipe(
//     imagePath: 'assets/images/sambusa.jpg',
//     recipeName: "Sambusa",
//   ),
// ];
