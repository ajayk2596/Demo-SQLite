import 'package:demo_sqflite/provider/counter_controller.dart';
import 'package:demo_sqflite/provider/counter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
    ChangeNotifierProvider(create: (_)=>CounterController(),child: MyAppProvider(),)
  );
}
class MyAppProvider extends StatelessWidget {
  const MyAppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterScreen(),
    );
  }
}
