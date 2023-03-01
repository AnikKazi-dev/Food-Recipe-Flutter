import 'package:flutter/material.dart';
import '../Models/meal.dart';
import 'package:food_recipe/widgets/main_drawer.dart';
import 'category_screen.dart';
import 'favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabs-screen";
  final List<Meal> favouriteMeals;
  TabsScreen(this.favouriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, Object>> _pageLists;

  int _pageIndex = 0;
  void _selectPageFunc(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  void initState() {
    _pageLists = [
      {
        "page": CategoriesScreen(),
        "title": "Categories",
      },
      {
        "page": FavouriteScreen(widget.favouriteMeals),
        "title": "Your Favourite",
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meals"),
      ),
      drawer: MainDrawer(),
      body: _pageLists[_pageIndex]["page"] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPageFunc,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        currentIndex: _pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favourites",
          ),
        ],
      ),
    );
    // return DefaultTabController(
    //   initialIndex: 0,
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text("Meals"),
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: "Categories",
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: "Favourite",
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         CategoriesScreen(),
    //         FavouriteScreen(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
