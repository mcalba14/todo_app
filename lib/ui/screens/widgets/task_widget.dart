import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.index,
    required this.taskLists,
  }) : super(key: key);

  final int index;
  final List<Data> taskLists;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        // print(taskLists[index].id);
        final url = Uri.parse('http://10.0.2.2:8000/api/register');
        // final url = Uri.parse('http://127.0.0.1:8000/api/register');
        final response =
            await http.post(url, body: {'id': taskLists[index].id});
        Map responseMap = jsonDecode(response.body);
        if (responseMap.values.first == 'success') {}
        // Navigator.push(
        //     context,
        //     PageTransition(
        //         child: DetailPage(
        //           plantId: plantList[index].plantId,
        //         ),
        //         type: PageTransitionType.bottomToTop));
      },
      onLongPress: () {
        print('deleted');
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60.0,
          padding: const EdgeInsets.only(left: 10, top: 5),
          margin: const EdgeInsets.only(bottom: 10),
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  /*1*/
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*2*/
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
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
  }
}
