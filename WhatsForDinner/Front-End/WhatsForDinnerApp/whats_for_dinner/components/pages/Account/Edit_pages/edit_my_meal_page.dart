import 'package:flutter/material.dart';
import '../../../util/to_prev_page.dart';
import '../Account_util/upload_image_icons.dart';
import '../../../util/add_bar_bullet.dart';
import '../../../util/add_bar_ordered.dart';
import '../../../util/requests.dart';
import '../../../util/globals.dart' as globals;
import 'dart:convert';

class EditMyMealPage extends StatefulWidget {
  final String nameOfMeal;
  final String descriptionOfMeal;
  final List<dynamic> savedIngredients;
  final Map<String, dynamic> savedRecipe;
  final String imgUrl;
  const EditMyMealPage(
      {Key? key,
      this.nameOfMeal = '',
      this.descriptionOfMeal = '',
      this.savedIngredients = const [],
      this.savedRecipe = const {},
      this.imgUrl = ''})
      : super(key: key);

  @override
  State<EditMyMealPage> createState() => _EditMyMealPageState();
}

class _EditMyMealPageState extends State<EditMyMealPage> {
  TextEditingController nameOfMealController = TextEditingController();
  TextEditingController descriptionOfMealController = TextEditingController();
  TextEditingController servingSizeController = TextEditingController();

  List<dynamic> ingredients = [];
  Map<String, dynamic> recipe = {};
  Requests requests = Requests();

  @override
  Widget build(BuildContext context) {
    ingredients.addAll(widget.savedIngredients);
    recipe.addAll(widget.savedRecipe);

    nameOfMealController.value = TextEditingValue(
      text: widget.nameOfMeal,
    );

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ToPrevPage(),
              const Text(
                'Edit Meal',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: TextField(
                    controller: nameOfMealController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Meal Name...",
                        labelText: 'Enter Meal Name')),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                    controller: descriptionOfMealController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Description...",
                        labelText: 'Enter Description')),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              UploadImageIcons(
                hasImg: true,
                imgUrl: widget.imgUrl,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Serving Size',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: TextField(
                    controller: servingSizeController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "SS...",
                        labelText: 'SS')),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              AddBarBullet(
                hintText: "Enter Ingredient...",
                labelText: "Enter Ingredient",
                information: ingredients,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Recipe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              AddBarOrdered(
                hintText: "Enter Recipe...",
                labelText: "Enter Recipe",
                information: recipe,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: ElevatedButton(
                    onPressed: () async {
                      if (nameOfMealController.text.isNotEmpty &&
                          ingredients.isNotEmpty &&
                          recipe.isNotEmpty) {
                        Map<String, dynamic> newMeal = {
                          "imgLink": globals.imgUrl,
                          "creator": globals.username,
                          "name": nameOfMealController.text,
                          "description": descriptionOfMealController.text,
                          "servingSize": int.parse(servingSizeController.text),
                          "ingredients": ingredients,
                          "recipe": recipe,
                          "likes": 0,
                          "usersWhoLiked": [],
                          "usersWhoSaved": []
                        };

                        requests
                            .makePutRequest(
                                "http://10.0.2.2:8888/meal", newMeal)
                            .then((value) {
                          print(value);
                        });

                        Navigator.of(context).pop();
                      } else {
                        await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    const Text('Not all the fields are used'),
                                content: const Text(
                                    'Please, fill at least the fields (Name, Ingredients and Recipe) with the information of the meal.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent, // background
                    ),
                    child: const Text(
                      'Edit Meal',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
