import 'package:exam/Screen/Controller/taskController.dart';
import 'package:exam/Utils/DataBase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TaskController taskController = Get.put(TaskController());
  TextEditingController txtTask = TextEditingController();
  TextEditingController txtCate = TextEditingController();

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
          title: Text("Add New Task"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(cursorColor: Colors.teal,
                  controller: txtTask,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Task Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(cursorColor: Colors.teal,
                  controller: txtCate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "In Which Category?",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () async {
                    DbHandler.dbHandler
                        .insertData(task: txtTask.text, category: txtCate.text);
                    getData();
                    Get.back();
                  },
                  child: Text("Add"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
