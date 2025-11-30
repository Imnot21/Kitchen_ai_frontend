import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndUse extends StatelessWidget {
  const TermsAndUse({super.key});

  @override
  Widget build(BuildContext context) {
    final Color darkGreen = const Color(0xFF2D4739);
    final Color lightBeige = const Color(0xFFF9ECD8);
    final Color mustard = const Color(0xFFE9B44C);

    final TextStyle sectionStyle = GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: darkGreen,
    );

    final TextStyle bulletStyle = GoogleFonts.inter(
      fontSize: 16,
      color: darkGreen,
      height: 1.6,
    );

    return Scaffold(
      backgroundColor: lightBeige,
      appBar: AppBar(
        backgroundColor: lightBeige,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Terms & Conditions",
          style: GoogleFonts.inter(
            color: darkGreen,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _sectionTitle("1. Use of the App", sectionStyle),
              _bullet("Kitchen AI allows users to upload or capture food images.", bulletStyle, mustard),
              _bullet("You must be at least 13 years old or the legal digital age in your area.", bulletStyle, mustard),
              _bullet("The license to use the app is personal, non-commercial, and non-transferable.", bulletStyle, mustard),

              _sectionTitle("2. User Accounts", sectionStyle),
              _bullet("Some features require creating an account.", bulletStyle, mustard),
              _bullet("You must provide accurate and up-to-date information.", bulletStyle, mustard),
              _bullet("You are responsible for safeguarding your login credentials.", bulletStyle, mustard),

              _sectionTitle("3. User Content", sectionStyle),
              _bullet("You retain ownership of the images/data you upload.", bulletStyle, mustard),
              _bullet("You grant Kitchen AI permission to process your content to operate and improve the app.", bulletStyle, mustard),
              _bullet("Content must not violate laws, privacy, or third-party rights.", bulletStyle, mustard),

              _sectionTitle("4. AI-Generated Content", sectionStyle),
              _bullet("AI recipes may not always be accurate or safe.", bulletStyle, mustard),
              _bullet("Always verify food-safety steps, ingredients, and allergens.", bulletStyle, mustard),
              _bullet("AI results are used at your own risk.", bulletStyle, mustard),

              _sectionTitle("5. Intellectual Property", sectionStyle),
              _bullet("App assets and designs are legally protected.", bulletStyle, mustard),
              _bullet("You may not reverse-engineer, modify, or reproduce any part of the app.", bulletStyle, mustard),
              _bullet("AI outputs are for personal use only.", bulletStyle, mustard),

              _sectionTitle("6. Privacy", sectionStyle),
              _bullet("Your data is handled according to the Privacy Policy.", bulletStyle, mustard),
              _bullet("You may request data deletion where legally applicable.", bulletStyle, mustard),

              _sectionTitle("7. Disclaimers & Liability", sectionStyle),
              _bullet("The app is provided “as is” without warranties.", bulletStyle, mustard),
              _bullet("We are not responsible for food-safety issues or recipe inaccuracies.", bulletStyle, mustard),
              _bullet("Maximum liability is limited to ₱5,000 or as required by law.", bulletStyle, mustard),

              _sectionTitle("8. Termination", sectionStyle),
              _bullet("We may suspend or terminate access if Terms are violated.", bulletStyle, mustard),
              _bullet("You may delete your account anytime.", bulletStyle, mustard),

              _sectionTitle("9. Changes to Terms", sectionStyle),
              _bullet("Terms may be updated periodically.", bulletStyle, mustard),
              _bullet("Continued use signifies acceptance of updates.", bulletStyle, mustard),

              _sectionTitle("10. Governing Law", sectionStyle),
              _bullet("Governed by Philippine law.", bulletStyle, mustard),
              _bullet("Disputes handled in courts of Santa Cruz, Laguna.", bulletStyle, mustard),

              _sectionTitle("11. Contact", sectionStyle),
              _bullet("Kitchen AI Support", bulletStyle, mustard),
              _bullet("Email: azazeljin69@gmail.com", bulletStyle, mustard),
              _bullet("Address: Santa Cruz, Laguna, Philippines", bulletStyle, mustard),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(text, style: style),
    );
  }

  Widget _bullet(String text, TextStyle style, Color bulletColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: style.copyWith(color: bulletColor)),
          Expanded(
            child: Text(
              text,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
