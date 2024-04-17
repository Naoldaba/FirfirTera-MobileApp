import 'package:flutter/material.dart';

class DetailedView extends StatefulWidget {
  const DetailedView({super.key});

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
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
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back),
                          ),
                          const Text("Tibs" //recipe name,
                              ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/comment');
                        },
                        icon: Icon(Icons.comment))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 260,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/tibs.jpg'),
                          fit: BoxFit.cover // recipe image
                          ),
                      borderRadius: BorderRadius.circular(30)),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.timer),
                        Text("45 mins" //cookTime
                            )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.star),
                        Text("8.5 rate" //rating
                            )
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.food_bank),
                        Text("Fasting" //categroy
                            )
                      ],
                    )
                  ],
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingredients",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text("- Ingredient 1"),
                Text("- Ingredient 2"),
                Text("- Ingredient 3"),
                Text("- Ingredient 3"),
                Text("- Ingredient 3"),
                Text("- Ingredient 3"),
                Text("- Ingredient 3"),
                Text("- Ingredient 3"),
                Text("- Ingredient 3"),
                Text("- Ingredient 3"),
                // Add more ingredients as needed
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Steps",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text("1. Step 1"),
                Text("2. Step 2"),
                Text("3. Step 3"),
                Text("3. Step 3"),
                Text("3. Step 3"),
                Text("3. Step 3"),
                Text("3. Step 3"),
                Text("3. Step 3"),
              ],
            ),
          ),
        ],
      ),
    ))));
  }
}
