import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Models/dummy_data.dart';
import 'package:food_recipe/screen/filters_screen.dart';
import 'package:food_recipe/screen/meal_detail_screen.dart';
import 'package:food_recipe/screen/tabs_screen.dart';
import 'Models/meal.dart';
import 'screen/category_meals_screen.dart';
import 'screen/category_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((element) => element.id == id);
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((element) => element.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(
          DUMMY_MEALS.firstWhere((element) => element.id == mealId),
        );
      });
    }
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meals) {
        if (_filters["gluten"] == true && meals.isGlutenFree == false) {
          return false;
        }
        if (_filters["lactose"] == true && meals.isLactoseFree == false) {
          return false;
        }
        if (_filters["vegan"] == true && meals.isVegan == false) {
          return false;
        }
        if (_filters["vegetarian"] == true && meals.isVegetarian == false) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Food Unda",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.blue,
        canvasColor: Colors.white,
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontFamily: "RobotoCondensed",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TabsScreen(_favouriteMeals),
      routes: {
        TabsScreen.routeName: (context) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   if (settings.name == "/meal-details"){
      //     return ...;
      //   }
      //   else if(settings.name == "/something-else"){
      //     return ...;
      //   }
      //   return MaterialPageRoute(builder: (context) => CategoriesScreen(),);
      // },
      onUnknownRoute: ((settings) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      }),
    );
  }
}
