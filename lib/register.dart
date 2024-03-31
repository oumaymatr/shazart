import 'package:flutter/material.dart';
import 'components/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forum.dart';

class Register extends StatelessWidget {
  Register({Key? key});

  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late String email;
  late String password;

  // register user method

  @override
  Widget build(BuildContext context) {
    Future<void> _signInWithGoogle() async {
      try {
        await AuthService()
            .signInWithGoogle(); // Call signInWithGoogle from AuthService
        // Navigate to the forum page after successful sign-in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Forum()),
        );
      } catch (e) {
        print("Error signing in with Google: $e");
        // Handle sign-in errors here
      }
    }

    Future<void> _signInWithFacebook() async {
      try {
        await AuthService()
            .signInWithFacebook(); // Call signInWithGoogle from AuthService
        // Navigate to the forum page after successful sign-in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Forum()),
        );
      } catch (e) {
        print("Error signing in with Facebook: $e");
        // Handle sign-in errors here
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFF4EADB),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              // logo
              Flexible(
                child: Icon(
                  Icons.lock,
                  color: Color(0xFF2D2D42),
                  size: 80,
                ),
              ),

              SizedBox(height: 20),

              // welcome message
              Text(
                'Welcome to our community!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontFamily: "ZenOldMincho",
                ),
              ),

              SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontFamily: "ZenOldMincho",
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: passwordController,
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontFamily: "ZenOldMincho",
                    ),
                  ),
                ),
              ),

              SizedBox(height: 60),

              // register button
              GestureDetector(
                onTap: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Forum()),
                      );
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF2D2D42),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "ZenOldMincho",
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: "ZenOldMincho",
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                        onTap: () => _signInWithGoogle(),
                        imagePath: 'assets/images/google.png'),

                    SizedBox(width: 15),

                    // facebook button
                    SquareTile(
                        onTap: () => _signInWithFacebook(),
                        imagePath: 'assets/images/facebook.png')
                  ],
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: "ZenOldMincho",
                    ),
                  ),
                  SizedBox(width: 2),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: "ZenOldMincho",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({
    Key? key,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: 35,
        ),
      ),
    );
  }
}
