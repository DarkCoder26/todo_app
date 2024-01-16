import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromARGB(41, 74, 72, 72),
      body: Text("d"),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        "Setting",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(41, 74, 72, 72),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 32,
      ),
    );
  }
}
