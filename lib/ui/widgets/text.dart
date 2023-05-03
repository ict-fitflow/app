import 'package:flutter/material.dart';

class TextSmall extends StatelessWidget {
  final String text;
  final Color? color;
  const TextSmall(this.text, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle style = Theme.of(context).textTheme.titleMedium!.apply(
        color: color
    );

    return Text(
        text,
        style: style
    );
  }
}

class TextMedium extends StatelessWidget {
  final String text;
  final Color? color;
  const TextMedium(this.text, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle style = Theme.of(context).textTheme.titleLarge!.apply(
        color: color
    );

    return Text(
      text,
      style: style
    );
  }
}