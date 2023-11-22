import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text1; //왼쪽버튼
  final String text2; //오른쪽버튼
  final Widget link1; //왼쪽버튼을 눌렀을 시 이동할 class
  final Widget link2; //오른쪽버튼을 눌렀을 시 이동할 class

  const Button({
    Key? key,
    required this.text1,
    required this.text2,
    required this.link1,
    required this.link2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 160,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => link1),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEFF5FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor:
                  const Color.fromARGB(255, 80, 80, 80).withOpacity(0.7),
              elevation: 2.0,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 16,
              ),
              child: Text(
                text1,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 160,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => link2),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF5FbFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor:
                  const Color.fromARGB(255, 80, 80, 80).withOpacity(0.7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 16,
              ),
              child: Text(
                text2,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
