import 'package:firfir_tera/providers/ingredients_adder_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IngredientAdder extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllers = ref.watch(ingredientListProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controllers.length,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return SizedBox(height: 8);
                }
                final controller = controllers[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Ingredient ${index ~/ 2 + 1}',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromRGBO(158, 158, 158, 1)),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: controllers[index + 1],
                        decoration: InputDecoration(
                          hintText: 'weight',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: Colors.grey.shade100),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {
                        ref
                            .read(ingredientListProvider.notifier)
                            .removeController(index);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              ref.read(ingredientListProvider.notifier).addController();
            },
            child: const Row(
              children: [
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 30,
                ),
                SizedBox(width: 8),
                Text(
                  "Add Ingredient",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
