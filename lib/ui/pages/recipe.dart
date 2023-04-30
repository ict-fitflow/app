import 'package:fitflow/classes/recipe.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  Recipe recipe;
  RecipePage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe details"),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Center(
            child: Text(
              widget.recipe.name,
              style: Theme.of(context).textTheme.displaySmall
            )
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.recipe.difficulty.name),
                Text('${widget.recipe.time} min')
              ],
            ),
          ),
          Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: <Widget>[
                  TextButton(
                    onPressed: details.onStepContinue,
                    child: const Text('Continue'),
                  ),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
            currentStep: _index,
            onStepCancel: () {
              if (_index > 0) {
                setState(() {
                  _index -= 1;
                });
              }
            },
            onStepContinue: () {
              if (_index <= 0) {
                setState(() {
                  _index += 1;
                });
              }
            },
            onStepTapped: (int index) {
              setState(() {
                // _index = index;
              });
            },
            steps: widget.recipe.steps.map((step) {
              late Widget content;
              if (step.pour != null) {
                content = Text("${step.pour!.what} ${step.pour!.quantity}");
              }
              else {
                content = Text('nothing to show');
              }
              return Step(
                title: Text(step.name),
                content: Container(
                    alignment: Alignment.centerLeft,
                    child: content
                )
              );
            }).toList()
            // <Step>[
            //   Step(
            //     title: const Text('Step 1 title'),
            //     content: Container(
            //       alignment: Alignment.centerLeft,
            //       child: const Text('Content for Step 1')
            //     ),
            //   ),
            //   Step(
            //     title: const Text('Step 2 title'),
            //     content: Container(
            //         alignment: Alignment.centerLeft,
            //         child: const Text('Content for Step 2')
            //     ),
            //   ),
            // ],
          ),
        ],
      ),
    );
  }
}
