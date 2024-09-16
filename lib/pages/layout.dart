import 'package:flutter/material.dart';
import 'package:nephrology_app/components/floating_buttons.dart';
import 'package:nephrology_app/components/side_drawer.dart';
import 'package:nephrology_app/shared/color.dart';

import '../components/floating_appbar.dart';
import 'home_page.dart';

class LayOut extends StatefulWidget {
  const LayOut({super.key});

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      floatingActionButton: const FloatingButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: primaryColor,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              // Main body content
              const Center(

                child: HomeBody(),
              ),
              // Custom floating AppBar
              CustomFloatingAppBar(
                onMenuPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
