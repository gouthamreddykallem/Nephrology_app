import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/side_drawer.dart';
import 'package:nephrology_app/shared/color.dart';

import 'bodies/ai_chat_body.dart';
import 'bodies/education_body.dart';
import 'bodies/home_body.dart';
import 'bodies/login_body.dart';
import 'floating_buttons.dart';


class LayOut extends StatefulWidget {
  const LayOut({super.key});

  @override
  State<LayOut> createState() =>
      _LayOutState();
}

class _LayOutState
    extends State<LayOut> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeBody(),
    EducationBody(),
    LoginBody(),
    AiChatBody(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.5,
        title: const Text("The Nephrology Group, Inc",
            style: TextStyle(color: Colors.white), textDirection: TextDirection.ltr),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  primaryColorLight,
                  primaryColor,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          )
        ],
      ),
      drawer: const SideDrawer(),
      floatingActionButton: const FloatingButtons(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

        selectedFontSize: 20,
        selectedIconTheme: const IconThemeData(color: primaryColorLight, size: 40),
        selectedItemColor: Colors.blue,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),

        unselectedFontSize: 20,
        unselectedIconTheme: const IconThemeData(color: secondaryColor, size: 40),
        unselectedItemColor: Colors.blue,
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Education',
            icon: Icon(Icons.cast_for_education),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.account_circle_outlined),
          ),
          BottomNavigationBarItem(
            label: 'AI chat',
            icon: Icon(Icons.cloud_circle_rounded),
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
