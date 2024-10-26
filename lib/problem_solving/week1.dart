import 'package:devjang_class/week2/widgets.dart';
import 'package:flutter/material.dart';

class BasicProblem {

  // 문제 1: 텍스트와 버튼 배치하기
  // Text 위젯과 ElevatedButton을 사용하여 화면 중앙에 "Hello, Flutter!"라는 텍스트와 그 아래에 "클릭하세요"라는 버튼을 배치하세요. 버튼을 클릭하면 콘솔에 "버튼이 눌렸습니다!"라는 메시지가 출력되도록 구현하세요.
  Widget textBtn() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello, Flutter!'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              print('버튼이 눌렸습니다!');
            },
            child: Text('클릭하세요'),
          ),
        ],
      ),
    );
  }

  // 문제 2 : Row와 Column 사용하기
  // 화면에 3개의 텍스트 "One", "Two", "Three"를 Row와 Column을 사용하여 각각 가로 및 세로로 배치하세요. 각 텍스트는 서로 일정한 간격을 두고 배치되도록 SizedBox를 사용하세요.
  Widget rowColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('One'),
            SizedBox(width: 16),
            Text('Two'),
            SizedBox(width: 16),
            Text('Three'),
          ],
        ),
        SizedBox(height: 32),
        Column(
          children: [
            Text('One'),
            SizedBox(height: 16),
            Text('Two'),
            SizedBox(height: 16),
            Text('Three'),
          ],
        ),
      ],
    );
  }

  // 문제 3 : 이미지 추가하기
  // Image 위젯을 사용하여 네트워크에서 이미지를 불러와 화면에 표시하세요. 이미지는 임의로 선택할 수 있습니다.
  // 이미지 캐시처리 패키지 : cached_network_image
  // 이미지 미리 로드함수 : precacheImage, precacheImage(NetworkImage("https://example.com/sample_image.jpg"), context);

  Widget imageWidget() {
    return Center(
      child: Image.network('https://flexible.img.hani.co.kr/flexible/normal/960/960/imgdb/resize/2019/0121/00501111_20190121.JPG'), // 원하는 이미지 URL
    );
  }
}

// 회원 가입 화면 구현
// Flutter의 다양한 위젯들을 사용하여, 사용자가 회원 가입을 할 수 있는 화면을 구현하세요. 해당 화면에는 다음과 같은 기능이 포함되어야 합니다.
//
// 이름, 이메일, 비밀번호를 입력받는 TextFormField를 사용.
// Row와 Column을 사용하여 레이아웃을 구성.
// 입력 필드 사이에 적절한 여백을 추가.
// 화면 하단에는 "회원 가입" 버튼을 추가하며, GestureDetector를 사용해 버튼 클릭을 감지.
// 버튼을 클릭하면 사용자가 입력한 데이터를 출력.
// ListView.builder를 사용하여 동적으로 여러 개의 텍스트 필드를 추가하여 여러 개의 취미를 입력받는 부분을 구현.
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  List<String> hobbies = ['']; // 취미 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: '이름'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이름을 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: '이메일'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이메일을 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: '비밀번호'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return '비밀번호를 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                '취미 (최대 5개)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true, // ListView가 스크롤을 가지지 않도록
                physics: NeverScrollableScrollPhysics(),
                itemCount: hobbies.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '취미 ${index + 1}',
                      ),
                      onChanged: (value) {
                        setState(() {
                          hobbies[index] = value;
                        });
                      },
                    ),
                  );
                },
              ),
              if (hobbies.length < 5) // 최대 5개의 취미만 입력 가능
                GestureDetector(
                  onTap: () {
                    setState(() {
                      hobbies.add(''); // 취미 추가
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '취미 추가 +',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              SizedBox(height: 32.0),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // 폼이 유효한 경우
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('이름: $name\n이메일: $email\n비밀번호: $password\n취미: ${hobbies.join(', ')}'),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      '회원 가입',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 문제: 간단한 프로필 화면 구현하기
// Flutter의 다양한 기본 위젯들을 사용하여 간단한 프로필 화면을 구현하세요. 이 화면에는 다음과 같은 기능이 포함되어야 합니다.
//
// 사용자의 이름, 이메일, 그리고 "프로필 업데이트" 버튼이 있어야 합니다.
// 사용자의 프로필 이미지를 Image.network로 불러와 표시하세요.
// 사용자는 TextFormField를 사용해 이름과 이메일을 입력할 수 있습니다.
// Row와 Column을 사용하여 이름과 이메일 필드를 정렬하세요.
// "프로필 업데이트" 버튼을 클릭하면 입력된 데이터를 콘솔에 출력하세요.
// 텍스트 필드 사이에 적절한 간격을 두기 위해 SizedBox를 사용하세요.
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              Widgets().showAlertDialog(context);
            },
            child: Text('프로필 화면')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 프로필 이미지
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://flexible.img.hani.co.kr/flexible/normal/960/960/imgdb/resize/2019/0121/00501111_20190121.JPG',
                ),
              ),
              SizedBox(height: 16.0),

              // 이름 입력 필드
              TextFormField(
                decoration: InputDecoration(labelText: '이름'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return '이름을 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // 이메일 입력 필드
              TextFormField(
                decoration: InputDecoration(labelText: '이메일'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return '유효한 이메일을 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),

              // 프로필 업데이트 버튼
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('이름: $name, 이메일: $email');
                  }
                },
                child: Text('프로필 업데이트'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 메모리 효율성을 높이기 위한 방법
// 1. 캐시 처리 (Caching)
// Flutter에서는 cached_network_image 패키지를 사용하여 이미지를 캐싱할 수 있습니다. 이를 통해 네트워크 이미지가 처음 로드된 후, 로컬 캐시에 저장되어 이후 다시 불러올 때 네트워크 요청을 줄일 수 있습니다.
// # pubspec.yaml에 패키지 추가
// dependencies:
//   cached_network_image: ^3.2.1
// 캐시를 사용하는 코드 예제:
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// class CachedImageExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: "https://example.com/sample_image.jpg",
//       placeholder: (context, url) => CircularProgressIndicator(), // 로딩 표시
//       errorWidget: (context, url, error) => Icon(Icons.error),  // 오류 이미지
//     );
//   }
// }
// 장점:
// 속도: 이미지를 다시 요청하지 않고 로컬 캐시에서 불러오기 때문에, 로드 속도가 빨라집니다.
// 네트워크 사용 감소: 네트워크 요청을 줄여 앱의 네트워크 사용량을 줄이고 데이터 소모를 절약할 수 있습니다.
// 단점:
// 캐시 용량: 로컬 캐시에 저장된 이미지가 많아질수록 앱이 사용하는 디스크 용량이 늘어날 수 있습니다.
// 캐시 관리: cached_network_image 패키지는 기본적으로 캐시 관리 기능을 제공하지만, 특정 조건에서 직접 캐시를 지워야 할 수 있습니다.
//
// 미리 로드 (Pre-caching)
// Flutter에서는 precacheImage() 함수를 사용하여 필요한 이미지를 미리 로드할 수 있습니다. 이 방법은 메모리 절약보다는 성능 개선에 더 가깝지만, 사용자가 이미지를 즉시 볼 수 있어 UI 반응성을 높입니다.
// void preloadImage(BuildContext context) {
//   precacheImage(NetworkImage("https://example.com/sample_image.jpg"), context);
// }
}