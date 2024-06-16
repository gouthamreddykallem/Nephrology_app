import 'dart:math';

import 'package:flutter/material.dart';

List<String> colors = ["0xFF4CAF50", "0xFF2196F3", "0xFFFF9800"];
List<String> lightColors = ["0xFF81C784", "0xFF64B5F6", "0xFFFFB74D"];

class Category extends StatelessWidget {
  final String title;
  final List<Map<String, String>> categories;

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
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Add your onTap functionality here
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
                title: category["title"]!,
                subtitle: category["subtitle"]!,
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
  final String title;
  final String subtitle;
  final Color color;
  final Color lightColor;

  const CategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
    TextStyle subtitleStyle = const TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);

    if (MediaQuery.of(context).size.width < 392) {
      titleStyle = const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
      subtitleStyle = const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);
    }

    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * .3,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: InkWell(
            onTap: () {
              // Add your onTap functionality here
            },
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -20,
                    right: -20,
                    child: CircleAvatar(
                      backgroundColor: lightColor,
                      radius: 60,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(title, style: titleStyle),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Flexible(
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //     child: Text(subtitle, style: subtitleStyle),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ).padding(const EdgeInsets.all(16)),
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
