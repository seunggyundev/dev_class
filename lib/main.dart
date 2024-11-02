import 'package:devjang_class/models.dart';
import 'package:devjang_class/problem_solving/week1.dart';
import 'package:devjang_class/problem_solving/week2.dart';
import 'package:devjang_class/problem_solving/week3.dart';
import 'package:devjang_class/week2/widgets.dart';
import 'package:devjang_class/week3/provider_example.dart';
import 'package:devjang_class/week3/reponsive_example.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context) => NameProvider()),
        ],
        child: MyApp(),
    ),
  );
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
      home: NameStless(),
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
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomCard(title: 'title', description: 'description', color: Colors.blueGrey,),
              CustomCard(title: 'title', description: 'description', color: Colors.blue,),
              CustomCard(title: 'title', description: 'description', color: Colors.green,),
              CustomInputField(hintText: 'id를 입력해주세요', errorText: '오루발생', icon: Icons.access_alarm,),

            ],
          ),
        ],
      ),
    );
  }
}
