import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/features/auth/auth_page.dart';
import 'package:racetracer/src/presentation/features/dashboard/dashboard_page.dart';
import 'package:racetracer/src/presentation/features/documentation/documentation_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getTabs().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.dashboard_customize_rounded,
            ),
            label: AppLocalizations.of(context)!.dashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.assignment_rounded,
            ),
            label: AppLocalizations.of(context)!.documentation,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> getTabs() => <Widget>[
        const DashboardPage(),
        // const DocumentationPage(),
        const AuthPage()
      ];
}
