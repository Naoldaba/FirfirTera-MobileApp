import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  List<TextEditingController> _controllers = [];
  String? _base64Image;

  @override
  void initState() {
    super.initState();
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
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

  Future<void> takePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _base64Image = base64Image;
      });
    }
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Choose Image',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => takePhoto(ImageSource.camera),
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () => takePhoto(ImageSource.gallery),
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'Create Recipe',
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _base64Image != null
                        ? Image.memory(
                            Uint8List.fromList(base64Decode(_base64Image!)),
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(), 
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return bottomSheet();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const TextField(
                textAlign: TextAlign.end,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  prefixIcon: Icon(
                    Icons.local_dining,
                    color: Colors.orange,
                  ),
                  prefixText: "Recipe Name    ",
                  prefixStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: "Enter Recipe Name",
                  filled: true,
                  
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.person,
                          color:Colors.orange,
                        ),
                        prefixText: "Serves    ",
                        prefixStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        hintText: "Enter Number of Serves",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color:Colors.orange))),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.access_time,
                          color:Colors.orange,
                        ),
                        prefixText: "Cooking Time    ",
                        prefixStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        hintText: "Enter Cooking Time in Minutes",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color:Colors.orange))),
                  ),
                  SizedBox(height: 20),
                  Text("Ingredients",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Container(
                    height: 250,
                    child: Column(
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
                                        hintText:
                                            'Ingredient ${index ~/ 2 + 1}',
                                        border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(14),
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
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: BorderSide(
                                                  color:
                                                      Colors.grey.shade100))),
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
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color:Colors.orange,
                          borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: <Widget>[
                          
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 50.0, 
                              width: MediaQuery.of(context)
                                  .size
                                  .width, 
                              
                              child: Center(child: Text('Save My Recipe')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}