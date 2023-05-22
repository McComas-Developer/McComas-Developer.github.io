import 'package:flutter/cupertino.dart';


class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("I'm the SETTINGS page"));
  }
}