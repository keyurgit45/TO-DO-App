import 'package:firebase_revision/views/pages/add_task_page.dart';
import 'package:firebase_revision/views/pages/completed_tasks_page.dart';
import 'package:firebase_revision/views/pages/profile_page.dart';
import 'package:firebase_revision/views/pages/tasks_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List _children = const [
    TasksPage(),
    CompletedTasksPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFEAEEF4),
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
          print(index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add), label: "Tasks"),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Profile"),
        ],
      ),
      backgroundColor: const Color(0xFFEAEEF4),
      body: _children[_currentIndex],
      floatingActionButton: _currentIndex == 2
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (contetx) => AddTask()));
              },
            ),
    );
  }
}
