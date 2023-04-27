import 'package:animations/animations.dart';
import 'package:fitflow/class/recipe.dart';
import 'package:fitflow/mocks/recipe.dart';
import 'package:fitflow/ui/pages/recipe.dart';
import 'package:flutter/material.dart';

class RecipeTab extends StatelessWidget {
  const RecipeTab({super.key});

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

  final ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return _OpenContainerWrapper(
          transitionType: _transitionType,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return _RecipeCard(openContainer: openContainer, recipe: recipes[index]);
          },
          onClosed: (bool? isMarkedAsDone) => print('modal close'),
          recipe: recipes[index]
        );
      }
    );
  }
}

class _RecipeCard extends StatelessWidget {
  Recipe recipe;

  _RecipeCard({required this.openContainer, required this.recipe});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return _InkWellOverlay(
      recipe: recipe,
      openContainer: openContainer,
      height: 200,
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: 300,
          height: 200,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    recipe.name,
                    style: Theme.of(context).textTheme.displaySmall
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(recipe.difficulty.name),
                    Text('${recipe.time} min')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  Recipe recipe;

  _InkWellOverlay({
    this.openContainer,
    this.height,
    this.child,
    required this.recipe,
  });

  final VoidCallback? openContainer;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  Recipe recipe;

  _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.recipe,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return RecipePage(recipe: recipe);
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

