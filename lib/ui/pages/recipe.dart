import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/recipe.dart';
import 'package:fitflow/providers/bluetooth.dart';
import 'package:fitflow/ui/charts/recipe_pie.dart';
import 'package:fitflow/ui/widgets/stepper.dart';
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

  bool _visible = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe details"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ListView(
            children: [
              Visibility(
                // TODO: put fadeout
                visible: _visible,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                loadImage(widget.recipe.path),
                                const Padding(padding: EdgeInsets.only(left: 20)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextMedium(widget.recipe.name),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextLarge("${widget.recipe.cal}", color: Colors.lightGreen),
                                        const TextSmall(" Kcal", color: Colors.lightGreen)
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                        )
                    ),
                    RecipePieChart()
                  ],
                )
              ),
              Theme(
                data: ThemeData(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Colors.green,
                    secondary: Colors.red,
                    background: Colors.red,
                  ),
                ),
                child: Column(
                  children: [
                    if (_visible) 
                      Stepper(
                        physics: const NeverScrollableScrollPhysics(),
                        margin: EdgeInsets.zero,
                        connectorThickness: 2,
                        controlsBuilder: _controls_builder,
                        currentStep: 0,
                        steps: _generate_steps()
                      )
                    else StepperWidget(recipe: widget.recipe),
                    const Padding(padding: EdgeInsets.only(bottom: 100))
                  ],
                )
              ),
            ],
          ),
          Visibility(
            visible: _visible,
            child: Positioned(
              bottom: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: ElevatedButton(
                    onPressed: _prepare_it,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const TextMedium("Prepare it")
                ),
              ),
            ),
          ),
          Visibility(
            visible: !_visible,
            child: Positioned(
              bottom: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: ElevatedButton(
                    onPressed: _prepare_it,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const TextMedium("Stop it")
                ),
              ),
            ),
          ),
        ],
      )
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
    return Container(
      height: 0,
      width: 0,
    );
  }

  List<Step> _generate_steps() {
    return widget.recipe.steps.map((step) {
      return Step(
        title: Text(step.name),
        content: Container(
          alignment: Alignment.centerLeft,
          child: null
        ),
        state: StepState.indexed
      );
    }).toList();
  }


  void _prepare_it() {
    setState(() {
      _visible = !_visible;
    });
  }
}
