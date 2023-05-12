import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/recipe.dart';
import 'package:fitflow/providers/bluetooth.dart';
import 'package:fitflow/ui/charts/recipe_pie.dart';
import 'package:fitflow/ui/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  Recipe recipe;
  RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int _index = 0;
  bool _can_continue = false;
  bool _finished = false;

  double _pour_value = 0;
  late BluetoothProvider bluetooth;

  @override
  void initState() {
    super.initState();
    bluetooth = context.read<BluetoothProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe details"),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                loadImage(widget.recipe.path),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMedium(widget.recipe.name),
                    TextSmall("+ 350 cal", color: Colors.lightGreen)
                  ],
                )
              ],
            )
          ),
          RecipePieChart(),
          Theme(
            data: ThemeData(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.green,
                secondary: Colors.red,
                background: Colors.red,
              ),
            ),
            child: Stepper(
              connectorThickness: 2,
              controlsBuilder: _controls_builder,
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  setState(() {
                    _index -= 1;
                  });
                }
              },
              onStepContinue: () {
                if (widget.recipe.steps.length - 1 == _index) {
                  setState(() {
                    _finished = true;
                  });
                  return;
                };
                setState(() {
                  if (_can_continue) {
                    _index += 1;
                    _can_continue = false;
                  }
                  else {
                    _pour_value = 0;
                    _start_pouring(widget.recipe.steps[_index].pour!);
                  }
                });
              },
              steps: _generate_steps()
            ),
          )
        ],
      ),
    );
  }

  void _start_pouring(PouringConfig config) {

    Stream<double> pour = bluetooth.do_pour(config);

    pour.listen(
      (val) {
        setState(() {
          _pour_value = val;
        });
      },
      onDone: () => setState(() {
        _can_continue = true;
      }),
      onError: (error) => print(error),
    );
  }

  Image loadImage(String path) {
    return Image(
      image: AssetImage(path),
      fit: BoxFit.contain,
      height: 100,
      width: 100,
    );
  }

  Widget _controls_builder(BuildContext context, ControlsDetails details) {

    if (widget.recipe.steps[_index].pour == null) {
      _can_continue = true;
    }

    String btn_continue = "Start pour";
    if (_can_continue) {
      btn_continue = "Continue";
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: details.onStepCancel,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: details.onStepContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green
          ),
          child: Text(btn_continue),
        ),
      ],
    );
  }

  List<Step> _generate_steps() {
    return widget.recipe.steps.map((step) {
      int index = widget.recipe.steps.indexOf(step);
      Widget? content;
      if (step.pour != null && _can_continue == false) {
        // content = Text("${step.pour!.what} ${step.pour!.quantity}");
        content = LinearProgressIndicator(
          value: _pour_value,
          color: Colors.green,
          backgroundColor: Colors.green.withOpacity(0.4),
        );
      }
      return Step(
        isActive: (index < _index || _finished) ? true : false,
        title: Text(step.name),
        content: Container(
          alignment: Alignment.centerLeft,
          child: content
        ),
        state: (index < _index || _finished) ? StepState.complete : StepState.indexed
      );
    }).toList();
  }
}
