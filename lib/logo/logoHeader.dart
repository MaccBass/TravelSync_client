import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context); //블랙화면 나옴
            },
            child: const Column(
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/airplane_travelsync.png',
                height: 70,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Icon(
                Icons.settings,
                size: 40,
                color: Color.fromARGB(255, 60, 60, 60),
              ), //나중에 값 넣기 Icon.switch(expression)
            ],
          ),
        ),
      ],
    );
  }
}
