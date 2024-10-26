
import 'package:devjang_class/problem_solving/week2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widgets {
  Widget containerWidget() {
    return Container(
      width: 100,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 6,
            offset: Offset(1, 1),
          )
        ],
      ),
    );
  }

  Widget rowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 30,
          color: Colors.black,
        ),
        SizedBox(width: 10,),
        containerWidget(),
        SizedBox(width: 10,),
        Container(
          width: 100,
          height: 30,
          color: Colors.blueGrey,
        ),
      ],
    );
  }

  void showAlertDialog(BuildContext context) {

    GestureDetector(
      onTap: () {
        print('화면이 터치되었습니다.');
      },
      child: Container(
        color: Colors.blue,
        height: 100,
        width: 100,
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('경고'),
          content: Text('이것은 경고 메시지입니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Widget cupertinoWidget() {

    return CupertinoButton(
      color: CupertinoColors.activeBlue,
      child: Text('쿠퍼티노 버튼'),
      onPressed: () {
        print('Cupertino 버튼 클릭');
      },
    );
  }

  // 다이얼로그를 보여주는 함수
  void showCupertinoDialogExample(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('경고'),
          content: Text('이것은 iOS 스타일의 다이얼로그입니다.'),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();  // 다이얼로그 닫기
              },
              child: Text('확인'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop();  // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }

}

class DrawerExample extends StatefulWidget {
  @override
  _DrawerExampleState createState() => _DrawerExampleState();
}

class _DrawerExampleState extends State<DrawerExample> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();

    // AnimationController 설정 (애니메이션 길이는 2초)
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Tween을 사용해 시작 위치와 끝 위치 지정
    _animation = Tween<Offset>(
      begin: Offset(-1, 0),  // 왼쪽에서 시작
      end: Offset(1, 0),     // 오른쪽으로 이동
    ).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();  // AnimationController 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return drawerExam();

    return Scaffold(
      appBar:AppBar(
        title: Text('Flutter AppBar'),  // 제목을 설정
        centerTitle: true,  // 제목을 중앙에 배치
        leading: IconButton(
          icon: Icon(Icons.menu),  // 왼쪽에 햄버거 메뉴 아이콘 추가
          onPressed: () {
            print('메뉴 버튼 클릭됨');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),  // 오른쪽에 검색 아이콘 추가
            onPressed: () {
              print('검색 버튼 클릭됨');
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),  // 오른쪽에 알림 아이콘 추가
            onPressed: () {
              print('알림 버튼 클릭됨');
            },
          ),
        ],
        backgroundColor: Colors.blue,  // 앱바 배경색 설정
        elevation: 4.0,  // 그림자 효과 (elevation) 설정
        toolbarHeight: 70.0,  // 앱바의 높이 설정
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 애니메이션이 적용된 SlideTransition 위젯
            SlideTransition(
              position: _animation!,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.red,
                child: Text(
                  '움직이는 텍스트',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 32),
            // 애니메이션 시작 버튼
            ElevatedButton(
              onPressed: () {
                _controller!.forward();  // 애니메이션 시작
              },
              child: Text('애니메이션 시작'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller!.reverse();  // 애니메이션 반대로 실행
              },
              child: Text('애니메이션 뒤로'),
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Widgets().showCupertinoDialogExample(context);
                    },
                    child: Text('쿠퍼티노 예시')),
                Widgets().cupertinoWidget()
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '비즈니스',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '학교',
          ),
        ],
        currentIndex: _tabIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          print('선택된 탭: $index');
          setState(() {
            _tabIndex = index;
          });
        },
      )
      ,
    );
  }

  Widget drawerExam() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Drawer Example'),
        centerTitle: true,  // 제목을 중앙에 배치
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),  // 햄버거 메뉴 아이콘 추가
              onPressed: () {
                Scaffold.of(context).openDrawer();  // Drawer 열기
              },
            );
          },
        ),
      ),
      body: Center(
        child: Text('Drawer 예제 화면'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('쇼핑화면으로 이동'),
              onTap: () {
                Navigator.pop(context);  // Drawer 닫기
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShoppingListScreen()));

                // 홈 화면으로 이동하는 로직을 추가할 수 있습니다.
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('설정'),
              onTap: () {
                Navigator.pop(context);  // Drawer 닫기
                // 설정 화면으로 이동하는 로직을 추가할 수 있습니다.
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_page),
              title: Text('연락처'),
              onTap: () {
                Navigator.pop(context);  // Drawer 닫기
                // 연락처 화면으로 이동하는 로직을 추가할 수 있습니다.
              },
            ),
          ],
        ),
      ),
    );
  }
}