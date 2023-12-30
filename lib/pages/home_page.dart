import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> tasks = ["Task 1", "Task 2"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromARGB(41, 74, 72, 72),
      drawer: menuDrawer(context),
      body: taskListView(),
    );
  }

  ListView taskListView() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Dismissible(
          key: Key(task),
          onDismissed: (direction) {
            setState(() {
              tasks.removeAt(index);
            });
          },
          background: Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            color: Colors.red[400],
          ),
          child: ListTile(
            title: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 41, 42, 43),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tasks[index],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Drawer menuDrawer(BuildContext context) {
    return Drawer(
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
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("Tasks"),
      centerTitle: true,
    );
  }
}
