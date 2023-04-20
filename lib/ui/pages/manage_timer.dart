import 'package:flutter/material.dart';

class ManageTimerPage extends StatefulWidget {
  const ManageTimerPage({Key? key}) : super(key: key);

  @override
  State<ManageTimerPage> createState() => _ManageTimerPageState();
}

class _ManageTimerPageState extends State<ManageTimerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer manager"),
      ),
      body: const Text("TODO")
    );
  }
}
