import 'package:flutter/material.dart';

class NodesWidget extends StatelessWidget {
  const NodesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: Change later, Just a demo
        title: Text("TODO:"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(),
      ),
    );
  }
}
