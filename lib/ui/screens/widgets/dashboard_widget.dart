import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({
    super.key,
    required this.id,
    // required this.dataList,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Text('Dashboard ${id}');
  }
}
