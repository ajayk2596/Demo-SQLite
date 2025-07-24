import 'package:flutter/cupertino.dart';

class CounterController  with ChangeNotifier{

  int counter=0;
  increment(){
    counter++;
    notifyListeners();
  }

  decrement(){
    if(counter>0){
      counter--;

    }
    notifyListeners();
  }
}