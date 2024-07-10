import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nephrology_app/pages/details_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/detail.dart';
import 'package:nephrology_app/shared/style.dart';

class BuildCategories extends StatelessWidget {
  final List<List<Detail>> categories;
  final bool drawLinesOnRight;
  final Color cardColor;

  const BuildCategories(
      {super.key,
      required this.categories,
      required this.drawLinesOnRight,
      required this.cardColor});

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * .08;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          // Add the CustomPaint widget as the first child in the stack
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width * 0.8,
                cardHeight * min(categories.length, 5)),
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
                cardColor: cardColor,
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
  final Color cardColor;

  const DrawCard({
    super.key,
    required this.details,
    required this.cardColor,
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
        width: 40,
        height: 40,
        colorFilter: ColorFilter.mode(
          Colors.white.withOpacity(0.9),
          BlendMode.srcIn,
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height *
          .08, // Adjust this based on your card height
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(26)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: (cardColor == Colors.transparent)
                    ? cardColor
                    : cardColor.withOpacity(0.4),
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
                  if (iconPath != null)
                    Positioned(
                      top: -20,
                      bottom: -20,
                      right: -12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.25),
                        radius: 50,
                        child: iconWidget,
                      ),
                    ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(title!,
                                style: cardColor == Colors.transparent
                                    ? titleStyleBlack
                                    : titleStyle),
                          ),
                        ),
                      ],
                    ),
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
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

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
        canvas.drawLine(
            Offset(mainLineX, cardY), Offset(mainLineX - 10, cardY), paint);
      } else {
        canvas.drawLine(
            Offset(mainLineX, cardY), Offset(mainLineX + 10, cardY), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
