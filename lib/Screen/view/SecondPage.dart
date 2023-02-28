import 'package:exam/Screen/Controller/taskController.dart';
import 'package:exam/Screen/view/addtaskPage.dart';
import 'package:exam/Utils/DataBase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TaskController taskController = Get.put(TaskController());
  TextEditingController txtdTask = TextEditingController();
  TextEditingController txtdCate = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    taskController.dataList.value = await DbHandler.dbHandler.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            "${DateTime.now().weekday == 1 ? "monday" : ""}${DateTime.now().weekday == 1 ? "monday" : ""}${DateTime.now().weekday == 2 ? "Tuesday" : ""}${DateTime.now().weekday == 3 ? "Wednesday" : ""}${DateTime.now().weekday == 4 ? "Thursday" : ""}${DateTime.now().weekday == 5 ? "friday" : ""}${DateTime.now().weekday == 6 ? "Saturday" : ""} , ${DateTime.now().day} ${DateTime.now().month == 1 ? "Jan" : ""}${DateTime.now().month == 2 ? "Feb" : ""}${DateTime.now().month == 3 ? "Mar" : ""}${DateTime.now().month == 4 ? "Apr" : ""}${DateTime.now().month == 5 ? "May" : ""}${DateTime.now().month == 6 ? "Jun" : ""}${DateTime.now().month == 7 ? "Jul" : ""}${DateTime.now().month == 8 ? "Aug" : ""}${DateTime.now().month == 9 ? "Sep" : ""}${DateTime.now().month == 10 ? "Oct" : ""}${DateTime.now().month == 11 ? "Nov" : ""}${DateTime.now().month == 12 ? "Dec" : ""}",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(
                  AddTaskPage(),
                );
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: taskController.dataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${taskController.dataList[index]['task']}"
                            .toUpperCase(),
                      ),
                      subtitle: Text(
                        "${taskController.dataList[index]['category']}"
                            .toUpperCase(),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              DbHandler.dbHandler.deleteData(
                                  id: taskController.dataList[index]['id']);
                              Get.snackbar("Welldone", "Your Task Is Complete");
                              getData();
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              txtdTask = TextEditingController(
                                  text: taskController.dataList[index]['task']);
                              txtdCate = TextEditingController(
                                  text: taskController.dataList[index]
                                      ['category']);
                              Get.defaultDialog(
                                title: "Edit",
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: txtdTask,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: txtdCate,
                                    ),
                                  ],
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          DbHandler.dbHandler.updateData(
                                              id: taskController.dataList[index]
                                                  ['id'],
                                              name: txtdTask.text,
                                              number: txtdCate.text);
                                          Get.back();
                                          getData();
                                        },
                                        child: Text(
                                          "Update",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              DbHandler.dbHandler.deleteData(
                                  id: taskController.dataList[index]['id']);
                              getData();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
