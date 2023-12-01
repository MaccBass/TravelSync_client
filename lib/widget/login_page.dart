import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // DIO 패키지로 HTTP 통신
import 'dart:convert'; // JSON Encode, Decode를 위한 패키지
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // flutter_secure_storage 패키지

import 'package:travelsync_client/models/model.dart';
import 'package:travelsync_client/widget/join.dart';
import 'package:travelsync_client/widget/logout.dart';
import 'package:travelsync_client/widget/login_widget_group.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // 앱이 시작될 때 보여질 화면
      routes: {
        '/service': (context) => const ServicePage(),
        '/main': (context) => const ServicePage(),
        '/join': (context) => const JoinPage(),
      },
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username = TextEditingController(); // id 입력 저장
  var password = TextEditingController(); // pw 입력 저장

  static const storage =
      FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key: 'login');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      Navigator.pushNamed(context, '/main');
    } else {
      print('로그인이 필요합니다');
    }
  }

  // 로그인 버튼 누르면 실행
  loginAction(accountName, password) async {
    try {
      var dio = Dio();
      var param = {'userId': '$accountName', 'password': '$password'};

      Response response = await dio.post('로그인 API URL', data: param);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.data['userId'].toString());
        // 직렬화를 이용하여 데이터를 입출력하기 위해 model.dart에 Login 정의 참고
        var val = jsonEncode(Login('$accountName', '$password', '$jsonBody'));

        await storage.write(
          key: 'login',
          value: val,
        );
        print('접속 성공!');
        return true;
      } else {
        print('error');
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> mockLoginAction(String accountName, String password) async {
    try {
      // 더미 응답 데이터 생성
      Map<String, dynamic> dummyResponse = generateDummyLoginResponse('123456');

      if (dummyResponse['status'] == 200) {
        final jsonBody = dummyResponse['accessToken'].toString();
        var val = jsonEncode(Login(accountName, password, jsonBody));

        await storage.write(
          key: 'login',
          value: val,
        );
        print('가상 로그인 성공!');
        return true;
      } else {
        print('가상 로그인 실패');
        return false;
      }
    } catch (e) {
      print('가상 로그인 에러: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5FBFF),
      body: Column(
        children: [
          Container(
            height: 120,
          ),
          const Logo(),
          Container(
            height: 50,
          ),
          Row(
            children: [
              Container(
                width: 40,
              ),
              const Text(
                '이메일',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 30,
              ),
              // 아이디 입력 영역
              SizedBox(
                width: 230,
                height: 30,
                child: TextField(
                  controller: username,
                  decoration: const InputDecoration(
                    hintText: 'example@example.com',
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 35,
              ),
              const Text(
                '비밀번호',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 20,
              ),
              // 비밀번호 입력 영역
              SizedBox(
                width: 230,
                height: 30,
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'password',
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 10,
          ),
          // 로그인 버튼
          GestureDetector(
            child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: InkWell(
                  onTap: () async {
                    if (await mockLoginAction(username.text, password.text) ==
                        true) {
                      print('로그인 성공');
                      Navigator.pushNamed(
                          context, '/service'); // 로그인 이후 서비스 화면으로 이동
                    } else {
                      print('로그인 실패');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      '로그인하기',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 250,
          ),
          const HalfLine(),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '아직 회원이 아니세요?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
              Container(
                width: 40,
              ),
              GestureDetector(
                child: Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/join'); // 회원가입페이지로 이동
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          '회원가입 하기',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//더미 데이터 생성하는 로직들
// 가상의 더미 로그인 응답을 생성하는 함수
Map<String, dynamic> generateDummyLoginResponse(String userId) {
  return {
    'status': 200,
    'accessToken': 'xxxxxx.yyyyyyy.kkkkkkk',
    'refreshToken': 'xxxxxx.yyyyyy.kkkkkkk',
    // 다른 필요한 응답 데이터도 추가할 수 있습니다.
  };
}
