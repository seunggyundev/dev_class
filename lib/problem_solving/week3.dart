import 'package:flutter/material.dart';

/// [심화문제 - 애니메이션관련]
// 문제 1: 크기와 위치 애니메이션을 함께 적용
// 텍스트가 0.5초 동안 크기가 커지고, 동시에 왼쪽에서 오른쪽으로 이동하는 애니메이션을 구현하세요.
// 애니메이션은 시작할 때 scale이 작아지고 오른쪽으로 이동하며, 화면 중간에서 멈추도록 설정하세요.
class ScaleAndSlideAnimation extends StatefulWidget {
  @override
  _ScaleAndSlideAnimationState createState() => _ScaleAndSlideAnimationState();
}

class _ScaleAndSlideAnimationState extends State<ScaleAndSlideAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller!);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('크기와 위치 애니메이션')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation!,
              child: SlideTransition(
                position: _slideAnimation!,
                child: Text('크기와 위치가 함께 변하는 텍스트'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _controller!.forward();
              },
              child: Text('애니메이션 시작'),
            ),
          ],
        ),
      ),
    );
  }
}

// 문제 2: Fade와 Slide 애니메이션을 조합
// 텍스트가 서서히 나타나는(fade-in) 애니메이션과 오른쪽에서 왼쪽으로 이동하는 애니메이션을 동시에 구현하세요.
// 버튼을 눌렀을 때 애니메이션이 시작되며, 2초에 걸쳐 텍스트가 화면에 완전히 표시되도록 설정하세요.
class FadeSlideAnimation extends StatefulWidget {
  @override
  _FadeSlideAnimationState createState() => _FadeSlideAnimationState();
}

class _FadeSlideAnimationState extends State<FadeSlideAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
    _slideAnimation = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fade + Slide 애니메이션')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation!,
              child: SlideTransition(
                position: _slideAnimation!,
                child: Text('서서히 나타나는 텍스트'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _controller!.forward();
              },
              child: Text('애니메이션 시작'),
            ),
          ],
        ),
      ),
    );
  }
}

// 문제 3: 애니메이션을 순차적으로 실행
// 세 개의 텍스트 요소가 위에서 아래로 순차적으로 등장하는 애니메이션을 구현하세요.
// 첫 번째 텍스트가 등장하고 나서 1초 후에 두 번째 텍스트가 등장하고, 마지막으로 세 번째 텍스트가 등장합니다.
class SequentialAnimation extends StatefulWidget {
  @override
  _SequentialAnimationState createState() => _SequentialAnimationState();
}

class _SequentialAnimationState extends State<SequentialAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _firstAnimation;
  Animation<Offset>? _secondAnimation;
  Animation<Offset>? _thirdAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);

    _firstAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: _controller!, curve: Interval(0.0, 0.33, curve: Curves.easeIn)));
    _secondAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: _controller!, curve: Interval(0.33, 0.66, curve: Curves.easeIn)));
    _thirdAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: _controller!, curve: Interval(0.66, 1.0, curve: Curves.easeIn)));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('순차 애니메이션')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(position: _firstAnimation!, child: Text('첫 번째 텍스트')),
            SlideTransition(position: _secondAnimation!, child: Text('두 번째 텍스트')),
            SlideTransition(position: _thirdAnimation!, child: Text('세 번째 텍스트')),
            ElevatedButton(
              onPressed: () {
                _controller!.forward();
              },
              child: Text('애니메이션 시작'),
            ),
          ],
        ),
      ),
    );
  }
}

//  문제 4: 무한 반복 애니메이션
// 애니메이션이 자동으로 좌우로 반복 이동하도록 설정하세요.
// 텍스트가 왼쪽에서 오른쪽으로 이동하고 다시 원래 위치로 돌아오는 동작을 1초 간격으로 무한 반복하도록 구현하세요.
class InfiniteAnimation extends StatefulWidget {
  @override
  _InfiniteAnimationState createState() => _InfiniteAnimationState();
}

class _InfiniteAnimationState extends State<InfiniteAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    // controller.repeat() 메서드를 호출하면 애니메이션이 무한히 반복됩니다. reverse: true를 설정하면 애니메이션이 끝에서 다시 시작 위치로 돌아가는 형태로 반복
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat(reverse: true);

    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(1, 0)).animate(_controller!);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('무한 반복 애니메이션')),
      body: Center(
        child: SlideTransition(
          position: _slideAnimation!,
          child: Text('반복 이동하는 텍스트'),
        ),
      ),
    );
  }
}

