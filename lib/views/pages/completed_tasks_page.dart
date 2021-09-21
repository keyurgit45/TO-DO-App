import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_revision/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedTasksPage extends StatelessWidget {
  const CompletedTasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: const BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 40),
            child: Text(
              "Completed Tasks",
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(DataBaseHelper().userEmail.toString())
                  .doc("data")
                  .collection("tasks")
                  .where("isCompleted", isEqualTo: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.length == 0) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(
                          "Go complete some tasks! Get things done and they will show up here.",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.abel(fontSize: 22),
                        ),
                      ),
                    );
                  }
                }
                if (snapshot.hasData) {
                  var jsonData = snapshot.data.docs;
                  return ListView.builder(
                      itemCount: jsonData.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          key: UniqueKey(),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              await FirebaseFirestore.instance.runTransaction(
                                  (Transaction myTransaction) async {
                                await myTransaction.delete(
                                    snapshot.data.docs[index].reference);
                              });
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                left: 12, right: 12, bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            child: ExpansionTile(
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              leading: InkWell(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .runTransaction(
                                          (Transaction myTransaction) async {
                                    await myTransaction.update(
                                        snapshot.data.docs[index].reference,
                                        {"isCompleted": false});
                                  });
                                },
                                child: const Icon(
                                  Icons.circle_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(jsonData[index]['task_name'],
                                  style: GoogleFonts.chivo(
                                    fontSize: 19,
                                    color: Colors.white,
                                  )),
                              subtitle: Text(jsonData[index]['date'],
                                  style: GoogleFonts.chivo(
                                    fontSize: 15,
                                    color: Colors.white,
                                  )),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(jsonData[index]['details'],
                                      style: GoogleFonts.chivo(
                                        fontSize: 18,
                                        color: Colors.white,
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return Container();
                }
              }),
        )
      ],
    );
  }
}
