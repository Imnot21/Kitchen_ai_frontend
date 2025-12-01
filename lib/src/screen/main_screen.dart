import 'package:flutter/material.dart';
import '../core/export.dart';
import '../pages/Main Page/Logout.dart';
import '../pages/Main Page/inventory.dart';
import '../pages/Main Page/planner.dart';
import '../pages/Main Page/recipe.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  String _recipeText = '';
  bool _recipeEnabled = true;

  // Example user data - replace with your user management
  final String userName = 'Adam Christopher M. Peras';
  final String userEmail = 'azazeljim69@gmail.com';

  final List<String> _titles = ['Favorites', 'Fridge', 'Recipes', 'Profile'];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Show recipe tab with generated recipe text
  void _enableAndShowRecipe(String text) {
    setState(() {
      _recipeText = text;
      _recipeEnabled = true;
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const FavoritesTab(),
      Planner(onRecipeGenerated: _enableAndShowRecipe),  // Pass callback here
      RecipesTab(recipeText: _recipeText),
      ProfilePage(userName: userName, userEmail: userEmail),  // No extra ()
    ];

    return Scaffold(
      appBar: Appbar(title: _titles[_selectedIndex]),
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: Navbar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        recipeEnabled: _recipeEnabled,
      ),
    );
  }
}

