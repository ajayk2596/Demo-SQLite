import 'package:demo_sqflite/provider/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Consumer<CounterController>(
          builder: (BuildContext context, counterController, Widget? child) {
            return Column(
              children: [
                Text("counter:${counterController.counter}",style: TextStyle(fontSize: 25),),
                IconButton(onPressed: counterController.increment, icon: Icon(Icons.add)),
                IconButton(onPressed: counterController.decrement, icon: Icon(Icons.remove)),
              ],
            );

          },)
      ),
    );
  }
}
