import 'package:flutter/material.dart';
import 'package:nephrology_app/components/about_section.dart';
import 'package:nephrology_app/components/quick_links.dart';
import 'package:nephrology_app/components/contact_section.dart';
import 'package:nephrology_app/components/hero_section.dart';
// import 'package:nephrology_app/components/quicklinks_section.dart';
import 'package:nephrology_app/components/services_section.dart';
import 'package:nephrology_app/shared/color.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

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
          children: const [
            HeroSection(),
            QuickLinks(),
            AboutSection(),
            ServicesSection(),
            // QuickLinksSection(),
            ContactUsSection(),
          ],
        ),
      ),
    );
  }
}
