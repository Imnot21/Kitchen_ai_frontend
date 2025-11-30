import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navbar extends StatelessWidget {
  final currentIndex;
  final Function(int) onTap;
  final bool recipeEnabled;

  const Navbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.recipeEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 255, 242, 220),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color.fromARGB(255, 44, 72, 61),
      unselectedItemColor: Color.fromARGB(255, 44, 72, 61),
      elevation: 0,
      selectedFontSize: 15,
      unselectedFontSize: 15,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 2 && !recipeEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Recipe tab is disabled until a recipe is generated.',
              ),
            ),
          );
          return;
        }
        onTap(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/heart.svg',
            width: 40,
            height: 40,
            color: const Color.fromARGB(255, 44, 72, 61),
          ),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/planner.svg',
            width: 40,
            height: 40,
            color: const Color.fromARGB(255, 44, 72, 61),
          ),
          label: 'Planner',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/chef-svgrepo-com.svg',
            width: 40,
            height: 40,
            color: Color.fromARGB(255, 44, 72, 61),
          ),
          label: 'Recipe',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_outlined,
            size: 40,
            color: Color.fromARGB(255, 44, 72, 61),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
