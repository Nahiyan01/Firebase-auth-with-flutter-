import 'package:flutter/material.dart';

class SquareTiles extends StatelessWidget {
  final String imagepath;
  const SquareTiles({super.key, required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          imagepath,
          height: 40,
        ),
      ),
    );
  }
}
