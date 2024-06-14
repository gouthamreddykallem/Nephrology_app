import 'package:flutter/material.dart';

class AppBarTop extends StatefulWidget implements PreferredSizeWidget {
  const AppBarTop({super.key});

  @override
  State<AppBarTop> createState() => _AppBarTopState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _AppBarTopState extends State<AppBarTop> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/logo.jpg', fit: BoxFit.cover, height: 70),
      // toolbarHeight: 150,
      // const Text('The Nephrology Group, Inc'),
      backgroundColor: Colors.white,
      // onSearch: (value) => setState(() => searchValue = value),
    );
  }
}
