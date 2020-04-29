import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbertrivia/injection_container.dart';
import 'package:numbertrivia/number_trivia/domain/entities/NumberTrivia.dart';
import 'package:numbertrivia/number_trivia/presentation/bloc/bloc_bloc.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/message_display.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/trivia_display.dart';

class NumberTriviaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: BlocProvider(
        create: (_) => sl<BloC>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                // Top half
                BlocBuilder<BloC, BlocState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return MessageDisplay(
                        message: 'Start searching',
                      );
                    } else if (state is Loading) {
                      return LoadingWidget();
                    } else if (state is Loaded) {
                      return TriviaDisplay(
                        numberTrivia: state.numberTrivia,
                      );
                    } else if (state is Error) {
                      return MessageDisplay(
                        message: state.message,
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                // Bottom half
                TriviaControls()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputString;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            labelText: 'Number',
            hintText: 'Enter a number',
          ),
          onChanged: (value) {
            setState(() {
              inputString = value;
            });
          },
          onSubmitted: (_){
            addConcreteEvent();
          },
        ),
        SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: addConcreteEvent,
                child: Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: RaisedButton(
                onPressed: addRandomEvent,
                child: Text('Get Random Trivia'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void addConcreteEvent() {
    controller.clear();
    BlocProvider.of<BloC>(context).add(
      GetTriviaFromConcreteNumber(inputString),
    );
  }

  void addRandomEvent() {
    BlocProvider.of<BloC>(context).add(
      GetTriviaFromRandomNumber(),
    );
  }
}
