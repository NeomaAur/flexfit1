import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //debugShowCheckedModeBanner: false,
    home: ProfileScreen(),
  ));
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar background color
        title: Text('Profile', style: TextStyle(color: Colors.white)), // Title color
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile_picture.jpg'), // Ensure you have the image in your assets folder
            ),
            SizedBox(height: 20),
            // Name
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            // Bio or short description
            Text(
              'Fitness Enthusiast | Developer | Passionate About Health',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // Profile Details Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  ProfileDetailRow(
                    icon: Icons.email,
                    text: 'john.doe@example.com',
                  ),
                  Divider(),
                  // Phone Number
                  ProfileDetailRow(
                    icon: Icons.phone,
                    text: '+1 234 567 890',
                  ),
                  Divider(),
                  // Location
                  ProfileDetailRow(
                    icon: Icons.location_on,
                    text: 'New York, USA',
                  ),
                  Divider(),
                  // Edit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Action to edit profile
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Set the button color to black
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for displaying profile details
class ProfileDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  ProfileDetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
