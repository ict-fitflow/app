import 'package:flutter/material.dart';

class RecipeTab extends StatelessWidget {
  const RecipeTab({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RecipePageStfull(),
    );
  }
}

class RecipePageStfull extends StatefulWidget {
  const RecipePageStfull({super.key});

  @override
  State<RecipePageStfull> createState() => _RecipePageStfullState();
}

class _RecipePageStfullState extends State<RecipePageStfull> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          children: <Widget>[
            TextButton(
              onPressed: details.onStepContinue,
              child: const Text('NEXT'),
            ),
            TextButton(
              onPressed: details.onStepCancel,
              child: const Text('CANCEL'),
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
      steps: <Step>[
        Step(
          title: const Text('Step 1 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        const Step(
          title: Text('Step 2 title'),
          content: Text('Content for Step 2'),
        ),
      ],
    );
  }
}
