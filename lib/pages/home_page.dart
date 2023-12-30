import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: Drawer(
        backgroundColor: Colors.amber,
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(
                Icons.menu,
                size: 48,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("H O M E"),
              onTap: () {
                Navigator.pushNamed(context, "/homePage");
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
              ),
              title: const Text("S E T T I N G"),
              onTap: () {
                Navigator.pushNamed(context, "/settingPage");
              },
            )
          ],
        ),
      ),
      body: const Text("Body"),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Tasks"),
      centerTitle: true,
    );
  }
}
