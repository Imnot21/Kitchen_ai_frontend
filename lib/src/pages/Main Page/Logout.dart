import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String bio; // Added
  final String phone; // Added

  const ProfilePage({
    super.key,
    required this.userName,
    required this.userEmail,
    this.bio = '',
    this.phone = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2DC),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture with Edit Icon
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xFFDAA520),
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Add update profile picture functionality
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF244B38),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // User Name
            Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF244B38),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            // User Email
            Text(
              userEmail,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF244B38),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Bio
            if (bio.isNotEmpty)
              Column(
                children: [
                  Text(
                    bio,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF244B38),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),

            // Phone
            if (phone.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone, color: Color(0xFF244B38)),
                  const SizedBox(width: 8),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF244B38),
                    ),
                  ),
                ],
              ),

            if (phone.isNotEmpty) const SizedBox(height: 32),

            // Edit Profile Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.edit, color: Color(0xFF244B38)),
                label: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF244B38),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF244B38), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // TODO: Navigate to edit profile page
                },
              ),
            ),

            const SizedBox(height: 16),

            // Logout Button (unchanged)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.logout, color: Color(0xFF244B38)),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF244B38),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF244B38), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // TODO: Add logout functionality
                },
              ),
            ),

            const Spacer(),

            // Settings Button
            TextButton.icon(
              onPressed: () {
                // TODO: Navigate to settings page
              },
              icon: const Icon(Icons.settings, color: Color(0xFF244B38)),
              label: const Text(
                'Settings',
                style: TextStyle(
                  color: Color(0xFF244B38),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
