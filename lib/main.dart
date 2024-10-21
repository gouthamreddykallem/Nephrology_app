import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/splash_page.dart';
// import 'package:nephrology_app/services/dialogflow_service.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nephrology_app/components/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
  // bool onboardingComplete = false;
   WidgetsFlutterBinding.ensureInitialized();
  // DialogflowService();

  runApp(MyApp(onboardingComplete: onboardingComplete));
}

class MyApp extends StatelessWidget {
  final bool onboardingComplete;

  const MyApp({Key? key, required this.onboardingComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
      ),
      home: onboardingComplete ? const SplashPage() : const OnboardingScreen(),
    );
  }
}