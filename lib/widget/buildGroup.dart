import 'package:flutter/material.dart';
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
  final TextEditingController countryController = TextEditingController();
  final TextEditingController agencyController = TextEditingController();

  void createGroup() {
    // Implement your group creation logic here
  }

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
                              controller: countryController,
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
                              controller: agencyController,
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
