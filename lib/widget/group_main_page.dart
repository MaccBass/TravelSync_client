import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelsync_client/widgets/header.dart';
import 'package:http/http.dart' as http;

class GroupMainPage extends StatefulWidget {
  final int groupId;
  const GroupMainPage({super.key, required this.groupId});

  @override
  State<GroupMainPage> createState() => _GroupMainPageState();
}

class _GroupMainPageState extends State<GroupMainPage> {
  late bool isGuide = true;
  DateTime startDate = DateTime.now();
  late String startFormat = DateFormat('yyyy-MM-dd').format(startDate);
  DateTime endDate = DateTime(2099, 12, 31);
  late String endFormat = DateFormat('yyyy-MM-dd').format(endDate);
  late GroupDetail groupdetail;
  late GuideInfo guideInfo;

  void addNotice() {}
  void importPlan() {}
  void viewTravlerLocation() {}
  void checkTraveler() {}
  void viewGuideLocation() {}

  waitForGroupInfo() async {
    try {
      Map<String, String> header = {
        "accept": "*/*",
        "Authorization":
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJleHAiOjE3MDY2MDQ5NzcsInN1YiI6InJhY2tAcmV1bmcucmluIiwidHlwZSI6IkFDQ0VTUyJ9.-Q7JmTOYySnLug9goV3bBFt2OOpyrwkf3FBVF8eSGnag75yZBy-g6pL8-KQwwn-kUJhv43wg2iTRUifFixi2sQ"
      };
      final response = await http.get(
          Uri.parse("http://34.83.150.5:8080/group/detail/${widget.groupId}"),
          headers: header);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        groupdetail = GroupDetail.fromJson(responseBody);
        var i = 1;
        await waitForGuideInfo();
      } else {
        if (!mounted) return;
        Future.microtask(() => showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  content: const Text("그룹 생성 중 오류가 발생했습니다."),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("닫기"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ));
      }
    } catch (e) {
      if (!mounted) return;
      Future.microtask(() => showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                content: const Text("그룹페이지 api(그룹정보)오류"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("닫기"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          ));
    }
  }

  waitForGuideInfo() async {
    try {
      Map<String, String> header = {
        "accept": "*/*",
        "Authorization":
            "Bearer eyJhbGciOiJIUzUxMiJ9.eyJleHAiOjE3MDY2MDQ5NzcsInN1YiI6InJhY2tAcmV1bmcucmluIiwidHlwZSI6IkFDQ0VTUyJ9.-Q7JmTOYySnLug9goV3bBFt2OOpyrwkf3FBVF8eSGnag75yZBy-g6pL8-KQwwn-kUJhv43wg2iTRUifFixi2sQ"
      };
      final response = await http.get(
          Uri.parse('http://34.83.150.5:8080/user/info/${groupdetail.guide}'),
          headers: header);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        guideInfo = GuideInfo.fromJson(responseBody);
      } else {
        if (!mounted) return;
        Future.microtask(() => showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  content: const Text("그룹 생성 중 오류가 발생했습니다."),
                  actions: <Widget>[
                    TextButton(
                      child: const Text("닫기"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            ));
      }
    } catch (e) {
      if (!mounted) return;
      Future.microtask(() => showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                content: const Text("그룹페이지 api(가이드) 오류"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("닫기"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          ));
    }
  }

  Future<void> wait() async {
    await waitForGroupInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
            future: wait(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Future Error!\n${snapshot.error}"),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Header(
                        // 나중에 지우기
                        textHeader: "Group Main",
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        groupdetail.tourCompany,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        groupdetail.groupName,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_today, size: 12),
                          Text(
                            "$startFormat ~ ",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            endFormat,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.person, size: 12),
                          Text(
                            "가이드 ${groupdetail.guide} ${guideInfo.phone}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            "함께하는 여행객 - 임성혁님 외 22명",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "NOTICE",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigo,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: addNotice,
                                icon: const Icon(Icons.note_add),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                // notice API 받아올시 Container 안에 넣어서 리스트 띄우기
                                const SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "작성된 공지가 없습니다.\n수정 버튼을 눌러 생성하세요!",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 200,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                "TOUR",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigo,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: importPlan,
                                icon: const Icon(Icons.note_add),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                // notice API 받아올시 Container 안에 넣어서 리스트 띄우기
                                const SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "작성된 투어가 없습니다.\n수정 버튼을 눌러 생성하세요!",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 200,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isGuide)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: viewTravlerLocation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xfff5fbff),
                              ),
                              child: const Text(
                                "전체 위치 조회",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: checkTraveler,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xfff5fbff),
                              ),
                              child: const Text(
                                "인원 점검",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: viewGuideLocation,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xfff5fbff),
                              ),
                              child: const Text(
                                "가이드 위치 조회",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class GroupDetail {
  final int groupId;
  final String guide;
  final String groupName;
  final DateTime startDate;
  final DateTime endDate;
  final String nation;
  final String tourCompany;
  bool toggleLoc;
  final int? tourId;

  GroupDetail.fromJson(Map<String, dynamic> json)
      : groupId = json['groupId'],
        guide = json['guide'],
        groupName = json['groupName'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        nation = json['nation'],
        tourCompany = json['tourCompany'],
        toggleLoc = json['toggleLoc'],
        tourId = json['tourId'];
}

class GuideInfo {
  final String userId;
  final String name;
  final String phone;

  GuideInfo.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['name'],
        phone = json['phone'];
}