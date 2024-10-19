import 'package:devjang_class/models.dart';
import 'package:devjang_class/week2/widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textEditingController = TextEditingController();
  List entries = ['A', 'B', 'C', 'D'];
  User? user;

  @override
  void initState() {
    super.initState();
    Map dataMap = {
      'name': 'devjange',
      'phoneNum': '12341234'
    };
    user = User().returnModel(dataMap);
  }

  dataInit() {
    setState(() {
      Map dataMap = {
        'name': 'devjange',
        'phoneNum': '12341234'
      };
      user = User().returnModel(dataMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimationExample();
  }
}
