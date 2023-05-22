import 'package:flutter/cupertino.dart';


class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<StatefulWidget> createState() => FeedState();
}

class FeedState extends State<Feed> {

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("I'm the FEED page"));
  }
}