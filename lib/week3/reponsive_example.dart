import 'dart:convert';
import 'dart:io';

import 'package:devjang_class/week3/provider_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

/// 반응형 디자인
/// MediaQuery를 사용한 화면 크기 조정
class ResponsiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('반응형 화면')),
      body: Center(
        child: Text(
          width < 600 ? '모바일 화면' : '태블릿/데스크탑 화면',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// 예시 1: 화면의 너비와 높이에 비례하여 크기를 조정하는 컨테이너
class ProportionalContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('MediaQuery 크기 조정 예시')),
      body: Center(
        child: Container(
          width: screenWidth * 0.5,   // 너비의 50%
          height: screenHeight * 0.5, // 높이의 50%
          color: Colors.blue,
          child: Center(
            child: Text(
              '화면 크기에 맞춰 조정된 컨테이너',
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// 예시 2: 상단과 하단 비율에 맞춰 위젯 배치
class SplitScreenExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('상단/하단 비율 배치 예시')),
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.7,  // 높이의 70% 사용
            color: Colors.lightBlueAccent,
            child: Center(
              child: Text(
                '상단 이미지 (높이 70%)',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.3,  // 높이의 30% 사용
            color: Colors.blueGrey,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('버튼'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// LayoutBuilder를 사용한 화면 크기 조정
// LayoutBuilder를 사용하여 가로 폭이 500 이하일 때는 세로(Column) 레이아웃, 500 이상일 때는 가로(Row) 레이아웃을 사용하여 버튼 두 개를 배치해보세요.
class ResponsiveLayoutBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('반응형 레이아웃')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 500) {
            // 화면 폭이 500 이하인 경우: 세로 레이아웃
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('버튼 1')),
                ElevatedButton(onPressed: () {}, child: Text('버튼 2')),
              ],
            );
          } else {
            // 화면 폭이 500 이상인 경우: 가로 레이아웃
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('버튼 1')),
                SizedBox(width: 20),
                ElevatedButton(onPressed: () {}, child: Text('버튼 2')),
              ],
            );
          }
        },
      ),
    );
  }
}

// 예시 1: 화면 너비에 따라 레이아웃 변경 (그리드와 리스트 전환)
class ResponsiveGridList extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => '아이템 ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('그리드와 리스트 전환')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // 작은 화면에서는 리스트
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(items[index]),
              ),
            );
          } else {
            // 큰 화면에서는 2열 그리드
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // 그리드 열의 수를 지정
                mainAxisSpacing: 10,  // 아이템간의 수직간격 조정
                crossAxisSpacing: 10, // 아이템간의 수평간격 지정
                childAspectRatio: 0.75,  // 아이템의 가로와 세로 비율을 조정하여 아이템의 톺이 설정, ex.1.0은 정사각형 비율, 0.75는 높이가 더 긴 직사각형
              ),
              itemCount: items.length,
              itemBuilder: (context, index) => Card(
                child: Center(child: Text(items[index])),
              ),
            );
          }
        },
      ),
    );
  }
}

// 예시 2: 화면 크기에 따라 버튼 크기 조정 (가변 버튼 레이아웃)
class ResponsiveButtonLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('반응형 버튼 레이아웃')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 400) {
            // 작은 화면에서는 단일 열로 작은 버튼 배치
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('버튼 1')),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: Text('버튼 2')),
              ],
            );
          } else {
            // 큰 화면에서는 가로로 큰 버튼 두 개 배치
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('버튼 1'), style: ElevatedButton.styleFrom(minimumSize: Size(150, 50))),
                  SizedBox(width: 20),
                  ElevatedButton(onPressed: () {}, child: Text('버튼 2'), style: ElevatedButton.styleFrom(minimumSize: Size(150, 50))),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

