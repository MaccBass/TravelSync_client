/*Tour 전체 총괄 화면*/
import 'package:flutter/material.dart';
import 'package:travelsync_client/tour/tourHome.dart';
import '../logo/logoHeader.dart';
import '../widgets/button.dart';
import '../widgets/header.dart';
import '../tour/createTour.dart';

class Tour extends StatelessWidget {
  const Tour({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              LogoHeader(), //airplane_travelsync 메인 로고
              SizedBox(height: 40),
              Header(textHeader: 'TOUR List'), //title
              SizedBox(height: 70),
              TourHome(),
              SizedBox(height: 240),
              Buttons(
                text1: 'TOUR 만들기',
                text2: 'TOUR 삭제',
                moveTo1: CreateTour(),
                moveTo2: CreateTour(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
