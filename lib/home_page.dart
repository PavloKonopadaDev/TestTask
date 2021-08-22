import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rgb_test_task/config/label.dart';
import 'package:rgb_test_task/cubit/counter_cubit.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final Random _random = Random();

  late LabelModel label;

  Color _color = Color(0xFFFFFFFF);

  void changeColor() {
    setState(() {
      _color = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        1,
      );
    });
  }

  Color _textColorForBackground(Color color) {
    if (ThemeData.estimateBrightnessForColor(color) == Brightness.dark) {
      return Colors.white;
    }

    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, CounterState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: _color,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  LabelModel.label["home.page.greeting_label"].toString(),
                  style: TextStyle(
                    color: _textColorForBackground(_color),
                    fontSize: 20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  changeColor();
                  context.read<CounterCubit>().increment();
                },
              ),
              if (state.counterOfTap % 20 == 0) ...[
                AlertDialog(
                  backgroundColor: Colors.deepOrange,
                  title: Text(
                    LabelModel.label["home.page.counter_label"].toString(),
                    style: TextStyle(
                      color: _textColorForBackground(_color),
                      fontSize: 20,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          '${state.counterOfTap}' + ' Times',
                          style: TextStyle(
                            color: _textColorForBackground(_color),
                            fontSize: 20,
                          ),
                        ),
                        if (state.counterOfTap == 40) ...[
                          Text(
                            LabelModel.label["home.page.alert_exception"]
                                .toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
