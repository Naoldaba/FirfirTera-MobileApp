import 'package:flutter/material.dart';

class DetailedView extends StatefulWidget {
  const DetailedView({super.key});

  @override
  State<DetailedView> createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  final List<String> steps = [
    "1. Step 1",
    "2. Step 2",
    "3. Step 3",
    "3. Step 3",
    "3. Step 3",
    "3. Step 3",
    "3. Step 3",
    "3. Step 3",
  ];

  final List<String> ingredients = [
    "1. Ingredients 1",
    "2. Ingredients 2",
    "3. Ingredients 3",
    "3. Ingredients 3",
    "3. Ingredients 3",
    "3. Ingredients 3",
    "3. Ingredients 3",
    "3. Ingredients 3",
  ];

  @override
  Widget build(BuildContext context) {
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
                                  Navigator.pushReplacementNamed(
                                      context, '/comment');
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
                        Text(
                          "Ingredients",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: ingredients.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                ingredients[index],
                                style: TextStyle(fontSize: 20),
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
                        Text(
                          "Steps",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: steps.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                steps[index],
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }
}