// 예시 3: 복잡한 레이아웃에서 다중 열/단일 열 전환
class MultiColumnLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('다중 열 레이아웃 전환')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            // 큰 화면에서는 다중 열 레이아웃
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3,  // 가로 세로 비율 설정
              padding: EdgeInsets.all(16),
              children: List.generate(
                10,
                    (index) => Card(
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      '항목 ${index + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            );
          } else {
            // 작은 화면에서는 단일 열 레이아웃
            return ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) => Card(
                color: Colors.blueAccent,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      '항목 ${index + 1}',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

/// Flexible과 Expanded를 활용한 레이아웃 비율 조정
// 실습문제
class FlexibleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flexible과 Expanded')),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: Center(child: Text('위쪽 공간', style: TextStyle(color: Colors.white, fontSize: 24))),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              color: Colors.green,
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     ElevatedButton(onPressed: () {}, child: Text('버튼 1')),
              //     ElevatedButton(onPressed: () {}, child: Text('버튼 2')),
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }
}

// 예시 1: 상단, 중간, 하단 영역의 비율을 조정한 레이아웃
// 상단, 중간, 하단으로 나뉜 레이아웃에서 각각의 영역이 화면의 20%, 50%, 30%를 차지하도록 비율을 조정합니다.
// Column내부에서 Flexible과 Expanded를 사용하여 각 영역의 비율을 설정합니다.
class ProportionalLayoutExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('상단/중간/하단 비율 조정')),
      body: Column(
        children: [
          Flexible(
            flex: 2,  // 전체의 20% 차지
            child: Container(
              color: Colors.blue,
              child: Center(child: Text('상단 영역', style: TextStyle(color: Colors.white, fontSize: 18))),
            ),
          ),
          Expanded(
            flex: 5,  // 전체의 50% 차지
            child: Container(
              color: Colors.green,
              child: Center(child: Text('중간 영역', style: TextStyle(color: Colors.white, fontSize: 18))),
            ),
          ),
          Flexible(
            flex: 3,  // 전체의 30% 차지
            child: Container(
              color: Colors.orange,
              child: Center(child: Text('하단 영역', style: TextStyle(color: Colors.white, fontSize: 18))),
            ),
          ),
        ],
      ),
    );
  }
}

// 예시 2: 가로 방향의 비율에 따라 버튼 크기 조정
class ButtonProportionalRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('버튼 비율 조정')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,  // 2배 비율
              child: ElevatedButton(
                onPressed: () {},
                child: Text('버튼 1'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,  // 기본 비율
              child: ElevatedButton(
                onPressed: () {},
                child: Text('버튼 2'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,  // 기본 비율
              child: ElevatedButton(
                onPressed: () {},
                child: Text('버튼 3'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 예시 3: 두 열 레이아웃에서 가변 비율로 이미지와 텍스트 배치
class ImageTextLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('이미지와 텍스트 비율 조정')),
      body: Row(
        children: [
          Expanded(
            flex: 3,  // 이미지가 전체의 3/5 차지
            child: Container(
              color: Colors.blueAccent,
              child: Center(child: Text('이미지 영역', style: TextStyle(color: Colors.white, fontSize: 18))),
            ),
          ),
          Expanded(
            flex: 2,  // 텍스트가 전체의 2/5 차지
            child: Container(
              color: Colors.lightBlue,
              child: Center(child: Text('텍스트 영역', style: TextStyle(color: Colors.white, fontSize: 18))),
            ),
          ),
        ],
      ),
    );
  }
}

/// OrientationBuilder로 화면 방향에 따른 레이아웃 변경
// 연습문제
class OrientationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orientation Builder')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // 세로 방향 레이아웃
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('세로 모드', style: TextStyle(fontSize: 24)),
                ElevatedButton(onPressed: () {}, child: Text('버튼')),
              ],
            );
          } else {
            // 가로 방향 레이아웃
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('가로 모드', style: TextStyle(fontSize: 24)),
                SizedBox(width: 20),
                ElevatedButton(onPressed: () {}, child: Text('버튼')),
              ],
            );
          }
        },
      ),
    );
  }
}

