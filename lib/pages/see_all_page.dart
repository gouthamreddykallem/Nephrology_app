import 'package:flutter/material.dart';
import 'package:nephrology_app/components/category_card.dart';
import 'package:nephrology_app/shared/color.dart';

class SeeAllPage extends StatefulWidget {
  final String title;
  final List<Map<String, String>> categories;
  const SeeAllPage({super.key, required this.categories, required this.title});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            var category = widget.categories[index];
            return CategoryCard(
              details: category,
              color: Color(int.parse(colors[index % 3])),
              lightColor: Color(int.parse(lightColors[index % 3])),
            );
          },
        ),
      ),
    );
  }
}
