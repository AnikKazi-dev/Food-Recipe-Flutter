import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/meal.dart';
import '../widgets/meal_item.dart';

class FavouriteScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  FavouriteScreen(this.favouriteMeals);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void _setFavScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favouriteMeals.isEmpty) {
      return Center(
        child: Text("You Have No Favourite yet!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: widget.favouriteMeals[index].id,
            title: widget.favouriteMeals[index].title,
            imageUrl: widget.favouriteMeals[index].imageUrl,
            affordability: widget.favouriteMeals[index].affordability,
            complexity: widget.favouriteMeals[index].complexity,
            duration: widget.favouriteMeals[index].duration,
            setFavScreen: _setFavScreen,
          );
        },
        itemCount: widget.favouriteMeals.length,
      );
    }
  }
}
