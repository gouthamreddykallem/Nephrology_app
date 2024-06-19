import 'package:flutter/material.dart';
import 'package:nephrology_app/components/floating_buttons.dart';
import 'package:nephrology_app/components/side_drawer.dart';
import 'package:nephrology_app/shared/color.dart';

import 'home_page.dart';

class LayOut extends StatefulWidget {
  const LayOut({super.key});

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.5,
        title: const Center(
          child: Text(
            "THE NEPHROLOGY GROUP, INC",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  primaryColor,
                  primaryColorLight,
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
                icon: const Icon(Icons.account_circle_outlined),
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
      body: const Center(
        child: HomeBody(),
      ),
    );
  }
}
