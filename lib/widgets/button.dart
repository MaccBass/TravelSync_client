/*button 2개*/
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text1;
  final String text2;

  const Button({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: FractionalOffset.bottomRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFEFF5FF),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 80, 80, 80).withOpacity(0.7),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 32,
                ),
                child: Text(
                  text1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20), // Adjust the margin between buttons
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5FbFF),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 80, 80, 80).withOpacity(0.7),
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 38),
                child: Text(
                  text2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
