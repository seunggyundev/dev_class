import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ProviderExample(),
//       child: MyApp(),
//     ),
//   );
// }
//  _countProvider = Provider.of<NameProvider>(context, listen: true);
//  _countProvider.updateCount(2);

class CounterProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  updateCount(int count) {
    _count = count;
    notifyListeners();  // 호출해야 상태가 변경됐다고 알려줄 수 있다.
  }

  void increment() {
    _count++;
    notifyListeners();
  }
}

class NameProvider extends ChangeNotifier {
  String _name = '';
  String get name => _name;

  updateName(String name) {
    _name = name;
    notifyListeners();
  }
}