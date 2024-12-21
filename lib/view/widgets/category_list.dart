// File: lib/view/widgets/category_list.dart

import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<String> categories;
  final Function(String) onCategoryTap;

  const CategoryList({
    Key? key,
    required this.categories,
    required this.onCategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return Container(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                onCategoryTap(categories[index]);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('images/${categories[index]}.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
