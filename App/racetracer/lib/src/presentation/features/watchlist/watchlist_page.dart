import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/value_object/value_object_bloc.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/constants/fonts.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/add_value_object_bottom_sheet.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/observe_topic_button.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/value_object_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ValueObjectBloc()..add(FetchValueObjects()),
      child: Scaffold(
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
        body: BlocBuilder<ValueObjectBloc, ValueObjectState>(
          builder: (context, state) {
            if (state is ValueObjectsFetched) {
              return GridView.builder(
                itemCount: state.valueObjects.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                padding: const EdgeInsets.all(5),
                itemBuilder: (context, index) {
                  if (index == state.valueObjects.length) {
                    return ObserveTopicButton();
                  }
                  return ValueObjectWidget(
                      valueObject: state.valueObjects[index]);
                },
              );
              // ObserveTopicButton()
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
