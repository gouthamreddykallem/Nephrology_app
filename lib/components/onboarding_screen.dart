import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nephrology_app/pages/layout.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: "Welcome to The Nephrology Group",
      description: "Your trusted partner in kidney health care.",
      image: "assets/EXCELLENCE.jpg",
      icon: Icons.medical_services,
    ),
    OnboardingPage(
      title: "Book an Appointment",
      description: "Easily schedule your next visit with our expert nephrologists.",
      image: "assets/kidney_transplant_img4.gif",
      icon: Icons.calendar_today,
    ),
    OnboardingPage(
      title: "Visit Patient Portal",
      description: "Access your health records and communicate with your care team securely.",
      image: "assets/kidney_transplant_img2.gif",
      icon: Icons.person,
    ),
    // OnboardingPage(
    //   title: "Make a Payment",
    //   description: "Conveniently manage your bills and make payments online.",
    //   image: "assets/kidney_transplant_img4.gif",
    //   icon: Icons.payment,
    // ),
    // OnboardingPage(
    //   title: "Learn More About Us",
    //   description: "Discover our comprehensive services and meet our expert team.",
    //   image: "assets/kidney_transplant_img2.gif",
    //   icon: Icons.info,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return buildPageContent(_pages[index]);
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: _onBoardingComplete,
              child: const Text(
                "Skip",
                style: TextStyle(color: primaryColor, fontSize: 18),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    _currentPage == _pages.length - 1 ? "Get Started" : "Next",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    if (_currentPage == _pages.length - 1) {
                      _onBoardingComplete();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageContent(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.1),
            ),
            child: Center(
              child: page.image.endsWith('.jpg')
                  ? ClipOval(
                      child: Image.asset(
                        page.image,
                        width: 280,
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(page.icon, size: 150, color: primaryColor),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            page.description,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _onBoardingComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LayOut()),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final IconData icon;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
  });
}