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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => open_recipe_page(),
          child: Card(
            child: SizedBox(
              width: 300,
              height: 150,
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
                  Padding(
                    padding: EdgeInsets.all(10),
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
    );
  }

  void open_recipe_page() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => RecipePage())
    );
  }
}
