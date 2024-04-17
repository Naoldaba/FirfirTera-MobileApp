import 'dart:core';

class Recipe {
  String name;
  String description;
  int cookTime;
  int people;
  String ingredients;
  String steps;
  bool fasting;
  String type;
  String image;

  Recipe(
      {required this.name,
      required this.description,
      required this.cookTime,
      required this.fasting,
      required this.type,
      required this.image,
      required this.ingredients,
      required this.people,
      required this.steps});

    Future<void> get_recipes() async{
        try{
          
        }catch (e){

        }
    }
}
