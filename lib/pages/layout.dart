import 'package:flutter/material.dart';
import 'package:nephrology_app/components/floating_buttons.dart';
import 'package:nephrology_app/components/side_drawer.dart';
import 'package:nephrology_app/shared/color.dart';

import 'ai_chat_page.dart';
import 'education_page.dart';
import 'home_page.dart';
import 'login_page.dart';


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
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Image.asset('assets/logo.jpg', fit: BoxFit.fill, alignment: Alignment.center),
        // const Text("The Nephrology Group, Inc",
        //     style: TextStyle(color: Colors.white), textDirection: TextDirection.ltr),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
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
                icon: const Icon(Icons.help_outline_rounded),
                color: Colors.black,
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
