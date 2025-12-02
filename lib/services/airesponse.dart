import 'package:image_picker/image_picker.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice_application/firebase_options.dart';

class AIService {
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /// Returns a Map with two keys: 'ingredients' and 'recipes'
  static Future<Map<String, String?>> generateRecipe(XFile image) async {
    await initializeFirebase();

    final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
    final imageBytes = await image.readAsBytes();
    final imagePart = InlineDataPart(image.mimeType ?? 'image/jpeg', imageBytes);

    // -----------------------------
    // Step 1: Extract ingredients
    // -----------------------------
    final ingredientsPrompt = TextPart("""
You are a professional food recognition AI.

Analyze the uploaded image and **list all visible ingredients only** in a simple comma-separated format.
If no food or ingredients are visible, reply with:
❌ "Please take another picture that contains food or ingredients."
""");

    final ingredientsResponse = await model.generateContent([
      Content.multi([ingredientsPrompt, imagePart])
    ]);

    final detectedIngredients = ingredientsResponse.text?.trim();

    // If the AI says there’s no food, return immediately
    if (detectedIngredients == null || detectedIngredients.startsWith('❌')) {
      return {
        'ingredients': null,
        'recipes': detectedIngredients, // Contains the warning message
      };
    }

    // -----------------------------
    // Step 2: Generate recipes
    // -----------------------------
    final recipesPrompt = TextPart("""
You are a professional chef and food expert.

Using the following ingredients: $detectedIngredients, generate **5 unique cooking recipes**.
Follow this exact format for each recipe:

--------------------------
🍽️ **[Name of Dish]**

**MAIN INGREDIENTS (🧄):** [Main items]  
**INGREDIENTS (🥕):**  
- [Ingredient 1]  
- [Ingredient 2]  
- [Ingredient 3]  

**INSTRUCTIONS (🔥):**  
1. [Step 1]  
2. [Step 2]  
3. [Step 3]  

**TIP (💡):** [Helpful tip or variation]
--------------------------

Rules:
- Do not include explanations or extra descriptions.
- Keep the formatting consistent and visually appealing.
""");

    final recipesResponse = await model.generateContent([
      Content.multi([recipesPrompt])
    ]);

    final generatedRecipes = recipesResponse.text?.trim();

    return {
      'ingredients': detectedIngredients,
      'recipes': generatedRecipes,
    };
  }
}
