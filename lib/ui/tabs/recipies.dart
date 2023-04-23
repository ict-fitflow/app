import 'package:animations/animations.dart';
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
      itemCount: 10,
      itemBuilder: (context, index) {
        return _OpenContainerWrapper(
          transitionType: _transitionType,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return _RecipeCard(openContainer: openContainer);
          },
          onClosed: (bool? isMarkedAsDone) => print('modal close'),
        );
      }
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return _InkWellOverlay(
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
                    'Recipe name',
                    style: Theme.of(context).textTheme.displaySmall
                  )
                )
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Facile'),
                    Text('5 min')
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
  const _InkWellOverlay({
    this.openContainer,
    this.height,
    this.child,
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
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return const RecipePage();
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

