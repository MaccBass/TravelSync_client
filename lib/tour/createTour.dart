import 'package:flutter/material.dart';
import '../logo/logoHeader.dart';
import '../widgets/header.dart';
import '../plan/createPlan.dart';
//////
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CreateTour extends StatefulWidget {
  const CreateTour({Key? key}) : super(key: key);
  @override
  _CreateTourState createState() => _CreateTourState();
}

class _CreateTourState extends State<CreateTour> {
  int dayCount = 1;
  void _addDay() {
    setState(() {
      dayCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SingleChildScrollView(), //////////
            const SizedBox(height: 60),
            const LogoHeader(),
            const SizedBox(height: 30),
            const Header(textHeader: 'Create TOUR'),
            const SizedBox(height: 30),
            const TourName(),
            const SizedBox(height: 20),
            const Divider(
              thickness: 1.0,
              color: Color.fromARGB(255, 10, 124, 218),
            ),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 1; i <= dayCount; i++)
                            Container(
                              width: 80,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              color: Colors.white,
                              child: Text(
                                'Day$i',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _addDay,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      size: 16,
                      color: Color.fromARGB(255, 0, 110, 200),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0,
              color: Color.fromARGB(255, 10, 124, 218),
            ),
            const SizedBox(height: 12),
            Plan()
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const CreateTour());
}

class TourName extends StatelessWidget {
  const TourName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            // SingleChildScrollView(),
            Padding(
              padding: EdgeInsets.only(left: 44),
              child: Text(
                'TOUR 이름      ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 220,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '일본 도쿄 투어',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text(
                '여행사      ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 220,
              child: TextField(
                decoration: InputDecoration(
                  hintText: '하나 투어',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
