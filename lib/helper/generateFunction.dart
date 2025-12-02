import 'package:flutter/material.dart';
import '../services/airesponse.dart'; 
import '../services/filePickerController.dart';

Future<void> handleRecipeGeneration({
  required BuildContext context,
  required Controller controller,
  required VoidCallback setGeneratingTrue,
  required void Function(String ingredients, String recipes) onGenerated, // updated callback
}) async {
  if (controller.selectedImage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please take or upload an image first."),
      ),
    );
    return;
  }

  setGeneratingTrue();

  try {
    final result = await AIService.generateRecipe(controller.selectedImage!);

    if (result != null) {
      final ingredients = result['ingredients'] ?? '';
      final recipes = result['recipes'] ?? '';

      // Handle non-food images
      if (recipes.startsWith('❌')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(recipes)),
        );
        return;
      }

      // Forward both ingredients and recipes to your planner or UI
      onGenerated(ingredients, recipes);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to generate recipe."),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error generating recipe: $e"),
      ),
    );
  }
}
