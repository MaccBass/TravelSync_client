import 'package:flutter/material.dart';
import 'dart:convert'; // JSON Encode, Decode를 위한 패키지
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travelsync_client/widget/settings_page.dart'; // flutter_secure_storage 패키지

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const storage = FlutterSecureStorage();
  dynamic userInfo = '';

  logout() async {
    await storage.delete(key: 'login');
    Navigator.pushNamed(context, '/');
  }

  checkUserState() async {
    userInfo = await storage.read(key: 'login');
    if (userInfo == null) {
      print('로그인 페이지로 이동');
      Navigator.pushNamed(context, '/'); // 로그인 페이지로 이동
    } else {
      print('로그인 중');
    }
  }

  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main/settings');
              },
              icon: const Icon(Icons.settings_outlined),
              tooltip: 'settings',
              color: Colors.black,
            )
          ],
        ),
        backgroundColor: const Color(0xFFF5FBFF),
        body: Column(
          children: [
            Container(
              width: 150,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/airplane_travelsync.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
