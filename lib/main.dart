import 'package:flutter/material.dart';
import 'package:numbertrivia/number_trivia/presentation/pages/NumberTriviaScreen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(NumberTriviaApp());
}

class NumberTriviaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      home: NumberTriviaScreen(),
    );
  }
}