// 예제 1: 화면 방향에 따라 리스트와 그리드 전환
class ListToGridExample extends StatelessWidget {
  final List<String> items = List.generate(8, (index) => '항목 ${index + 1}');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('리스트와 그리드 전환')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // 세로 방향에서는 리스트로 표시
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                );
              },
            );
          } else {
            // 가로 방향에서는 그리드로 표시
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blue,
                  child: Center(
                    child: Text(items[index], style: TextStyle(color: Colors.white)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// 예제 2: 방향에 따라 이미지와 텍스트 배치 변경
class ImageTextOrientation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('이미지와 텍스트 배치 변경')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // 세로 방향에서는 이미지가 위에, 텍스트가 아래에 배치
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://via.placeholder.com/150',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  '이것은 텍스트입니다',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            );
          } else {
            // 가로 방향에서는 이미지와 텍스트가 가로로 나란히 배치
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://via.placeholder.com/150',
                  width: 150,
                  height: 150,
                ),
                SizedBox(width: 20),
                Text(
                  '이것은 텍스트입니다',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// 예제 3: 세로와 가로에 따른 메뉴와 콘텐츠 레이아웃 변경
class MenuContentOrientation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메뉴와 콘텐츠 레이아웃 변경')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // 세로 방향에서는 메뉴와 콘텐츠가 위아래로 배치
            return Column(
              children: [
                Container(
                  color: Colors.blueAccent,
                  height: 150,
                  child: Center(child: Text('메뉴', style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
                Expanded(
                  child: Container(
                    color: Colors.lightBlue,
                    child: Center(child: Text('콘텐츠 영역', style: TextStyle(color: Colors.white, fontSize: 20))),
                  ),
                ),
              ],
            );
          } else {
            // 가로 방향에서는 메뉴와 콘텐츠가 좌우로 배치
            return Row(
              children: [
                Container(
                  color: Colors.blueAccent,
                  width: 150,
                  child: Center(child: Text('메뉴', style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
                Expanded(
                  child: Container(
                    color: Colors.lightBlue,
                    child: Center(child: Text('콘텐츠 영역', style: TextStyle(color: Colors.white, fontSize: 20))),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

/// 커스텀 위젯 디자인
// 실습 문제 1: 기본 커스텀 버튼 만들기
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  CustomButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

// 실습 문제 2: 커스텀 카드 위젯 만들기
class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  CustomCard({required this.title, required this.description, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black26, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

// 실습 문제 3: 아이콘이 포함된 커스텀 입력 필드 만들기
class CustomInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String? errorText;

  CustomInputField({required this.hintText, required this.icon, this.errorText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          hintText: hintText,
          errorText: errorText,  // 에러 메시지 표시
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
      ),
    );
  }
}

// 실습 문제 4: 선택 탭이 강조되는 커스텀 네비게이션 바 만들기
class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}

// 커스텀 팝업창 (Dialog) 위젯 만들기
class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              content,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: Text(
                    cancelText,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onConfirm,
                  child: Text(confirmText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// dialog 사용예시
class TestCustomDialogPage extends StatelessWidget {
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: '확인',
          content: '이 작업을 수행하시겠습니까?',
          confirmText: '확인',
          cancelText: '취소',
          onConfirm: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('확인되었습니다.')));
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('커스텀 팝업 예제')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showCustomDialog(context),
          child: Text('팝업 열기'),
        ),
      ),
    );
  }
}

// SharedPreferences를 사용한 간단한 데이터 캐싱
class NameStorageApp extends StatefulWidget {
  @override
  _NameStorageAppState createState() => _NameStorageAppState();
}

class _NameStorageAppState extends State<NameStorageApp> {
  TextEditingController _controller = TextEditingController();
  String _savedName = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  // 이름 불러오기
  _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString('username') ?? '';
    });
  }

  // 이름 저장하기
  _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _controller.text);
    setState(() {
      _savedName = _controller.text;
    });
  }

  // 이름 삭제하기
  _removeName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    setState(() {
      _savedName = '';
    });
  }


  NameProvider _nameProvider = NameProvider();

  @override
  Widget build(BuildContext context) {
    _nameProvider = Provider.of<NameProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: Text('SharedPreferences 예제')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (_) {
                _nameProvider.updateName(_);
              },
              decoration: InputDecoration(labelText: '이름 입력'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveName,
              child: Text('이름 저장'),
            ),
            SizedBox(height: 16),
            Text('저장된 이름: ${_nameProvider.name}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _removeName,
              child: Text('이름 삭제'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class NameStless extends StatelessWidget {
  NameStless({Key? key}) : super(key: key);
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('SharedPreferences 예제')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (text) {
                Provider.of<NameProvider>(context, listen: false).updateName(text);
              },
              decoration: InputDecoration(labelText: '이름 입력'),
            ),
            SizedBox(height: 16),
            Consumer<NameProvider>(builder: (context, name, child) => Text('저장된 이름: ${name.name}')),
          ],
        ),
      ),
    );
  }
}


