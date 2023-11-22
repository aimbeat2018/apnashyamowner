import 'package:flutter/material.dart';

class OnNavigate extends StatelessWidget {
  final String? text;

  const OnNavigate({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: Text(
          text!,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