//  문제 5: 회전 애니메이션
// 버튼을 눌렀을 때 텍스트가 90도씩 회전하는 애니메이션을 적용하세요.
// 애니메이션이 끝날 때 다시 버튼을 눌러 원래 상태로 돌아갈 수 있도록 설정합니다.
class RotateAnimationExample extends StatefulWidget {
  @override
  _RotateAnimationExampleState createState() => _RotateAnimationExampleState();
}

class _RotateAnimationExampleState extends State<RotateAnimationExample> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회전 애니메이션')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              // Tween을 통해 시작과 끝 각도를 설정할 수 있습니다. 예를 들어, Tween<double>(begin: 0, end: 1.0)을 사용하면 360도 회전 애니메이션이 생성됩니다.
              turns: Tween(begin: 0.0, end: 0.25).animate(_controller!),
              child: Text('회전하는 텍스트', style: TextStyle(fontSize: 24)),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller!.status == AnimationStatus.completed) {
                  // 회전 후 다시 원래 상태로 돌아오도록 하려면 reverse() 메서드를 활용해 애니메이션을 반대로 진행시킵니다.
                  _controller!.reverse();
                } else {
                  _controller!.forward();
                }
              },
              child: Text('회전 시작/정지'),
            ),
          ],
        ),
      ),
    );
  }
}

/// [챌린지 문제 1: 복합 애니메이션을 통한 순차적 화면 전환]
// 첫 번째 화면에서는 Fade-in 애니메이션으로 텍스트가 서서히 나타납니다.
// 두 번째 화면에서는 Scale 애니메이션으로 텍스트가 확대되며 등장합니다.
// 세 번째 화면에서는 Slide 애니메이션으로 텍스트가 왼쪽에서 오른쪽으로 이동합니다.
// 첫 번째 화면: FadeIn 애니메이션
class FadeInScreen extends StatefulWidget {
  @override
  _FadeInScreenState createState() => _FadeInScreenState();
}

class _FadeInScreenState extends State<FadeInScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('첫 번째 화면')),
      body: Center(
        child: FadeTransition(
          opacity: _animation!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('서서히 나타나는 텍스트', style: TextStyle(fontSize: 24)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScaleScreen()),
                  );
                },
                child: Text('다음 화면'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 두 번째 화면: Scale 애니메이션
class ScaleScreen extends StatefulWidget {
  @override
  _ScaleScreenState createState() => _ScaleScreenState();
}

class _ScaleScreenState extends State<ScaleScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('두 번째 화면')),
      body: Center(
        child: ScaleTransition(
          scale: _animation!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('확대되며 나타나는 텍스트', style: TextStyle(fontSize: 24)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SlideScreen()),
                  );
                },
                child: Text('다음 화면'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 세 번째 화면: Slide 애니메이션
class SlideScreen extends StatefulWidget {
  @override
  _SlideScreenState createState() => _SlideScreenState();
}

class _SlideScreenState extends State<SlideScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller!);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('세 번째 화면')),
      body: Center(
        child: SlideTransition(
          position: _animation!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('오른쪽으로 이동하며 등장하는 텍스트', style: TextStyle(fontSize: 24)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => FadeInScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
                child: Text('처음으로 돌아가기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [챌린지 문제 2: BottomNavigationBar로 복합 화면 관리]
// BottomNavigationBar와 AppBar를 사용해 하단 탭이 있는 네비게이션 구조를 만드세요.
// 각 탭에 다양한 애니메이션을 적용하여 화면 전환 효과를 추가하세요:
// 탭1: 오른쪽에서 왼쪽으로 텍스트가 이동하는 애니메이션
// 탭2: 텍스트가 상하로 이동하며 나타나는 애니메이션
// 탭3: 텍스트가 회전하며 화면 중앙에 등장하는 애니메이션
class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('탭: ${_selectedIndex + 1}'),
      ),
      body: Center(
        child: _buildAnimatedWidget(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '탭1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '탭2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: '탭3',
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedWidget() {
    switch (_selectedIndex) {
      case 0:
        return SlideTransitionExample();
      case 1:
        return VerticalSlideExample();
      case 2:
        return RotationTransitionExample();
      default:
        return Container();
    }
  }
}

class SlideTransitionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)),
      duration: Duration(seconds: 2),
      builder: (context, Offset offset, child) {
        return SlideTransition(
          position: AlwaysStoppedAnimation(offset),  // 애니메이션의 위치를 고정된 값으로 설정할 때 사용
          child: Text('오른쪽에서 왼쪽으로 이동', style: TextStyle(fontSize: 24)),
        );
      },
    );
  }
}

class VerticalSlideExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)),
      duration: Duration(seconds: 2),
      builder: (context, Offset offset, child) {
        return SlideTransition(
          position: AlwaysStoppedAnimation(offset),
          child: Text('위에서 아래로 이동', style: TextStyle(fontSize: 24)),
        );
      },
    );
  }
}

class RotationTransitionExample extends StatefulWidget {
  @override
  _RotationTransitionExampleState createState() => _RotationTransitionExampleState();
}

class _RotationTransitionExampleState extends State<RotationTransitionExample> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller!,
      child: Text('회전 애니메이션', style: TextStyle(fontSize: 24)),
    );
  }
}

/// [챌린지 문제 3: 페이지 넘기기 애니메이션]
// 네 개의 페이지를 좌우로 넘길 수 있도록 PageView를 사용하세요.
// 각 페이지에는 ScaleTransition 애니메이션을 적용하여, 사용자가 페이지를 넘길 때마다 텍스트가 커지며 등장하는 효과를 추가하세요.
class PageViewExample extends StatefulWidget {
  @override
  _PageViewExampleState createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('페이지 넘기기 애니메이션')),
      body: PageView(
        controller: _pageController,
        children: List.generate(4, (index) => AnimatedPage(pageNumber: index + 1)),
      ),
    );
  }
}

class AnimatedPage extends StatelessWidget {
  final int pageNumber;

  const AnimatedPage({Key? key, required this.pageNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.5, end: 1.0),
        duration: Duration(seconds: 1),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Text(
              '페이지 $pageNumber',
              style: TextStyle(fontSize: 32),
            ),
          );
        },
      ),
    );
  }
}

/// [챌린지 문제 4: Hero 애니메이션을 사용한 이미지 이동]
// Hero 애니메이션을 사용하여 이미지가 화면 간에 자연스럽게 이동하는 효과를 추가하세요.
// 첫 번째 화면에 작은 이미지가 있고, 이 이미지를 클릭하면 두 번째 화면으로 전환되며 이미지가 확대되어 표시됩니다.
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero 애니메이션 첫 번째 화면')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
          child: Hero(
            tag: 'hero-image',
            child: Image.network(
              'https://flexible.img.hani.co.kr/flexible/normal/960/960/imgdb/resize/2019/0121/00501111_20190121.JPG',
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero 애니메이션 두 번째 화면')),
      body: Center(
        child: Hero(
          tag: 'hero-image',
          child: Image.network(
            'https://flexible.img.hani.co.kr/flexible/normal/960/960/imgdb/resize/2019/0121/00501111_20190121.JPG',
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}

/// [챌린지 문제 5: pushAndRemoveUntil로 화면 초기화]
// 네 개의 화면을 구성하고, 마지막 화면에서 첫 번째 화면을 제외한 모든 화면을 초기화하세요.
// pushAndRemoveUntil 메서드를 사용해 마지막 화면에서 첫 번째 화면으로 돌아가도록 구현하고, 다시 돌아왔을 때 모든 이전 화면 상태가 사라지도록 설정하세요.
class PushAndRemoveUntilExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
        '/third': (context) => ThirdScreen(),
        '/fourth': (context) => FourthScreen(),
      },
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('세 번째 화면')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/fourth');
          },
          child: Text('네 번째 화면으로 이동'),
        ),
      ),
    );
  }
}

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('네 번째 화면')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => FirstScreen()),
                  (Route<dynamic> route) => false,
            );
          },
          child: Text('첫 번째 화면으로 돌아가며 모든 화면 초기화'),
        ),
      ),
    );
  }
}
