import 'package:flutter/material.dart';

class PouringPage extends StatefulWidget {
  const PouringPage({Key? key}) : super(key: key);

  @override
  State<PouringPage> createState() => _PouringPageState();
}

class _PouringPageState extends State<PouringPage> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {

      });
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pouring"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      child: CircularProgressIndicator(
                          value: controller.value
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${(controller.value * 100).toInt()}",
                      style: Theme.of(context).textTheme.displaySmall
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
