import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'loginpage.dart';
import '../../../services/authservices.dart';
import 'termsanduse.dart';
import '../../screen/main_screen.dart';
import 'package:flutter/gestures.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();  // Adding username field
  final AuthService _authService = AuthService();

  final bool _isPasswordVisible = false;
  final bool _rememberMe = false;
  bool _isLoading = false;

  void _signUpWithEmail() async {


if (!agreeToTerms) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Please agree to the Terms & Privacy Policy')),
  );
  return;
}

    // Input validation: Check if the fields are not empty
    if (emailAddress.text.isEmpty || password.text.isEmpty || username.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {


      _isLoading = true;
    });

    // Attempt to sign up the user with email and password
    final User? user = await _authService.signUpWithEmail(
      emailAddress.text.trim(),
      password.text.trim(),
    );

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-Up failed. Please check your credentials.')),
      );
    }
  }

  Future<User?> _signUpWithGoogle2() async {

if (!agreeToTerms) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Please agree to the Terms & Privacy Policy')),
  );
  return null;
}

    setState(() {
      _isLoading = true;
    });

    final User? user = await _authService.signInWithGoogle(
    );

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-Up failed. Please try again.')),
      );
    }
    return user;
  }

  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    final Color darkGreen = const Color(0xFF2D4739);
    final Color lightBeige = const Color(0xFFF9ECD8);
    final Color mustard = const Color(0xFFE9B44C);

    return Scaffold(
      backgroundColor: lightBeige,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Main Title
              Text(
                "Kitchen.ai",
                style: TextStyle(
                  color: darkGreen,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Your smart kitchen companion",
                style: TextStyle(
                  color: mustard,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 48),

              // Sign Up title
              Text(
                "Sign Up",
                style: TextStyle(
                  color: darkGreen,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 32),

              // Username
              _buildTextField("Username", mustard, controller: username),
              const SizedBox(height: 16),

              // Email
              _buildTextField("Email", mustard, controller: emailAddress),
              const SizedBox(height: 16),

              // Password
              _buildTextField("Password", mustard, controller: password, obscureText: true),
              const SizedBox(height: 8),

              // Terms Checkbox
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    activeColor: darkGreen,
                    onChanged: (val) {
                      setState(() => agreeToTerms = val!);
                    },
                    side: BorderSide(color: darkGreen, width: 1.5),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "I agree to the ",
                        style: TextStyle(color: darkGreen, fontSize: 15),
                        children: [
                          TextSpan(
                            text: "Terms & Privacy Policy.",
                            style: TextStyle(
                              color: darkGreen,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsAndUse()));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: _isLoading ? null : _signUpWithEmail,  // Disable button if loading
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )  // Show loading spinner
                      : const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // OR Divider
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      color: Color(0xFFE9B44C), // mustards
                      thickness: 1,
                      indent: 20,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                      color: Color(0xFF2D4739),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xFFE9B44C),
                      thickness: 1,
                      indent: 10,
                      endIndent: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Google Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: mustard, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: _signUpWithGoogle2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/google.svg',
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Sign Up with Google",
                        style: TextStyle(
                          color: Color(0xFF2D4739),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Already have account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, Color borderColor, {TextEditingController? controller, bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 1.8),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

