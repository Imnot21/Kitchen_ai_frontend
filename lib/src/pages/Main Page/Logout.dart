import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Credentials/loginpage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {

  // 🔥 Clear saved login when logging out
  Future<void> clearRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('remember_me');
    await prefs.remove('saved_email');
    await prefs.remove('saved_password');
  }

  // 🔥 Full logout (Google + Firebase)
  Future<void> fullSignOut() async {
    try {
      if (!kIsWeb) {
        await GoogleSignIn().signOut();
      }
      await _auth.signOut();
      await clearRememberMe();
    } catch (e) {
      print("Error signing out: $e"); 
    }
  }

  // 🔥 Confirmation dialog
  Future<bool?> showLogoutDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Log out?"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 242, 220),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : const AssetImage('assets/default_profile.png')
                        as ImageProvider,
              ),

              const SizedBox(height: 20),

              Text(
                user?.displayName ?? 'No name available',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 44, 72, 61),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                user?.email ?? 'No email available',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 44, 72, 61),
                ),
              ),

              const SizedBox(height: 30),

              // 🔥 LOGOUT BUTTON
              ElevatedButton(
                onPressed: () async {
                  bool? confirm = await showLogoutDialog();

                  if (confirm == true) {
                    await fullSignOut();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  }
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color.fromARGB(255, 44, 72, 61),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  print('Settings pressed');
                },
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    color: Color.fromARGB(255, 44, 72, 61),
                    fontSize: 18,
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
