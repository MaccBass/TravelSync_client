import 'package:flutter/material.dart';
import '../tour/emptyTour.dart';
import '../tour/createTour.dart';
import '../plan/createPlan.dart';

class TourHome extends StatefulWidget {
  const TourHome({super.key});

  @override
  _TourHomeState createState() => _TourHomeState();
}

class _TourHomeState extends State<TourHome> {
  List<String> tourList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tourList.isNotEmpty
          ? _buildTourList()
          : const NoTourMessage(), // tourList가 비어있으면 '투어가 없습니다' 메시지 표시
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 사용자 입력을 가져옵니다

          // tourList에 새로운 일정을 추가합니다
          setState(() {
            tourList.add(myPlan);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTourList() {
    return ListView.builder(
      itemCount: tourList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tourList[index]),
        );
      },
    );
  }
}
