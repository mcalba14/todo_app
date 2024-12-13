import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.userId, super.key});

  final int userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _name;
  String? _email;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final String userId = widget.userId.toString();
    final url = Uri.parse('http://10.0.2.2:8000/api/dashboard');
    final response = await http.post(url, body: {'id': userId});
    Map responseMap = jsonDecode(response.body);

    setState(() {
      _name = responseMap['data']['pending'].toString();
      _email = responseMap['data']['completed'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: ExactAssetImage('assets/images/avatar.jpeg'),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue,
                  width: 5.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * .4,
              child: Row(
                children: [
                  Text(
                    '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  // SizedBox(
                  //     height: 24,
                  //     child: Image.asset("assets/images/verified.png")),
                ],
              ),
            ),
            Text(
              '',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushReplacement(
                //     context,
                //     PageTransition(
                //         child: const SignIn(),
                //         type: PageTransitionType.leftToRight));
              },
              child: SizedBox(
                height: size.height * .6,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    // ProfileWidget(
                    //   icon: Icons.logout,
                    //   title: 'Log Out',
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
