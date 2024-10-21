import 'package:flutter/material.dart';
import 'package:nephrology_app/components/category_card.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/detail.dart';

class SeeAllPage extends StatefulWidget {
  final String title;
  final List<List<Detail>> categories;
  const SeeAllPage({super.key, required this.categories, required this.title});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
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
