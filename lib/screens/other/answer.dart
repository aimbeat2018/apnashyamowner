import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerScreen extends StatelessWidget {
  final String? question, answer;

  const AnswerScreen({super.key, this.question, this.answer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question!,
                style: GoogleFonts.rozhaOne(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Answer :-',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                answer!,
                style: TextStyle(fontSize: 18.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
