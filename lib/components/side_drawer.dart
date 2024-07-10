import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/contact_us_page.dart';
import 'package:nephrology_app/pages/details_page.dart';
import 'package:nephrology_app/pages/education_page.dart';
import 'package:nephrology_app/pages/online_forms_page.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:nephrology_app/shared/data.dart';
import 'package:nephrology_app/utilities/utils.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      UserAccountsDrawerHeader(
        decoration: const BoxDecoration(color: primaryColor),
        accountName: Container(
          padding: const EdgeInsets.only(top: 16.0),
          child: const Text(
            'User Name',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
        // accountEmail: const Text(
        //   'username@mail.com',
        //   style: TextStyle(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //     color: Colors.white,
        //   ),
        // ),
        accountEmail: null,
        currentAccountPicture: const Icon(
          Icons.account_circle_rounded,
          size: 80.0,
          color: Colors.white,
        ),
      ),
      ListTile(
        title: const Text('Home'),
        onTap: () {
          Navigator.pop(context);
        },
        leading: const Icon(
          Icons.home_rounded,
          size: 26.0,
        ),
      ),
      const Divider(),
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
        leading: const Icon(
          Icons.assignment,
          size: 26.0,
        ),
      ),
      ListTile(
        title: const Text('Education'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const EducationBody();
              },
            ),
          );
        },
        leading: const Icon(
          Icons.school_rounded,
          size: 26.0,
        ),
      ),
      ListTile(
        title: const Text('Resources'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(details: resources),
            ),
          );
        },
        leading: const Icon(
          Icons.library_books_rounded,
          size: 26.0,
        ),
      ),
      ListTile(
        title: const Text('Kidney Foundation'),
        onTap: () {
          Utilities.urlLauncher(
              Uri.parse("http://www.fresnonephrologykidneyfoundation.org"));
        },
        leading: const Icon(
          Icons.foundation_rounded,
          size: 26.0,
        ),
      ),
      const Divider(),
      ListTile(
        title: const Text('Contact Us'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const ContactUsPage();
              },
            ),
          );
        },
        leading: const Icon(
          Icons.call,
          size: 26.0,
        ),
      ),
    ]));
  }
}
