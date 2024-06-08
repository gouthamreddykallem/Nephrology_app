import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('User Name')),
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