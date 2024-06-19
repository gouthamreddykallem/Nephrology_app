import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nephrology_app/pages/details_page.dart';
import 'package:nephrology_app/pages/see_all_page.dart';
import 'package:nephrology_app/shared/detail.dart';
import 'package:nephrology_app/shared/style.dart';

List<String> colors = ["0xFF4CAF50", "0xFF2196F3", "0xFFFF9800"];
List<String> lightColors = ["0xFF81C784", "0xFF64B5F6", "0xFFFFB74D"];

class Category extends StatelessWidget {
  final String title;
  final List<List<Detail>> categories;

  const Category({super.key, required this.title, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SeeAllPage(
                          title: title,
                          categories: categories,
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 18.0, // Adjust the font size as needed
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .24,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: min(categories.length, 5),
            itemBuilder: (context, index) {
              var category = categories[index];
              return CategoryCard(
                details: category,
                color: Color(int.parse(colors[index % 3])),
                lightColor: Color(int.parse(lightColors[index % 3])),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final List<Detail> details;
  final Color color;
  final Color lightColor;

  const CategoryCard({
    super.key,
    required this.color,
    required this.lightColor,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    String? title;
    String? iconPath;

    // Extract details from the list
    for (var detail in details) {
      switch (detail.key) {
        case 'title':
          title = detail.value;
          break;
        case 'icon':
          iconPath = detail.value;
          break;
      }
    }

    Widget iconWidget = const SizedBox(); // Default empty widget if iconPath is null or empty

    // Check if 'iconPath' exists and is not null or empty
    if (iconPath != null && iconPath.isNotEmpty) {
      iconWidget = SvgPicture.asset(
        iconPath, // Ensure this path matches your asset
        width: 48,
        height: 48,
        color: Colors.white.withOpacity(0.9),
      );
    }

    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Padding(
        padding:
        const EdgeInsets.all(10.0), // Add padding around the entire card
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: lightColor.withOpacity(0.8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(details: details),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -20,
                    right: -20,
                    child: CircleAvatar(
                      backgroundColor: lightColor,
                      radius: 60,
                      child: iconWidget,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(title!, style: titleStyle),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension WidgetPadding on Widget {
  Widget padding([EdgeInsetsGeometry? insets]) => Padding(
    padding: insets ?? const EdgeInsets.all(0),
    child: this,
  );
}
