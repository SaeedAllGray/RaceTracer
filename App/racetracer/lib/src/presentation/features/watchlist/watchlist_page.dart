import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/application/value_object/value_object_bloc.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/add_value_object_bottom_sheet.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/observe_topic_button.dart';
import 'package:racetracer/src/presentation/features/watchlist/widgets/value_object_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:racetracer/src/presentation/widgets/loading_widget.dart';
import 'package:racetracer/src/presentation/widgets/stretched_button.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ValueObjectBloc()..add(FetchValueObjectsStream()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.watchList),
          leading: BlocBuilder<ValueObjectBloc, ValueObjectState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.share_rounded),
                onPressed: () {
                  BlocProvider.of<ValueObjectBloc>(context).add(ShareConfig());
                },
              );
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return AddValueObjectBottomSheet();
                      }).whenComplete(
                    () => BlocProvider.of<ValueObjectBloc>(context)
                        .add(FetchValueObjects()),
                  );
                },
                icon: const Icon(Icons.add_rounded))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ValueObjectBloc, ValueObjectState>(
                builder: (context, state) {
                  if (state is ValueObjectsFetched) {
                    return GridView.builder(
                      itemCount: state.valueObjects.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      padding: const EdgeInsets.all(5),
                      itemBuilder: (context, index) {
                        if (index == state.valueObjects.length) {
                          return const ObserveTopicButton();
                        }
                        return ValueObjectWidget(
                          valueObject: state.valueObjects[index],
                          isEditing: isEditing,
                        );
                      },
                    );
                    // ObserveTopicButton()
                  } else if (state is ValueObjectsStreaming) {
                    return StreamBuilder(
                      stream: state.valueObjectsStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GestureDetector(
                            onLongPress: () => setState(() {
                              isEditing = !isEditing;
                            }),
                            child: GridView.builder(
                              itemCount: snapshot.data.length + 1,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              padding: const EdgeInsets.all(5),
                              itemBuilder: (context, index) {
                                if (index == snapshot.data.length) {
                                  return const ObserveTopicButton();
                                }
                                return Stack(
                                  children: [
                                    ValueObjectWidget(
                                      valueObject: snapshot.data[index],
                                      isEditing: isEditing,
                                    ),
                                    if (isEditing)
                                      Positioned(
                                          top: 2,
                                          left: 2,
                                          child: SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              style: OutlinedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                                foregroundColor:
                                                    AppColors.primaryDark,
                                                backgroundColor: AppColors
                                                    .primaryDark
                                                    .withOpacity(0.2),
                                              ),
                                              icon: const Icon(
                                                  Icons.remove_rounded),
                                              onPressed: () {
                                                BlocProvider.of<
                                                            ValueObjectBloc>(
                                                        context)
                                                    .add(RemoveValueObject(
                                                        index: index));
                                              },
                                            ),
                                          ))
                                  ],
                                );
                              },
                            ),
                          );
                        }
                        return const LoadingWidget();
                      },
                    );
                  }
                  return const LoadingWidget();
                },
              ),
            ),
            // BlocBuilder<ValueObjectBloc, ValueObjectState>(
            //   builder: (context, state) {
            //     return StretchedButton(
            //       child: const Icon(Icons.refresh_rounded),
            //       onPressed: () {
            //         BlocProvider.of<ValueObjectBloc>(context)
            //             .add(FetchValueObjects());
            //       },
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
