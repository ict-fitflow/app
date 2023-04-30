import 'package:fitflow/ui/pages/tabs.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FitFlowApp());
}

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitFlow',
      theme: ThemeData.light(),
      home: const TabsPage(),
    );
  }
}
