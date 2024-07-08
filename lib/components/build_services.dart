import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nephrology_app/components/build_categories.dart';
import 'package:nephrology_app/pages/details_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/data.dart';
import 'package:nephrology_app/shared/detail.dart';
import 'package:nephrology_app/shared/style.dart';

List<bool> expandWidgets = [false, false, false, false];

class BuildServices extends StatefulWidget {
  const BuildServices({super.key});

  @override
  State<BuildServices> createState() => _BuildServicesState();
}

class _BuildServicesState extends State<BuildServices> {
  void _toggleExpand(int index) {
    setState(() {
      expandWidgets[index] = !expandWidgets[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * .08;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        children: [
          // Add the CustomPaint widget as the first child in the stack
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width * 0.8, cardHeight * 4),
            painter: CardLinePainter(
              itemCount: 4,
              cardHeight: cardHeight,
              drawLinesOnRight: false,
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              Card(
                title: "Kidney Care",
                onTap: () => _toggleExpand(0),
                isExpanded: expandWidgets[0],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: expandWidgets[0]
                      ? BuildCategories(
                          categories: kidneyServices,
                          drawLinesOnRight: false,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              Card(
                title: "Vascular Health",
                onTap: () => _toggleExpand(1),
                isExpanded: expandWidgets[1],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: expandWidgets[1]
                      ? BuildCategories(
                          categories: kidneyServices,
                          drawLinesOnRight: false,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              Card(
                title: "Dialysis Services",
                onTap: () => _toggleExpand(2),
                isExpanded: expandWidgets[2],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: expandWidgets[2]
                      ? BuildCategories(
                          categories: kidneyServices,
                          drawLinesOnRight: false,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              Card(
                title: "Clinical Services",
                onTap: () => _toggleExpand(3),
                isExpanded: expandWidgets[3],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: expandWidgets[3]
                      ? BuildCategories(
                          categories: kidneyServices,
                          drawLinesOnRight: false,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isExpanded;

  const Card({
    super.key,
    required this.title,
    required this.onTap,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *
          .08, // Adjust this based on your card height
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(26)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: Colors.white.withOpacity(0.8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTap as void Function()?,
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.25),
                      radius: 15,
                      child: Icon(
                        size: 30.0,
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white,
                      ),
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
                            child: Text(title, style: titleStyle),
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
