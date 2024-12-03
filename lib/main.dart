import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  //await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Start with the Splash Screen
    );
  }
}

// Splash Screen to handle Firebase initialization
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),  // Firebase initialization
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator until Firebase is ready
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle initialization errors (e.g., show an error message)
          return Scaffold(
            body: Center(
              child: Text('Error initializing Firebase'),
            ),
          );
        } else {
          // Once Firebase is initialized, navigate to the HomeScreen
          return HomeScreen();
        }
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flexfit'),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeText(),
            SizedBox(height: 20),
            _buildFeatureGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      backgroundColor: Colors.grey[100],
    );
  }

  // Welcome Text Widget
  Widget _buildWelcomeText() {
    return Text(
      'Welcome back!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  // Feature Grid Widget
  Widget _buildFeatureGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _features.length,
        itemBuilder: (context, index) {
          final feature = _features[index];
          return _buildFeatureCard(
            feature['icon'] as IconData,
            feature['title'] as String,
          );
        },
      ),
    );
  }

  // Feature Card Widget
  Widget _buildFeatureCard(IconData icon, String title) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 1,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40, color: Colors.black87),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bottom Navigation Bar Widget
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 5,
    );
  }
}

// Features List
final _features = [
  {'icon': Icons.fitness_center, 'title': 'Workouts'},
  {'icon': Icons.bar_chart, 'title': 'Progress'},
  {'icon': Icons.food_bank, 'title': 'Nutrition'},
  {'icon': Icons.person, 'title': 'Profile'},
];
