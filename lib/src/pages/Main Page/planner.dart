// ...existing code...
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../../helper/generateFunction.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/filePickerController.dart';
 


class Planner extends StatefulWidget {
  final void Function(String)? onRecipeGenerated;

  const Planner({super.key, required this.onRecipeGenerated});

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  final Controller controller = Controller();
  File? selectedImage;
  bool generating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 255, 242, 220),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      ' 🥦🍆🥔🍅',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 44, 72, 61),
                      ),
                    ),
                    Text(
                      'What’s cooking today?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 44, 72, 61),
                      ),
                    ),
                    Text(
                      '🥚🥩🍗🥓',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 44, 72, 61),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          await controller.pickImage(
                            context,
                            ImageSource.camera,
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 140,
                              color: Color.fromARGB(255, 44, 72, 61),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Take Photo',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 44, 72, 61),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await controller.pickImage(
                            context,
                            ImageSource.gallery,
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.image,
                              size: 140,
                              color: Color.fromARGB(255, 44, 72, 61),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Upload Image',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 44, 72, 61),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: generating
                      ? null
                      : () async {
                          await handleRecipeGeneration(
                            context: context,
                            controller: controller,
                            setGeneratingTrue: () => setState(() => generating = true),
                            onGenerated: (recipeText) {
                              // forward to MainScreen via provided callback
                              if (widget.onRecipeGenerated != null) {
                                widget.onRecipeGenerated!(recipeText);
                              }
                            },
                          ).whenComplete(() {
                            if (mounted) setState(() => generating = false);
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 44, 72, 61),
                  ),
                  child: generating
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(width: 12),
                            Text(
                              'Generating...',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Generate Recipe',
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}