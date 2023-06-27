import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/recipe.dart';
import 'package:fitflow/providers/bluetooth.dart';
import 'package:fitflow/ui/charts/recipe_pie.dart';
import 'package:fitflow/ui/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepperWidget extends StatefulWidget {
  Recipe recipe;
  StepperWidget({Key? key, required this.recipe}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  int _index = 0;
  bool _can_continue = false;
  bool _finished = false;
  bool _show_progress_bar = false;

  double _pour_value = 0;
  late BluetoothProvider bluetooth;

  bool _show_commands = true;

  @override
  void initState() {
    super.initState();
    bluetooth = context.read<BluetoothProvider>();
  }

  @override
  Widget build(BuildContext context) {

    return Theme(
      data: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Colors.green,
          secondary: Colors.red,
          background: Colors.red,
        ),
      ),
      child: Column(
        children: [
          Stepper(
            physics: const NeverScrollableScrollPhysics(),
            connectorThickness: 2,
            controlsBuilder: _controls_builder,
            currentStep: _index,
            onStepCancel: _step_cancel,
            onStepContinue: _step_continue,
            steps: _generate_steps()
          ),
          const Padding(padding: EdgeInsets.only(bottom: 100))
        ],
      )
    );
  }

  void _start_pouring(PouringConfig config) {

    Stream<double> pour = bluetooth.do_pour(config);
    _show_commands = false;

    pour.listen(
      (val) {
        setState(() {
          _pour_value = val;
        });
      },
      onDone: () => setState(() {
        _can_continue = true;
        _show_commands = true;
      }),
      onError: (error) => print(error),
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

    return Visibility(
      visible: _show_commands,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      )
    );

  }

  List<Step> _generate_steps() {
    return widget.recipe.steps.map((step) {
      int index = widget.recipe.steps.indexOf(step);
      Widget? content;
      if (step.pour != null && _show_progress_bar == true) {
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

  void _step_cancel() {
    if (_index > 0) {
      setState(() {
        _can_continue = false;
        _show_progress_bar = false;
        _index -= 1;
      });
    }
  }

  void _step_continue() {
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
        _show_progress_bar = false;
      }
      else {
        _pour_value = 0;
        _show_progress_bar = true;
        _start_pouring(widget.recipe.steps[_index].pour!);
      }
    });
  }
}
