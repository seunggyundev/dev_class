import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 수업내용
class ClassProblem {
  // [Dart 기본 문법 및 조건문 관련 문제]
  // 문제 1: 조건문과 반복문을 활용한 숫자 출력
  //
  // 사용자가 입력한 숫자가 짝수인지 홀수인지 구분하여 출력하고, 1부터 사용자가 입력한 숫자까지의 모든 숫자를 출력하는 프로그램을 작성하세요.
  //
  // 조건:
  //
  // 숫자가 짝수일 경우 "짝수입니다."라고 출력하고, 홀수일 경우 "홀수입니다."라고 출력하세요.
  // for 반복문을 사용하여 1부터 입력된 숫자까지 출력하세요.
  void checkEvenOddAndPrintNumbers(int number) {
    // 짝수 또는 홀수 판별
    if (number % 2 == 0) {
      print('짝수입니다.');
    } else {
      print('홀수입니다.');
    }

    // 1부터 입력된 숫자까지 출력
    for (int i = 1; i <= number; i++) {
      print(i);
    }
  }


  //  리스트에 값 추가하기
  //
  // List.add() 메소드를 사용하여 사용자가 입력한 세 가지 값을 리스트에 추가하고, 모든 리스트 값을 출력하는 프로그램을 작성하세요.
  void addValuesToListAndPrint() {
    List<String> myList = [];

    // 리스트에 값 추가
    myList.add('첫 번째 값');
    myList.add('두 번째 값');
    myList.add('세 번째 값');

    // 리스트 출력
    print('리스트에 추가된 값들:');
    for (var item in myList) {
      print(item);
    }
  }

  //  다이얼로그 띄우기
//
// 사용자가 버튼을 클릭하면 경고 다이얼로그를 띄우는 Flutter 앱을 작성하세요. 다이얼로그에는 "확인" 버튼이 포함되어 있으며, 사용자가 "확인" 버튼을 클릭하면 다이얼로그가 닫히도록 구현하세요.
  void showDialogWidget(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('경고'),
          content: Text('이것은 경고 메시지입니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

// 쿠퍼티노 디자인을 사용한 앱 만들기
//
// Flutter의 Cupertino 위젯을 사용하여 간단한 iOS 스타일의 앱을 구현하세요. 앱에는 "Hello, Cupertino!"라는 텍스트와 "버튼 클릭"이라는 텍스트를 가진 버튼이 포함되어 있어야 하며, 버튼을 클릭하면 콘솔에 메시지를 출력하세요.
class CupertinoExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('쿠퍼티노 디자인 예제'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello, Cupertino!'),
            CupertinoButton(
              color: CupertinoColors.activeBlue,
              child: Text('버튼 클릭'),
              onPressed: () {
                print('Cupertino 버튼이 눌렸습니다!');
              },
            ),
          ],
        ),
      ),
    );
  }
}

//  애니메이션 적용하기
//
// Flutter에서 애니메이션을 사용하여, 버튼을 클릭하면 텍스트가 왼쪽에서 오른쪽으로 이동하는 애니메이션을 구현하세요.
class AnimationExampleText extends StatefulWidget {
  @override
  _AnimationExampleTextState createState() => _AnimationExampleTextState();
}

