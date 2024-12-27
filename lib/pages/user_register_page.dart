import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:login_auth/components/my_button.dart";
import "package:login_auth/components/my_textfield.dart";
import "package:login_auth/components/square_tiles.dart";
import "package:login_auth/pages/login_page.dart";

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp(BuildContext context) async {
    // Add sign up code here
    if (confirmPasswordController.text != passwordController.text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Passwords do not match!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          String? errorMessage;
          if (e.code == 'weak-password') {
            errorMessage = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            errorMessage = 'The account already exists for that email.';
          } else {
            errorMessage = e.message;
          }
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage!),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
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
                  'Register to use the app !',
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
                MyTextfield(
                  contorller: confirmPasswordController,
                  hinttext: 'Confirm Password',
                  obscureText: true,
                ),

                SizedBox(height: 10),

                // sign in button
                MyButton(
                  onTap: () => signUp(context),
                  text: 'Sign Up',
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
                    Text('Already a member?',
                        style: TextStyle(
                          color: Colors.grey[700],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      ),
                      child: Text('Log in',
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
