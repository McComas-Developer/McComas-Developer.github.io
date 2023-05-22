import 'package:flutter/cupertino.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => ProfileState();
}

class ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("I'm the PROFILE page"));
  }
}