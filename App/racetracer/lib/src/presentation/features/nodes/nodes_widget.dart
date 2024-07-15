import 'package:flutter/material.dart';
import 'package:racetracer/src/application/ros/ros_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NodesWidget extends StatelessWidget {
  const NodesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TODO: Change later, Just a demo
          title: Text("TODO:"),
        ),
        body: BlocProvider(
          create: (context) => RosBloc(),
          child: BlocBuilder<RosBloc, RosState>(
            builder: (context, state) {
              if (state is RosFetched) {
                return ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(state.topics[index]),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
