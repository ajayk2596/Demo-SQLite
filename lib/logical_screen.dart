import 'package:flutter/material.dart';

class LogicalScreen extends StatelessWidget {
  final VoidCallback onThemeChanged;

  const LogicalScreen({
    super.key,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Toggle"),
        actions: [
          IconButton(
            onPressed: onThemeChanged,
            icon: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              isDark ? "Dark Theme (System)" : "Light Theme (System)",
              style: TextStyle(fontSize: 20),
            ),
            Image.asset("assets/images/ajay.jpg")
          ],
        )
      ),
    );
  }
}
