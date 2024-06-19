import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nephrology_app/pages/details_page.dart';
import 'package:nephrology_app/shared/detail.dart';
import 'package:nephrology_app/shared/style.dart';

List<String> colors = ["0xFF4CAF50", "0xFF2196F3", "0xFFFF9800"];
List<String> lightColors = ["0xFF81C784", "0xFF64B5F6", "0xFFFFB74D"];

class Category extends StatefulWidget {
  final String title;
  final String iconPath;
  final List<List<Detail>> categories;

  const Category({super.key, required this.title, required this.categories, required this.iconPath});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isExpanded = false;
  Color color = Color(int.parse(colors[0]));
  Color lightColor = Color(int.parse(lightColors[0]));

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = SvgPicture.asset(
      widget.iconPath, // Ensure this path matches your asset
      width: 48,
      height: 48,
      color: Colors.white.withOpacity(0.9),
    );

    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * .20,
          child: InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: AspectRatio(
              aspectRatio: 2 / 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Add padding around the entire card
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
                                child: Text(widget.title, style: titleStyle),
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
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _isExpanded
              ? Container(
            height: MediaQuery.of(context).size.height * .40,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              itemCount: widget.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                return CategoryCard(
                  color: color,
                  lightColor: lightColor,
                  details: widget.categories[index],
                );
              },
            ),
          )
              : const SizedBox.shrink(),
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
        padding: const EdgeInsets.all(10.0), // Add padding around the entire card
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
