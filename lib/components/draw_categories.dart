import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nephrology_app/pages/details_page.dart';
import 'package:nephrology_app/shared/detail.dart';
import 'package:nephrology_app/shared/style.dart';

List<String> colors = [
  "0xFF3F51B5", // Indigo
  "0xFFFFA000", // Amber
  "0xFFFF7043" // Coral
];

List<String> lightColors = [
  "0xFF9FA8DA", // Lighter Indigo
  "0xFFFFE082", // Lighter Amber
  "0xFFFFAB91" // Lighter Coral
];

class DrawCategories extends StatelessWidget {
  final List<List<Detail>> categories;
  final bool drawLinesOnRight;

  const DrawCategories({super.key, required this.categories, required this.drawLinesOnRight});

  @override
  Widget build(BuildContext context) {
    double cardHeight =
        90; // Adjust this based on the actual height of your cards

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          // Add the CustomPaint widget as the first child in the stack
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width * 0.8, cardHeight * min(categories.length, 5)),
            painter: CardLinePainter(
              itemCount: min(categories.length, 5),
              cardHeight: cardHeight,
              drawLinesOnRight: drawLinesOnRight,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: min(categories.length, 5),
            itemBuilder: (context, index) {
              var category = categories[index];
              return DrawCard(
                details: category,
                color: Color(int.parse(colors[index % 3])),
                lightColor: Color(int.parse(lightColors[index % 3])),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DrawCard extends StatelessWidget {
  final List<Detail> details;
  final Color color;
  final Color lightColor;

  const DrawCard({
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

    Widget iconWidget =
        const SizedBox(); // Default empty widget if iconPath is null or empty

    // Check if 'iconPath' exists and is not null or empty
    if (iconPath != null && iconPath.isNotEmpty) {
      iconWidget = SvgPicture.asset(
        iconPath, // Ensure this path matches your asset
        width: 48,
        height: 48,
        color: Colors.white.withOpacity(0.9),
      );
    }

    return SizedBox(
      height: 90, // Adjust this based on your card height
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(26)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: color.withOpacity(0.8),
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

class CardLinePainter extends CustomPainter {
  final int itemCount;
  final double cardHeight;
  final bool drawLinesOnRight;

  CardLinePainter({
    required this.itemCount,
    required this.cardHeight,
    required this.drawLinesOnRight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 4;

    double mainLineX = drawLinesOnRight ? size.width : 0;

    // Draw the main vertical line
    canvas.drawLine(
      Offset(mainLineX, 0),
      Offset(mainLineX, size.height - cardHeight / 2),
      paint,
    );

    for (int i = 0; i < itemCount; i++) {
      double cardY = (i * cardHeight) + cardHeight / 2;
      if (drawLinesOnRight) {
        canvas.drawLine(Offset(mainLineX, cardY), Offset(mainLineX - 10, cardY), paint);
      } else {
        canvas.drawLine(Offset(mainLineX, cardY), Offset(mainLineX + 10, cardY), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}