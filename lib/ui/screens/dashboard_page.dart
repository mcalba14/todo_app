import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({required this.userId, super.key});

  final int userId;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _pending;
  String? _completed;
  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    getData();
  }

  void getData() async {
    final String userId = widget.userId.toString();
    final url = Uri.parse('http://10.0.2.2:8000/api/dashboard');
    final response = await http.post(url, body: {'id': userId});
    Map responseMap = jsonDecode(response.body);

    setState(() {
      _pending = responseMap['data']['pending'].toString();
      _completed = responseMap['data']['completed'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text('$_completed Task/s Completed',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 186, 9),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    '$_pending Task/s Pending',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
