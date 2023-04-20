import 'package:flutter/material.dart';

class PouringPage extends StatefulWidget {
  const PouringPage({Key? key}) : super(key: key);

  @override
  State<PouringPage> createState() => _PouringPageState();
}

class _PouringPageState extends State<PouringPage> {
  double _controller = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pouring"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
              value: _controller
          )
        ],
      )
    );
  }
}
