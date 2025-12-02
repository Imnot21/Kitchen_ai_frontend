import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IngredientsTab extends StatefulWidget {
  const IngredientsTab({super.key});

  @override
  State<IngredientsTab> createState() => _IngredientsTabState();
}

class _IngredientsTabState extends State<IngredientsTab> {
  List<String> ingredientsList = [];

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  // Load ingredients from SharedPreferences
  Future<void> _loadIngredients() async {
    final prefs = await SharedPreferences.getInstance();
    ingredientsList = prefs.getStringList('ingredientsList') ?? [];
    setState(() {});
  }

  // Remove a specific ingredient from the list
  Future<void> _removeIngredient(String ingredient) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      ingredientsList.remove(ingredient);
    });
    await prefs.setStringList('ingredientsList', ingredientsList);
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
            onRefresh: _loadIngredients,
            child: ingredientsList.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: 200),
                      Center(
                        child: Text(
                          "No ingredients available.",
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: ingredientsList.length,
                    itemBuilder: (context, index) {
                      final ingredient = ingredientsList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                ingredient,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: const Color.fromARGB(255, 44, 72, 61),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeIngredient(ingredient),
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
