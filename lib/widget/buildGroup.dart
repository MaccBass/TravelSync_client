import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travelsync_client/models/group.dart';
import 'package:travelsync_client/service/group_api.dart';
import 'package:travelsync_client/widget/groupmainpage.dart';
import 'package:travelsync_client/widgets/header.dart';

class BuildGroup extends StatefulWidget {
  const BuildGroup({super.key});

  @override
  State<BuildGroup> createState() => BuildGroupState();
}

class BuildGroupState extends State<BuildGroup> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController nationController = TextEditingController();
  final TextEditingController tourCompanyController = TextEditingController();
  final TextEditingController groupPasswordController = TextEditingController();

  static const storage = FlutterSecureStorage();
  dynamic userInfo = '';
  late String userToken;

  @override
  void initState() {
    super.initState();

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
      var info = jsonDecode(userInfo);
    } else {
      print('로그인이 필요합니다');
    }
  }

  // 그룹 생성 버튼 누를시
  void createGroup() async {
    if (groupNameController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "그룹명을 입력하세요.",
      );
      return;
    }
    if (nationController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "여행 국가를 입력하세요.",
      );
      return;
    }
    if (tourCompanyController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "여행사를 입력하세요.",
      );
      return;
    }
    if (groupPasswordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "그룹 비밀번호를 입력하세요.",
      );
      return;
    }
    if (selectedStartDate.isAfter(selectedEndDate)) {
      Fluttertoast.showToast(msg: "여행 시작일은 여행 종료일보다 나중이어야 합니다.");
    }
    try {
      var dio = Dio();
      var param = {
        'guide': "랙릉린",
        'groupName': groupNameController.text,
        'tourCompany': tourCompanyController.text,
        'startDate': selectedStartDate.toIso8601String(),
        'endDate': selectedEndDate.toIso8601String(),
        'nation': nationController.text,
        'groupPassword': groupPasswordController.text
      };
      Map<String, String> header = {
        "Content-type": "application/json",
        "Authorization": userToken,
      };
      var response = await dio.post('http://34.83.150.5:8080/group/create',
          data: param, options: Options(headers: header));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "그룹 생성 성공");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text("새로운 그룹을 생성했습니다."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("확인"),
                  ),
                ],
              );
            });
        goGroupMainPage();
      } else {
        Fluttertoast.showToast(msg: "오류 발생");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text("그룹 생성 중 오류가 발생했습니다."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("확인"),
                  ),
                ],
              );
            });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "e");
      return;
    }
  }

  void goGroupMainPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GroupMainPage(),
        ));
  }

  // 시작/종료일 지정
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035, 12, 31),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035, 12, 31),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Header(
                  textHeader: "Build Group",
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            flex: 3,
                            child: Text(
                              "그룹 이름",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: TextField(
                              controller: groupNameController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Flexible(
                            flex: 3,
                            child: Text(
                              "여행 기간",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 5,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${selectedStartDate.toLocal()}"
                                            .split(' ')[0],
                                        textAlign: TextAlign.center,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.calendar_today),
                                        onPressed: () =>
                                            _selectStartDate(context),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${selectedEndDate.toLocal()}"
                                            .split(' ')[0],
                                        textAlign: TextAlign.center,
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.calendar_today),
                                        onPressed: () =>
                                            _selectEndDate(context),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            flex: 3,
                            child: Text(
                              "여행 국가",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: TextField(
                              controller: nationController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            flex: 3,
                            child: Text(
                              "여행사",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: TextField(
                              controller: tourCompanyController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "그룹 생성을 누르시면\n가이드 권한으로 그룹이 생성되어\n함께할 여행객을 초대할 수 있습니다.",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            flex: 3,
                            child: Text(
                              "비밀번호",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: TextField(
                              controller: groupPasswordController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: createGroup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff5fbff),
                        ),
                        child: const Text(
                          "그룹 생성",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
