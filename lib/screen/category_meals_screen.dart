import 'package:flutter/material.dart';
import 'package:food_recipe/Models/dummy_data.dart';

import '../widgets/meal_item.dart';
import '../Models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/Category-meals";

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String categoryId;
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = routeArgs["id"] as String;
      categoryTitle = routeArgs["title"] as String;
      displayedMeals = widget.availableMeals
          .where(
            (meal) => meal.categories.contains(categoryId),
          )
          .toList();
    }

    _loadedInitData = true;
    super.didChangeDependencies();
  }

  // void _removeMeal(String MealId) {
  //   setState(() {
  //     displayedMeals.removeWhere((element) => element.id == MealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            setFavScreen: () {},
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
