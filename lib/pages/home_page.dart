import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<String> tasks = [];
  final myController = TextEditingController();
  late AnimationController animationController;

  @override
  void initState() {
    super.initState;
    loadData();
    animationController = AnimationController(vsync: this);
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks')!;
    });
  }

  void removeTask(index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks.removeAt(index);
    });
    await prefs.setStringList('tasks', tasks);
  }

  addTask(String task) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks.add(task);
    });
    await prefs.setStringList('tasks', tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromARGB(41, 74, 72, 72),
      drawer: menuDrawer(context),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          isListEmpty(),
          Positioned(
            bottom: 31,
            right: 20,
            child: addTaskButton(),
          ),
        ],
      ),
    );
  }

  Widget isListEmpty() {
    if (tasks.isNotEmpty) {
      return taskListView();
    } else {
      return Center(
        child: Image.asset(
          "assets/empty_animation.gif",
          height: 125.0,
          width: 125.0,
        ),
      );
    }
  }

  Dialog buildCustomDialog() {
    return Dialog(
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 41, 42, 43),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Enter Task",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  hintText: "Task",
                  filled: true,
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                addTask(myController.text);
                myController.clear();
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.amber),
              ),
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextButton addTaskButton() {
    return TextButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.amber),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return buildCustomDialog();
          },
        );
      },
      child: const Text(
        "+",
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  ListView taskListView() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                removeTask(index);
              });
            },
            background: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              color: Colors.red[400],
            ),
            child: ListTile(
              title: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
            ));
      },
    );
  }

  Drawer menuDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black87,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 48,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: const Text(
              "H O M E",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/homePage");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              "S E T T I N G",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
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
      title: const Text(
        "Tasks",
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
