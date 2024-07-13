import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Start Turtle"),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text("Stop Turtle"),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text("Start Recording"),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text("Stop Recording"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
