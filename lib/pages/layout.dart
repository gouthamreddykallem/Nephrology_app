import 'package:flutter/material.dart';
import 'package:nephrology_app/components/floating_buttons.dart';
import 'package:nephrology_app/components/side_drawer.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/floating_appbar.dart';
import 'home_page.dart';

class LayOut extends StatefulWidget {
  const LayOut({super.key});

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {
  final GlobalKey _appointmentKey = GlobalKey();
  final GlobalKey _paymentKey = GlobalKey();
  final GlobalKey _portalKey = GlobalKey();
  bool _showTutorial = false;

  @override
  void initState() {
    super.initState();
    _checkTutorialStatus();
  }

  Future<void> _checkTutorialStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showTutorial = false;
    if (mounted) {
      setState(() {
        _showTutorial = showTutorial;
      });
    }
  }

  void _onFinishShowCase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('show_tutorial', false);
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onFinish: _onFinishShowCase,
      builder: Builder(
        builder: (context) {
          if (_showTutorial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ShowCaseWidget.of(context).startShowCase([
                _appointmentKey,
                _paymentKey,
                _portalKey,
              ]);
            });
          }

          return Scaffold(
            drawer: const SideDrawer(),
            floatingActionButton: const FloatingButtons(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            backgroundColor: primaryColor,
            body: Builder(
              builder: (context) {
                return Stack(
                  children: [
                    Center(
                      child: HomeBody(
                        appointmentKey: _appointmentKey,
                        paymentKey: _paymentKey,
                        portalKey: _portalKey,
                      ),
                    ),
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
        },
      ),
    );
  }
}