import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/components/my_button.dart';
import 'package:login_auth/components/my_textfield.dart';

class PasswordResetPage extends StatelessWidget {
  PasswordResetPage({super.key});

  final emailcontroller = TextEditingController();

  void sendpasswordResetEmail(BuildContext context) async {
    // Add send password reset email code here
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Password reset email sent!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          String errorMessage;
          if (e.code == 'user-not-found') {
            errorMessage = 'No user found for that email.';
          } else {
            errorMessage = e.message!;
          }
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
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
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
                contorller: emailcontroller,
                obscureText: false,
                hinttext: 'Email'),
            MyButton(
                onTap: () => sendpasswordResetEmail(context),
                text: 'Send Reset Email'),
          ],
        ),
      ),
    );
  }
}
