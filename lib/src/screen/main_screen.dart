import 'package:flutter/material.dart';
import 'package:practice_application/src/core/export.dart';
import 'package:practice_application/src/pages/Main Page/Logout.dart';
import 'package:practice_application/src/pages/Main Page/ingredients.dart';
import 'package:practice_application/src/pages/Main Page/inventory.dart';
import 'package:practice_application/src/pages/Main Page/planner.dart';
import 'package:practice_application/src/pages/Main Page/recipe.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2; // Planner tab shown first

  String _recipeText = '';
  bool _recipeEnabled = true;

  final String userName = 'Adam Christopher M. Peras';
  final String userEmail = 'azazeljim69@gmail.com';

  final List<String> _titles = [
    'Ingredients',
    'Favorites',
    'Planner',
    'Recipes',
    'Profile',
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _enableAndShowRecipe(String text) {
    setState(() {
      _recipeText = text;
      _recipeEnabled = true;
      _selectedIndex = 3; // Switch to Recipes tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      IngredientsTab(),                                   // 0
      const FavoritesTab(),                               // 1
      Planner(onRecipeGenerated: _enableAndShowRecipe),   // 2
      RecipesTab(recipeText: _recipeText),                // 3
      ProfilePage(userName: userName, userEmail: userEmail), // 4
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
