import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/components/my_button.dart';
import 'package:login_auth/components/my_textfield.dart';
import 'package:login_auth/components/square_tiles.dart';
import 'package:login_auth/pages/home_page.dart';
import 'package:login_auth/pages/passwordReset_page.dart';
import 'package:login_auth/pages/user_register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signIn(BuildContext context) async {
    FirebaseAuth.instance.setLanguageCode('en');
    try {
      // Show loading indicator
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      // Sign in logic
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Close loading indicator
      Navigator.pop(context);

      // Navigate to HomePage on successful sign-in
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Close loading indicator
      Navigator.pop(context);

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) {
          String errorMessage;
          if (e.code == 'user-not-found') {
            errorMessage = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            errorMessage = 'Wrong password provided for that user.';
          } else {
            errorMessage = 'An error occurred. Please try again.';
          }
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Close loading indicator
      Navigator.pop(context);

      // Show generic error dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                //logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                // welcome back, you've been missed!
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // username textfield
                MyTextfield(
                  contorller: emailController,
                  hinttext: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                //password textfield

                MyTextfield(
                  contorller: passwordController,
                  hinttext: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: 10),

                //forgot password?
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PasswordResetPage(),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // sign in button
                MyButton(
                  onTap: () => signIn(context),
                  text: 'Sign In',
                ),
                SizedBox(height: 7.0),

                //or continue with
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('or continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          )),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google image
                    SquareTiles(imagepath: 'lib/Images/google.png'),
                    SizedBox(
                      width: 10,
                    ),
                    //apple image
                    SquareTiles(imagepath: 'lib/Images/apple.png'),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',
                        style: TextStyle(
                          color: Colors.grey[700],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserRegisterPage(),
                        ),
                      ),
                      child: Text('Register',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
