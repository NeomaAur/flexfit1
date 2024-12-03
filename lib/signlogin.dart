import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthenticationScreen(),
  ));
}

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isSignUp = false;  // Toggle between Sign Up and Sign In

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 2),
            Center(
              child: Icon(
                Icons.fitness_center,
                color: Colors.black,
                size: 64,
              ),
            ),
            SizedBox(height: 20),
            Text(
              isSignUp ? "Join Us Today!" : "Welcome Back, Champ!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              isSignUp
                  ? "Create your account and get started"
                  : "Sign in to continue your fitness journey",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            Spacer(flex: 1),
            _buildTextField(
              hint: "Email",
              icon: Icons.email_outlined,
              controller: _emailController,
            ),
            SizedBox(height: 16),
            _buildTextField(
              hint: "Password",
              icon: Icons.lock_outline,
              controller: _passwordController,
              isPassword: true,
            ),
            SizedBox(height: 24),
            _buildButton(
              text: isSignUp ? "Sign Up" : "Sign In",
              onPressed: () async {
                try {
                  if (isSignUp) {
                    // Sign up
                    await _auth.createUserWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    // Navigate to home screen after successful sign-up
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    // Sign in
                    await _auth.signInWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    // Navigate to home screen after successful sign-in
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Error')),
                  );
                }
              },
            ),
            Spacer(flex: 2),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSignUp = !isSignUp; // Toggle between sign-up and sign-in
                  });
                },
                child: Text(
                  isSignUp
                      ? "Already have an account? Sign In"
                      : "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(child: Text("Welcome to the Home Screen!")),
    );
  }
}
