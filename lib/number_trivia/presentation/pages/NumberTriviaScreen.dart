import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numbertrivia/injection_container.dart';
import 'package:numbertrivia/number_trivia/presentation/bloc/bloc_bloc.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/message_display.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/triviaAnimation.dart';
import 'package:numbertrivia/number_trivia/presentation/widgets/trivia_display.dart';

class NumberTriviaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: BlocProvider(
                    create: (_) => sl<BloC>(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: <Widget>[
                          TriviaAnimation(
                            animationName: 'infinityColor.json',
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            child: Text('NUMBER TRIVIA', style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w200,
                              fontSize: 55,
                            ),),
                          ),
                          // Top half
                          Expanded(
                            child: BlocBuilder<BloC, BlocState>(
                              builder: (context, state) {
                                if (state is Empty) {
                                  return MessageDisplay(
                                    isError: false,
                                    message: 'NUMBER TRIVIA',
                                  );
                                } else if (state is Loading) {
                                  return LoadingWidget();
                                } else if (state is Loaded) {
                                  return TriviaDisplay(
                                    numberTrivia: state.numberTrivia,
                                  );
                                } else if (state is Error) {
                                  return MessageDisplay(
                                    isError: true,
                                    message: state.message,
                                  );
                                }
                              },
                            ),
                          ),
                          // Bottom half
                          TriviaControls()
                        ],
                      ),
                    ),
                  ),
                )),
          );
        },
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
            prefixIcon: Icon(Icons.search),
            filled: true,
            labelText: 'Number',
            hintText: 'Enter a number',
          ),
          onChanged: (value) {
            setState(() {
              inputString = value;
            });
          },
          onSubmitted: (_) {
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
