import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/providers/bluetooth.dart';
import 'package:fitflow/providers/user.dart';
import 'package:fitflow/ui/widgets/globalsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PouringPage extends StatefulWidget {
  PouringConfig config;
  PouringPage({Key? key, required this.config}) : super(key: key);

  @override
  State<PouringPage> createState() => _PouringPageState();
}

class _PouringPageState extends State<PouringPage> with TickerProviderStateMixin {
  late UserProvider userprofile;
  late BluetoothProvider bluetooth;
  late Stream<double> pour;
  double pour_value = 0;

  @override
  void initState() {
    super.initState();
    bluetooth = context.read<BluetoothProvider>();
    pour = bluetooth.do_pour(widget.config);

    userprofile = context.read<UserProvider>();

    pour.listen(
      (val) {
        setState(() {
          pour_value = val;
        });
      },
      onDone: () {
        userprofile.add_pour(widget.config);
        GlobalSnackbar.showSuccess("Well done!");
      },
      onError: (error) {
        GlobalSnackbar.showError("Something went wrong");
      },
    );
  }

  @override
  void dispose() {
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
                      child: CircularProgressIndicator(value: pour_value),
                    ),
                  ),
                  Center(
                    child: Text(
                      "${(pour_value * 100).toInt()}",
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
