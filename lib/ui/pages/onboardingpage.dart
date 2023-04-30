import 'package:fitflow/ui/pages/tabs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    // style sheet della pagina
    const  pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
      bodyFlex: 0,
      contentMargin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8
      ),
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      key: introKey,
      pages: [
        PageViewModel(
            title: "Welcome on FitFlow",
            body: "Let's begin with a little tutorial",
            // image: _buildImage('intro1.png'),
            decoration: pageDecoration
        )
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Start!'),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    );
  }

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const TabsPage()),
    );
  }

  // load image from memory
  Widget _buildImage(String assetName) {
    return Image.asset(
        'assets/$assetName',
        fit: BoxFit.fitHeight,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center
    );
  }
}
