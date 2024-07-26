import 'package:flutter/material.dart';
import 'package:racetracer/src/presentation/constants/colors.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.bubble, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: AppColors.white.withOpacity(0.4),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("SENDER"), Text("11:26")],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                "This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. This is an example text. "),
          ),
        ],
      ),
    );
  }
}