class _AnimationExampleTextState extends State<AnimationExampleText> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    // AnimationController: 애니메이션을 시작하거나 중지하고, 재생 속도를 조절하는 역할을 합니다.
    // duration: 애니메이션의 길이(시간)를 설정합니다. 여기서는 2초 동안 애니메이션이 실행됩니다.
    // vsync: 애니메이션이 화면 주사율에 맞춰 실행되도록 도와줍니다. 성능을 최적화하는 데 유용하며, SingleTickerProviderStateMixin을 사용해 설정합니다.
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    // Tween: 시작 위치(begin)와 끝 위치(end)를 지정해 애니메이션이 어디에서 어디로 이동할지 설정합니다. 여기서는 텍스트가 (-1, 0)에서 시작해 (1, 0)으로 이동합니다.
    // Offset(-1, 0): 화면의 왼쪽 바깥쪽에서 시작.
    // Offset(1, 0): 화면 오른쪽 바깥쪽으로 이동.
    // .animate(_controller!): Tween과 AnimationControll
    // Offset은 화면의 특정 위치를 X축과 Y축 좌표로 표현하는 방식이다.
    // X축(Offset(x,0)) - -1.0 : 화면의 왼쪽 바깥에서 시작, 0.0 : 중앙, 1.0 : 화면의 오른쪽 바깥에서 시작
    // Y축 - -1.0 : 화면의 위쪽 바깥 영역, 0.0 중앙, 1.0 : 아랫쪽
    _animation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(1, 0),
    ).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('애니메이션 예제'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SlideTransition: SlideTransition은 position을 통해 텍스트의 위치를 설정하고, 이 위치는 Tween에서 지정한 위치로 애니메이션됩니다.
            // position: _animation!: 애니메이션이 설정된 _animation의 위치에 따라 텍스트가 이동합니다.
            // child: 애니메이션이 적용될 위젯으로, 여기서는 '움직이는 텍스트'가 이동합니다.
            SlideTransition(
              position: _animation!,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                child: Text("움직이는 텍스트",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // 페이지 이동 예시
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingListScreen()));

                // var status = _controller?.status;
                // if (status == AnimationStatus.completed) {
                //   _controller!.reverse();  // 끝에 도달하기
                // } else if (status == AnimationStatus.dismissed) {
                //   _controller!.forward();  // 시작점으로 돌아가기
                // }
              },
              child: Text('애니메이션 시작'),
            ),
          ],
        ),
      ),
    );
  }
}

// 쇼핑 리스트 앱 만들기
// Flutter의 여러 위젯을 활용하여 간단한 쇼핑 리스트 앱을 구현하세요. 사용자는 물품 이름과 가격을 입력하고, 이를 리스트에 추가할 수 있어야 합니다. 추가된 아이템들은 리스트로 보여지며, 총합을 계산하여 표시합니다.
//
// 기능 요구 사항:
//
// 사용자는 물품 이름과 가격을 입력할 수 있어야 합니다.
// "추가" 버튼을 눌러 입력한 물품을 리스트에 추가.
// 추가된 물품들은 ListView로 화면에 표시됩니다.
// 물품 리스트 아래에는 총 금액이 표시됩니다.
// 각 물품 항목을 길게 누르면 삭제할 수 있도록 GestureDetector를 사용.
class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final _formKey = GlobalKey<FormState>();
  String itemName = '';
  double itemPrice = 0.0;
  List<Map<String, dynamic>> shoppingList = [];

  double get totalPrice {
    // 축약적으로 합치는걸 표현할 수 있구나~~
    return shoppingList.fold(0, (sum, item) => sum + item['price']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text('쇼핑 리스트')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: '물품 이름'),
                    onChanged: (value) {
                      setState(() {
                        itemName = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '물품 이름을 입력하세요';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: '가격',
                      errorStyle: TextStyle(color: Colors.blue), // validator가 리턴한 텍스트의 스타일 지정
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        itemPrice = double.tryParse(value) ?? 0.0;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return '유효한 가격을 입력하세요';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          shoppingList.add({'name': itemName, 'price': itemPrice});
                        });
                      }
                    },
                    child: Container(
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          '추가',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: ListView.builder(
                itemCount: shoppingList.length,
                itemBuilder: (context, index) {
                  final item = shoppingList[index];
                  return GestureDetector(
                    onLongPress: () {
                      setState(() {
                        shoppingList.removeAt(index); // 항목 삭제
                      });
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(item['name']),
                        trailing: Text('${item['price']} 원'),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '총 금액: $totalPrice 원',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}