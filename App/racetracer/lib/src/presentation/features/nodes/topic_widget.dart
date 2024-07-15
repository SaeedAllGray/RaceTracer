import 'package:flutter/material.dart';
import 'package:racetracer/src/application/ros/ros_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:racetracer/src/presentation/features/nodes/topic_info_widget.dart';

class TopicWidget extends StatelessWidget {
  const TopicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TODO: Change later, Just a demo
          title: Text("TODO:"),
        ),
        body: BlocProvider(
          create: (context) => RosBloc()..add(GetTopics()),
          child: BlocBuilder<RosBloc, RosState>(
            builder: (context, state) {
              if (state is TopicsFetched) {
                return ListView.builder(
                  itemCount: state.topics.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(state.topics[index]),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              TopicInfoWidget(topic: state.topics[index]),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
