import 'package:flutter/material.dart';
import 'package:nephrology_app/components/about_section.dart';
import 'package:nephrology_app/components/hero_section.dart';
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
          children:  [
            const HeroSection(),
            Image.asset(
              'assets/images/medical_care.jpeg', // Path to your JPEG image
              fit: BoxFit.cover, // Adjust the fit as needed
              width: double.infinity,
              height: 200, // Set height based on your layout
            ),
            const SizedBox(height: 16.0,),
            const AboutSection(),
            const ServicesSection(),
          ],
        ),
      ),
    );
  }
}