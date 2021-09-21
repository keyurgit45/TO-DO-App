import 'package:firebase_revision/services/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime selectedDate = DateTime.now();
  bool isDateSelected = false;
  String formattedDate = "No Date";
  TextEditingController taskName = TextEditingController();
  TextEditingController details = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 28.0, bottom: 20.0),
                    child: Icon(Icons.close),
                  ),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 22.0),
              child: Text(
                "Add Task",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 22.0, top: 10.0, bottom: 15),
              child: Text("Fill out the details below to add a new task"),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 22.0, bottom: 10, right: 22.0),
              child: TextFormField(
                controller: taskName,
                decoration: const InputDecoration(
                    labelText: "Task Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)))),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 22.0, bottom: 10, right: 22.0),
              child: TextFormField(
                controller: details,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: "Details",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)))),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 22.0, bottom: 10, right: 22.0),
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              isDateSelected ? Colors.blue : Color(0xFF6A6A6A)),
                      borderRadius: BorderRadius.circular(7)),
                  child: Center(
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                          color:
                              isDateSelected ? Colors.blue : Color(0xFF6A6A6A),
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: const BorderSide(color: Colors.blue)),
                    onPressed: () => print("log out"),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blue),
                    )),
                ElevatedButton(
                    onPressed: () {
                      if (taskName.text.isNotEmpty && details.text.isNotEmpty) {
                        var email = DataBaseHelper().AddTask(taskName.text,
                            details.text, formattedDate, context);
                      }
                    },
                    child: Text("Create Task"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        final DateFormat formatter = DateFormat('EEE, d/M/y');
        formattedDate = formatter.format(selectedDate);
        isDateSelected = true;
      });
    }
  }
}
