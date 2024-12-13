import 'package:flutter/material.dart';
// import 'package:todo_app/ui/screens/widgets/dashboard_widget.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo_app/ui/screens/widgets/task_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({required this.userId, super.key});
  // const TaskPage({super.key});

  final int userId;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  List<Data> taskLists = [];

  final TextEditingController _textFieldController = TextEditingController();

  String? textField;
  String? valueText;

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Task title"),
            ),
            actions: <Widget>[
              GestureDetector(
                // color: Colors.blue[400],
                // textColor: Colors.white,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 7, bottom: 7),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                onTap: () {
                  final String userId = widget.userId.toString();
                  // setState(() {
                  //   textField = valueText;
                  // });
                  addTask(userId);
                },
              ),
            ],
          );
        });
  }

  void addTask($userId) async {
    final String userId = $userId;
    print(userId);
    final url = Uri.parse('http://10.0.2.2:8000/api/createtasks');
    final response = await http.post(url,
        body: {'user_id': userId, 'name': valueText, 'status': 'Pending'});
    Map responseMap = jsonDecode(response.body);
    // print(responseMap.values.first);
    setState(() {
      if (responseMap.values.first == 'success') {
        getData($userId);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
              child: const Text(
                'My Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * 0.8,
              child: FutureBuilder(
                  future: getData(widget.userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: taskLists.length,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              //   child: TaskWidget(
                              // index: index,
                              // taskLists: taskLists,

                              // )
                              onTap: () {
                                // print(taskLists[index].id);
                                final String id =
                                    taskLists[index].id.toString();
                                completed(id);
                              },
                              onLongPress: () {
                                print('deleted');
                                final String id =
                                    taskLists[index].id.toString();
                                deteleTask(id);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 60.0,
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  width: size.width,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          /*1*/
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              /*2*/
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: Text(
                                                  taskLists[index].name,
                                                  style: const TextStyle(
                                                    // decoration: TextDecoration.lineThrough,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              // Text(
                                              //   'location',
                                              //   style: TextStyle(
                                              //     color: Colors.grey[500],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        /*3*/
                                        // Icon(
                                        //   Icons.star,
                                        //   color: Colors.red[500],
                                        // ),
                                        // const Text('41'),
                                      ],
                                    ),
                                  )),
                            );
                          });
                    } else {
                      return const Center(
                        // child: CircularProgressIndicator(),
                        child: Text("No Pending Tasks"),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[400],
        tooltip: 'New Task',
        shape: const CircleBorder(),
        onPressed: () {
          _displayTextInputDialog(context);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  void completed(String $id) async {
    final String id = $id;
    final url = Uri.parse('http://10.0.2.2:8000/api/update');
    // final url = Uri.parse('http://127.0.0.1:8000/api/register');
    final response = await http.post(url, body: {'id': id});
    Map responseMap = jsonDecode(response.body);
    print(responseMap.values.first);

    setState(() {
      if (responseMap.values.first == 'success') {
        getData(widget.userId);
      }
    });
  }

  void deteleTask(String $id) async {
    final String id = $id;
    final url = Uri.parse('http://10.0.2.2:8000/api/delete');
    // final url = Uri.parse('http://127.0.0.1:8000/api/register');
    final response = await http.post(url, body: {'id': id});
    Map responseMap = jsonDecode(response.body);

    setState(() {
      if (responseMap.values.first == 'success') {
        getData($id);
      }
    });
  }

  Future<List<Data>> getData($userId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    taskLists = [];
    // const userId = 1;
    final userId = $userId;
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/tasks/$userId'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data["data"]) {
        taskLists.add(Data.fromJson(index));
      }
      return taskLists;
    } else {
      return taskLists;
    }
  }
}
