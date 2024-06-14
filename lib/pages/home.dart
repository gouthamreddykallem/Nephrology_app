import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/app_bar.dart';
import 'package:nephrology_app/pages/bodies/ai_chat_body.dart';
import 'package:nephrology_app/pages/bodies/education_body.dart';
// import 'package:nephrology_app/pages/bodies/home_body.dart';
import 'package:nephrology_app/pages/bodies/login_body.dart';
import 'package:nephrology_app/pages/bodies/home_body.dart';
import 'package:nephrology_app/pages/bottom_nav_bar.dart';
import 'package:nephrology_app/pages/floating_buttons.dart';
import 'package:nephrology_app/pages/side_drawer.dart';
import 'package:provider/provider.dart';

class LayOut extends StatelessWidget {
  const LayOut({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
        create: (_) => NavBarController(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('The Nephrology Group, Inc'),
              backgroundColor: Colors.blue,
            ),
            drawer: const SideDrawer(),
            body: const CenterBody(),
            bottomNavigationBar: const BottomNavBar(),
            floatingActionButton: const FloatingButtons()));
  }
}

class CenterBody extends StatelessWidget {
  const CenterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: context.watch<NavBarController>(),
      // physics: const NeverScrollableScrollPhysics(),
      children: const [
        HomeBody(),
        EducationBody(),
        LoginBody(),
        AiChatBody(),
        // TopicsFlow(),
        // AboutView(),
        // ProfileView(),
      ],
    );
  }
}
