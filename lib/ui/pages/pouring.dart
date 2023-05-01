import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/user.dart';
import 'package:fitflow/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PouringPage extends StatefulWidget {
  PouringConfig config;
  PouringPage({Key? key, required this.config}) : super(key: key);

  @override
  State<PouringPage> createState() => _PouringPageState();
}

class _PouringPageState extends State<PouringPage> with TickerProviderStateMixin {
  late AnimationController controller;
  late UserProvider userprofile;

  @override
  void initState() {
    super.initState();
    userprofile = context.read<UserProvider>();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: (widget.config.quantity / 100 * 5) as int),
    )..addListener(() {
      setState(() {
        if (controller.isCompleted) {
          userprofile.add_pour(widget.config);
        }
      });
    });
    controller.forward();
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
