import 'package:fitflow/classes/recipe.dart';
import 'package:fitflow/ui/charts/recipe_pie.dart';
import 'package:fitflow/ui/widgets/text.dart';
import 'package:flutter/material.dart';

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
                  }
                  _can_continue = !_can_continue;
                });
              },
              steps: _generate_steps()
            ),
          )
        ],
      ),
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
    print(Theme.of(context).colorScheme.primary);
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
      late Widget? content;
      if (step.pour != null) {
        content = Text("${step.pour!.what} ${step.pour!.quantity}");
      }
      else {
        content = null;
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
