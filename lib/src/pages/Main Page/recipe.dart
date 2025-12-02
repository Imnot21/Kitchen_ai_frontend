import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipesTab extends StatefulWidget {
  final String recipeText;

  const RecipesTab({super.key, required this.recipeText});

  @override
  State<RecipesTab> createState() => _RecipesTabState();
}

class _RecipesTabState extends State<RecipesTab> {
  List<String> recipes = [];
  List<String> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    _splitRecipes();
    _loadFavorites();
  }

  @override
  void didUpdateWidget(covariant RecipesTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.recipeText != widget.recipeText) {
      _splitRecipes();
    }
  }

  // 🔥 FIXED — now splitting using your actual Gemini format
  Future<void> _splitRecipes() async {
    final text = widget.recipeText.trim();

    if (text.isEmpty) {
      recipes = [];
    } else {
      // Split by lines of "--------------------------"
      final parts = text
          .split(RegExp(r'-{10,}'))
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      recipes = parts;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('allRecipes', recipes);

    setState(() {});
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favoriteRecipes = prefs.getStringList('favoriteRecipes') ?? [];
    setState(() {});
  }

  Future<void> _toggleFavorite(String recipe) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (favoriteRecipes.contains(recipe)) {
        favoriteRecipes.remove(recipe);
      } else {
        favoriteRecipes.add(recipe);
      }
    });
    await prefs.setStringList('favoriteRecipes', favoriteRecipes);
  }

  bool _isFavorite(String recipe) {
    return favoriteRecipes.contains(recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 242, 220),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            maxWidth: 900,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 242, 220),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipes.isEmpty
                  ? [
                      Text(
                        'No recipes yet. Generate one from the Planner tab.',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 44, 72, 61),
                        ),
                      )
                    ]
                  : recipes.map((recipe) {
                      final isFav = _isFavorite(recipe);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                recipe,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color:
                                      const Color.fromARGB(255, 44, 72, 61),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isFav
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                              ),
                              onPressed: () => _toggleFavorite(recipe),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
