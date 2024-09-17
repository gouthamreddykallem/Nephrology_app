import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';

class CustomFloatingAppBar extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const CustomFloatingAppBar({
    super.key,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.0, // Adjust this value to control the vertical position
      left: 16.0,
      right: 16.0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
        height: 50.0, // Adjust the height of the AppBar
        decoration: BoxDecoration(
          color: primaryColorLight, // Solid color background
          borderRadius: BorderRadius.circular(30.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5), // Creates the elevation effect
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo and Title Container
            Row(
              children: [
                // Logo
                Container(
                  margin: const EdgeInsets.only(right: 8.0), // Space between logo and title
                  child: Image.asset(
                    'assets/logo.png', // Replace with your logo asset
                    width: 40.0, // Adjust size as needed
                    height: 40.0, // Adjust size as needed
                  ),
                ),
                // Title
                const Text(
                  "The Nephrology Group, Inc",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // Menu Button in a Circle
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor, // Background color of the circle
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.black,
                ),
                onPressed: onMenuPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
