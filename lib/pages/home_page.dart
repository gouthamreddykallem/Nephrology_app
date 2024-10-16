import 'package:flutter/material.dart';
import 'package:nephrology_app/components/about_section.dart';
import 'package:nephrology_app/components/quick_links.dart';
import 'package:nephrology_app/components/contact_section.dart';
import 'package:nephrology_app/components/hero_section.dart';
import 'package:nephrology_app/components/services_section.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeBody extends StatefulWidget {
  final GlobalKey appointmentKey;
  final GlobalKey paymentKey;
  final GlobalKey portalKey;

  const HomeBody({
    Key? key,
    required this.appointmentKey,
    required this.paymentKey,
    required this.portalKey,
  }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: bgColor,
        child: ListView(
          children: [
            HeroSection(appointmentKey: widget.appointmentKey),
            QuickLinks(
              paymentKey: widget.paymentKey,
              portalKey: widget.portalKey,
            ),
            const AboutSection(),
            const ServicesSection(),
            const ContactUsSection(),
          ],
        ),
      ),
    );
  }
}