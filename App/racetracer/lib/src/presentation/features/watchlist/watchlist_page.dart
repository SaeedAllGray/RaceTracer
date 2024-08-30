import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/add_value_object_bottom_sheet.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/observe_topic_button.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/value_object_widget.dart';
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
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return AddValueObjectBottomSheet();
                    });
              },
              icon: const Icon(Icons.add_rounded))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              ValueObjectWidget(
                valueObject: ValueObject(value: '30', label: 'label'),
              ),
              ValueObjectWidget(
                valueObject: ValueObject(value: '30', label: 'label'),
              ),
              ValueObjectWidget(
                valueObject: ValueObject(value: '30', label: 'label'),
              ),
              ObserveTopicButton()
            ],
          ),
        ),
      ),
    );
  }
}
