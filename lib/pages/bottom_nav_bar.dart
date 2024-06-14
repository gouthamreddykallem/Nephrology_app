import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum NavBarItem { home, education, profile, aichat }

// extension NavBarItemExtensions on NavBarItem {
//   bool get isTopics => this == NavBarItem.home;
// }

final class NavBarController extends PageController {
  NavBarController({NavBarItem initialItem = NavBarItem.home})
      : _notifier = ValueNotifier<NavBarItem>(initialItem),
        super(initialPage: initialItem.index) {
    _notifier.addListener(_listener);
  }

  final ValueNotifier<NavBarItem> _notifier;

  NavBarItem get item => _notifier.value;
  set item(NavBarItem newItem) => _notifier.value = newItem;

  void _listener() {
    jumpToPage(item.index);
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) {
        context.read<NavBarController>().item = NavBarItem.values[index];
      },
      selectedFontSize: 20,
      selectedIconTheme: const IconThemeData(color: Colors.blue, size: 40),
      selectedItemColor: Colors.blue,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      currentIndex: context
          .select((NavBarController controller) => controller.item.index),
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
    );
  }
}
