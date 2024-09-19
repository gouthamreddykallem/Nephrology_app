import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/utilities/utils.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: 80.0, left: 16.0, right: 16.0,),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
        crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
        children: [
          const SizedBox(height: 10),
          const Text(
            "Comprehensive Nephrology Care for Optimal Kidney Health",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10), // Add some spacing between texts
          const Text(
            "Dedicated to providing personalized and advanced treatment for kidney diseases.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30), // Add spacing before buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center buttons horizontally
            children: [
              Expanded(
                child: SizedBox(
                  height: 50, // Set a fixed height for the buttons
                  child: ElevatedButton(
                    onPressed: () {
                      Utilities.urlLauncher(
                          Uri(scheme: 'tel', path: '+1-559-228-6600'));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: darkGrey,
                      backgroundColor: lightBlue, // Button color
                      alignment: Alignment.center,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        "Schedule an Appointment",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16), // Add spacing between buttons
              Expanded(
                child: SizedBox(
                  height: 50, // Set a fixed height for the buttons
                  child: ElevatedButton(
                    onPressed: () {
                      Utilities.urlLauncher(
                          Uri.parse("https://www.myhealthrecord.com/Portal/SSO"));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: grey, // Button color
                      alignment: Alignment.center,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        "Patient Portal",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40), // Add spacing before the image
        ],
      ),
    );
  }
}
