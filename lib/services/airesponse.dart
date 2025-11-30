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

  static Future<String?> generateRecipe(XFile image) async {
    await initializeFirebase();

    final model =
        FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');

    final imageBytes = await image.readAsBytes();

    final prompt = TextPart("""
You are a professional chef and food recognition expert.

Analyze the uploaded image carefully.

1. **If the image contains food, ingredients, or a meal:**
   - Identify the visible ingredients.
   - Generate **5 unique cooking recipes** that can be made using those ingredients.
   - Follow this exact format for each recipe:

--------------------------
🍽️ **RECIPE 1: [Name of Dish]**

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

2. **If the image does NOT contain food or ingredients** (for example, if it shows a human, an object, an animal, a landscape, etc.):
   - Do NOT generate recipes.
   - Instead, reply with this message only:

❌ "Please take another picture that contains food or ingredients. I can only generate recipes from food images."

Rules:
- Do not include explanations or extra descriptions.
- Do not mix both recipes and the warning message — output one or the other.
- Keep the formatting consistent and visually appealing for app display.
""");
    

    final imagePart = InlineDataPart(image.mimeType ?? 'image/jpeg', imageBytes);

    final response = await model.generateContent([
      Content.multi([prompt, imagePart])
    ]);

  final recipeText = response.text ?? "Try another image!";

    return recipeText;
  }
}