// SQLite를 사용한 구조화된 데이터 캐싱
class SQLiteExample extends StatefulWidget {
  @override
  _SQLiteExampleState createState() => _SQLiteExampleState();
}

class _SQLiteExampleState extends State<SQLiteExample> {
  Database? _database;
  List<String> _favorites = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'favorites.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE favorites(id INTEGER PRIMARY KEY, name TEXT)");
      },
      version: 1,
    );
    _loadFavorites();
  }

  _loadFavorites() async {
    final List<Map<String, dynamic>> maps = await _database!.query('favorites');
    setState(() {
      _favorites = List.generate(maps.length, (i) => maps[i]['name']);
    });
  }

  _addFavorite(String name) async {
    await _database!.insert('favorites', {'name': name});
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SQLite 예제')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: '즐겨찾기 항목 입력'),
            ),
            ElevatedButton(
              onPressed: () {
                _addFavorite(_controller.text);
                _controller.clear();
              },
              child: Text('항목 추가'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _favorites.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_favorites[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// File Storage
class FileStorageService {
  Future<String> _getFilePath(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$filename.json';
  }

  Future<File> _getFile(String filename) async {
    final path = await _getFilePath(filename);
    return File(path);
  }

  Future<void> saveData(String filename, Map<String, dynamic> data) async {
    final file = await _getFile(filename);
    await file.writeAsString(jsonEncode(data));
  }

  Future<Map<String, dynamic>?> readData(String filename) async {
    try {
      final file = await _getFile(filename);
      if (await file.exists()) {
        final contents = await file.readAsString();
        return jsonDecode(contents);
      }
    } catch (e) {
      print("Error reading file: $e");
    }
    return null;
  }
}

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readData(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }
}

// setState로 카운터 기능 구현하기
class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('setState 카운터')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter', style: TextStyle(fontSize: 36)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('증가'),
            ),
          ],
        ),
      ),
    );
  }
}

//  Consumer를 통한 효율적인 상태 관리
class ConsumerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consumer로 선택적 상태 업데이트')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(
              builder: (context, counter, child) => Text(
                '${counter.count}',
                style: TextStyle(fontSize: 36),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Provider.of<CounterProvider>(context, listen: false).increment();
              },
              child: Text('증가'),
            ),
          ],
        ),
      ),
    );
  }
}

// Selector의 사용 예시
class SelectorExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selector 예제')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Selector<CounterProvider, int>(
              selector: (context, counter) => counter.count,
              shouldRebuild: (previous, next) => next % 5 == 0,
              builder: (context, count, child) => Text(
                '5의 배수일 때만 업데이트: $count',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Provider.of<CounterProvider>(context, listen: false).increment(),
              child: Text('카운트 증가'),
            ),
          ],
        ),
      ),
    );
  }
}

// 예제 코드: builder의 child 사용
class ChildExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("builder의 child 사용 예시")),
      body: Center(
        child: MyCounterWidget(),
      ),
    );
  }
}

class MyCounterWidget extends StatefulWidget {
  @override
  _MyCounterWidgetState createState() => _MyCounterWidgetState();
}

class _MyCounterWidgetState extends State<MyCounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "카운트: $_counter",
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 이 버튼은 상태가 변경되더라도 항상 동일한 child로 유지됩니다.
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text("카운트 증가"),
              ),
              SizedBox(height: 10),
              // 고정된 Text 위젯을 child로 지정하여 불필요한 빌드를 방지합니다.
              Builder(
                builder: (context) => Text(
                  "고정된 텍스트입니다",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}