import 'package:flutter/material.dart';

import '../screen/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imgUrl;

  CategoryItem(this.id, this.title, this.imgUrl);

  // void _selectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return CategoryMealsScreen(id, title);
  //       },
  //     ),
  //   );
  void _selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(CategoryMealsScreen.routeName, arguments: {
      "id": id,
      "title": title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      hoverColor: Colors.red,
      splashColor: Theme.of(context).primaryColor,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: Image.network(
              imgUrl,
              height: 500,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            //color: Colors.black54,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),

      // child: Container(
      //   padding: const EdgeInsets.all(15),
      //   child: Text(
      //     title,
      //     style: Theme.of(context).textTheme.headline1,
      //   ),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15),
      //     gradient: LinearGradient(
      //       colors: [
      //         color.withOpacity(0.7),
      //         color,
      //       ],
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //     ),
      //   ),
      // ),
    );
  }
}
