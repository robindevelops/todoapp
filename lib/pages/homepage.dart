import 'package:flutter/material.dart';
import 'package:todoapp/pages/todotile.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController _save = TextEditingController();
  List todolist = [
    ["HOME WORK", false],
    ["Assignment", true]
  ];

  void checkboxchanged(bool? value, int index) {
    setState(
      () {
        todolist[index][1] = !todolist[index][1];
      },
    );
  }

  void addTask(String task) {
    setState(() {
      todolist.add([task, false]);
    });
  }

  void deletetask(int index) {
    setState(() {
      todolist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        elevation: 0,
        title: const Text("TO DO"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todolist.length,
        itemBuilder: (context, index) {
          return ToDotile(
            taskname: todolist[index][0],
            taskcompleted: todolist[index][1],
            onChanged: (value) => checkboxchanged(value, index),
            deletefunction: (value) => deletetask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.yellow,
                content: Container(
                  height: 120,
                  child: Column(
                    children: [
                      TextField(
                        controller: _save,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                final save = _save.text;
                                addTask(save);
                                _save.clear();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
