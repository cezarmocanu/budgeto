import 'package:flutter/material.dart';

class WizzardStep1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Card(
              child: Text("Unique expanese"),
            ),
            Card(
              child: Text("Unique expanese"),
            ),
            Card(
              child: Text("Unique expanese"),
            )
          ],
        ),
      ),
    );
  }
}
