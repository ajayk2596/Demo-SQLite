import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Shimmer Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.red[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: double.infinity, height: 20.0, color: Colors.red),
                SizedBox(height: 10),
                Container(width: 200.0, height: 20.0, color: Colors.white),
                SizedBox(height: 10),
                Container(width: 100.0, height: 20.0, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
