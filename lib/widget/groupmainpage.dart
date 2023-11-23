import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelsync_client/widgets/header.dart';

class GroupMainPage extends StatefulWidget {
  const GroupMainPage({super.key});

  @override
  State<GroupMainPage> createState() => _GroupMainPageState();
}

class _GroupMainPageState extends State<GroupMainPage> {
  late bool isGuide = true;
  DateTime startDate = DateTime.now();
  late String startFormat = DateFormat('yyyy-MM-dd').format(startDate);
  DateTime endDate = DateTime(2099, 12, 31);
  late String endFormat = DateFormat('yyyy-MM-dd').format(endDate);
  late GroupInfo groupinfo;

  void addNotice() {}
  void importPlan() {}
  void viewTravlerLocation() {}
  void checkTraveler() {}
  void viewGuideLocation() {}

  void waitForGroupInfo() async {
    groupinfo = GroupInfo(
        groupName: "현성이와 아이들",
        startDate: startDate,
        endDate: endDate,
        guideName: "조현성",
        guidePhone: "010-1234-5678",
        agencyName: "DGU투어");
  }

  @override
  void initState() {
    super.initState();
    waitForGroupInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                groupinfo.agencyName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                groupinfo.groupName,
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
                    "가이드 ${groupinfo.guideName} ${groupinfo.guidePhone}",
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
      ),
    );
  }
}

class GroupInfo {
  final String groupName;
  final DateTime startDate;
  final DateTime endDate;
  final String guideName;
  final String guidePhone;
  final String agencyName;

  GroupInfo({
    required this.groupName,
    required this.startDate,
    required this.endDate,
    required this.guideName,
    required this.guidePhone,
    required this.agencyName,
  });
}
