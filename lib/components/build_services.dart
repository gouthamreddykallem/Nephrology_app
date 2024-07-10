import 'package:flutter/material.dart';
import 'package:nephrology_app/components/build_categories.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/data.dart';
import 'package:nephrology_app/shared/detail.dart';
import 'package:nephrology_app/shared/style.dart';

var expandWidgetsServices = <bool>[false, false, false, false];

List<List<List<Detail>>> services = [
  kidneyCare,
  vascularHealth,
  dialysisServices,
  clinicalServices
];

class BuildServices extends StatefulWidget {
  const BuildServices({super.key});

  @override
  State<BuildServices> createState() => _BuildServicesState();
}

class _BuildServicesState extends State<BuildServices> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  final List<String> serviceTitles = [
    "Kidney Care",
    "Vascular Health",
    "Dialysis Services",
    "Clinical Services",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Initialize with placeholder values
    _heightAnimation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand(int index, double cardHeight) {
    setState(() {
      expandWidgetsServices[index] = !expandWidgetsServices[index];
      final newHeight = _calculateTotalHeight(cardHeight);
      _heightAnimation = Tween<double>(
        begin: _heightAnimation.value,
        end: newHeight,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      _controller.forward(from: 0);
    });
  }

  double _calculateTotalHeight(double cardHeight) {
    double totalHeight = cardHeight * expandWidgetsServices.length;
    for (int i = 0; i < expandWidgetsServices.length - 1; i++) {
      if (expandWidgetsServices[i]) {
        totalHeight += cardHeight * services[i].length;
      }
    }
    return totalHeight;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = MediaQuery.of(context).size.height * .08;
        if (_heightAnimation.value == 0) {
          // Initialize the height animation with the correct base height
          _heightAnimation = Tween<double>(
            begin: _calculateTotalHeight(cardHeight),
            end: _calculateTotalHeight(cardHeight),
          ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
        }
        return SizedBox(
          width: constraints.maxWidth * 0.8,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _heightAnimation,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth * 0.8, _heightAnimation.value),
                    painter: CardLinePainter(
                      itemCount: expandWidgetsServices.length,
                      cardHeight: cardHeight,
                      drawLinesOnRight: false,
                      animationValue: _heightAnimation.value,
                      totalHeight: _calculateTotalHeight(cardHeight),
                    ),
                  );
                },
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  for (int i = 0; i < expandWidgetsServices.length; i++)
                    Column(
                      children: [
                        Card(
                          title: serviceTitles[i],
                          onTap: () => _toggleExpand(i, cardHeight),
                          isExpanded: expandWidgetsServices[i],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: expandWidgetsServices[i]
                                ? BuildCategories(
                              categories: services[i],
                              drawLinesOnRight: false,
                              cardColor: Colors.transparent,
                            )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        );
      },
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
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(26)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 10,
                color: primaryColor.withOpacity(0.4),
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
                    bottom: 0,
                    top: 0,
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
  final double animationValue;
  final double totalHeight;

  CardLinePainter({
    required this.itemCount,
    required this.cardHeight,
    required this.drawLinesOnRight,
    required this.animationValue,
    required this.totalHeight,
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

    // Draw horizontal lines only after the animation is complete
    if (animationValue == totalHeight) {
      for (int i = 0; i < itemCount; i++) {
        double cardY = (i * cardHeight) + cardHeight / 2;

        // Adjust cardY based on expanded widgets above
        for (int j = 0; j < i; j++) {
          if (expandWidgetsServices[j]) {
            cardY += cardHeight * services[j].length;
          }
        }

        if (drawLinesOnRight) {
          canvas.drawLine(
            Offset(mainLineX, cardY),
            Offset(mainLineX - 10, cardY),
            paint,
          );
        } else {
          canvas.drawLine(
            Offset(mainLineX, cardY),
            Offset(mainLineX + 10, cardY),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return animationValue != (oldDelegate as CardLinePainter).animationValue;
  }
}
