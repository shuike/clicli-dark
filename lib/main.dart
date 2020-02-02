import 'dart:io';

import 'package:clicli_dark/pages/home_stack/home_page.dart';
import 'package:clicli_dark/pages/home_stack/time_line_page.dart';
import 'package:clicli_dark/pages/home_stack/ugc_page.dart';
import 'package:clicli_dark/utils/dio_utils.dart';
import 'package:clicli_dark/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final List<String> pagesIcon = [
    'assets/home.svg',
    'assets/time.svg',
    'assets/other.svg',
    // 'assets/user.svg'
  ];

  int _currentPageIndex = 0;
  final _pageController = PageController();

  void _onPageChange(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 1), curve: Curves.ease);
    });
  }

  int lastBack = 0;

  Future<bool> doubleBackExit() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastBack > 1000) {
      showShortToast("再按一次退出应用");
      lastBack = DateTime.now().millisecondsSinceEpoch;
    } else {
      cancelToast();
      //  SystemNavigator.pop();
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    NetUtils.initConfig();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: doubleBackExit,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [HomePage(), TimeLinePage(), UGCPage()],
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: _onPageChange,
          type: BottomNavigationBarType.fixed,
          items: [
            for (int i = 0; i < pagesIcon.length; i++)
              BottomNavigationBarItem(
                title: SizedBox.shrink(),
                icon: SvgPicture.asset(
                  pagesIcon[i],
                  color: _currentPageIndex == i
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  height: 28,
                ),
              )
          ],
        ),
      ),
    );
  }
}

/*

import 'package:flutter/cupertino.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPageState createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

*/
