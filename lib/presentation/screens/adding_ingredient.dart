import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IngredientAdder extends StatefulWidget {
  @override
  _IngredientAdderState createState() => _IngredientAdderState();
}

class _IngredientAdderState extends State<IngredientAdder> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _addLine() {
    setState(() {
      _controllers.add(TextEditingController());
      _controllers.add(TextEditingController());
    });
  }

  void _removeLine(int index) {
    setState(() {
      _controllers.removeAt(index);
      _controllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controllers.length,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return SizedBox(height: 8);
                }
                final controller = _controllers[index];
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Ingredient ${index ~/ 2 + 1}',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
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
                        controller: _controllers[index + 1],
                        decoration: InputDecoration(
                            hintText: 'weight',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade100))),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () => _removeLine(index),
                    ),
                  ],
                );
              },
            ),
          ),
          GestureDetector(
            onTap: _addLine,
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
          )
        ],
      ),
    );
  }
}
