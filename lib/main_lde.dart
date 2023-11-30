import 'package:flutter/material.dart';
import 'package:travelsync_client/tour/tourHome.dart';
import '../logo/logoHeader.dart';
import '../widgets/button.dart';
import '../widgets/header.dart';
import '../tour/createTour.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(),
            SizedBox(
              height: 60,
            ),
            LogoHeader(), //airplane_travelsync 메인 로고
            SizedBox(height: 40),
            Header(textHeader: 'TOUR List'), //title
            SizedBox(height: 70),
            TourHome(),
            SizedBox(height: 200),
            Buttons(
              text1: 'TOUR 만들기',
              text2: 'TOUR 삭제',
              moveTo1: CreateTour(),
              moveTo2: CreateTour(),
            ),
          ],
        ),
      ),
    );
  }
}
