import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColorLight,
            ),
            child: Text(
                'User Name',
                style: TextStyle(color: Colors.white, fontSize: 30))),
        const ExpansionTile(
          title: Text('About US'),
          children: [Text("Who We Are"), Text("Providers"), Text('Administration')],
          // onTap: () {
          //   Navigator.pop(context);
          // },
        ),
        ListTile(
          title: const Text('Services'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Online Forms'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Vascular Access'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ])
      );
  }
}