import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/value_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.watchList),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
            crossAxisCount: 2,
            children: [ValueWidget()],
          ),
        ),
      ),
    );
  }
}
