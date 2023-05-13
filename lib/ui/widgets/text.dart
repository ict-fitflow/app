import 'package:flutter/material.dart';

class TextTiny extends StatelessWidget {
  final String text;
  final Color? color;
  const TextTiny(this.text, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle style = Theme.of(context).textTheme.titleSmall!.apply(
        color: color
    );

    return Text(
        text,
        style: style
    );
  }
}

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

class TextLarge extends StatelessWidget {
  final String text;
  final Color? color;
  const TextLarge(this.text, {Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle style = Theme.of(context).textTheme.headlineSmall!.apply(
        color: color
    );

    return Text(
        text,
        style: style
    );
  }
}