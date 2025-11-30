
import 'package:flutter/material.dart';
import '../services/airesponse.dart'; 
import '../services/filePickerController.dart';

 

Future<void> handleRecipeGeneration({
  required BuildContext context,
  required Controller controller,
  required VoidCallback setGeneratingTrue,
  required void Function(String) onGenerated, // new callback
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

  final recipeText = await AIService.generateRecipe(
    controller.selectedImage!,
  );

  if (recipeText != null) {
    // instead of pushing a new route, forward recipe to the caller
    onGenerated(recipeText);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Failed to generate recipe."),
      ),
    );
  }
}