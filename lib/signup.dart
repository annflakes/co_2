import 'package:co_2/home.dart';
import 'package:flutter/material.dart';
import 'package:co_2/sigin.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
           colors: [ Color(0xFF40E0D0),Color(0xFF2C2C2C)], // Gradient colors
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                _buildTextField("UserName", Icons.check, false),
                _buildTextField("Email", Icons.check, false),
                _buildPasswordField("Password", _obscurePassword, (value) {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                }),
                _buildPasswordField("Confirm Password", _obscureConfirmPassword, (value) {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                }),
                SizedBox(height: 30),
                Center(
                  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );// TODO: Im  plement signup logic
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ).copyWith(
          backgroundColor: WidgetStateProperty.all<Color>(
            Colors.transparent,
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF40E0D0), Color(0xFF2C2C2C)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(minWidth: 150, minHeight: 50),
            child: Text(
              "SIGN UP",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),

      SizedBox(height: 16), // Space between Sign Up and Sign In section

      // Label: "If already have an account"
      Text(
        "If already have an account",
        style: TextStyle(
          fontSize: 14,
          color: const Color.fromARGB(254, 252, 241, 241),
        ),
      ),

      SizedBox(height: 8), // Small space between label and Sign In button

      // Sign In Button
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        },
        child: Text(
          "Sign In",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 239, 238, 238), // Match primary color
          ),
        ),
      ),
    ],
  ),
),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: const Color.fromARGB(255, 247, 247, 247), fontWeight: FontWeight.bold),
          suffixIcon: Icon(icon, color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 28, 183, 144)),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, bool obscureText, Function toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: const Color.fromARGB(255, 255, 253, 253), fontWeight: FontWeight.bold),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
            onPressed: () => toggleVisibility(obscureText),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 28, 183, 144)),
          ),
        ),
      ),
    );
  }
}
