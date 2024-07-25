import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestSessionsPage extends StatelessWidget {
  static const routeName = '/test_sessions';

  const TestSessionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.test_sessions),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text("Test Session $index"),
        ),
      ),
    );
  }
}
