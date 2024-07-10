import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/online_forms_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/utilities/utils.dart';

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
        // const ExpansionTile(
        //   title: Text('About US'),
        //   children: [Text("Who We Are"), Text("Providers"), Text('Administration')],
        //   // onTap: () {
        //   //   Navigator.pop(context);
        //   // },
        // ),
        // ListTile(
        //   title: const Text('Services'),
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        // ),
        ListTile(
          title: const Text('Online Forms'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const OnlineFormsPage();
                },
              ),
            );
          },
        ),
        ListTile(
          title: const Text('Endocrinology'),
          onTap: () {
            Utilities.urlLauncher(Uri.parse("https://tngendocrine.com"));
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Foundation'),
          onTap: () {
            Utilities.urlLauncher(Uri.parse("http://www.fresnonephrologykidneyfoundation.org"));
            Navigator.pop(context);
          },
        ),
      ])
      );
  }
}