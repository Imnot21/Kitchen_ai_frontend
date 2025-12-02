import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  List<String> favoriteRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favoriteRecipes = prefs.getStringList('favoriteRecipes') ?? [];
    setState(() {});
  }

  Future<void> _removeFavorite(String recipe) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteRecipes.remove(recipe);
    });
    await prefs.setStringList('favoriteRecipes', favoriteRecipes);
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
            color:  Color.fromARGB(255, 255, 242, 220),
            borderRadius: BorderRadius.circular(12),
          ),

          child: RefreshIndicator(
            onRefresh: _loadFavorites,

    child: favoriteRecipes.isEmpty
    ? RefreshIndicator(
        onRefresh: _loadFavorites,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Center(
              child: Text(
                "No favorite recipes yet.",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Color.fromARGB(255, 44, 72, 61),
                ),
              ),
            ),
          ),
        ),
      )



                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: favoriteRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = favoriteRecipes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
  crossAxisAlignment: CrossAxisAlignment.start,   // ADD THIS
  children: [
    Expanded(
      child: Text(
        recipe,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: const Color.fromARGB(255, 44, 72, 61),
        ),
      ),
    ),
    IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () => _removeFavorite(recipe),
    ),
  ],
),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
