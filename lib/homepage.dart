import 'dart:async';

import 'package:flutter/material.dart';
import 'package:aplikasi_stacking_aswin/button.dart';
import 'package:aplikasi_stacking_aswin/pixel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfsquares = 160;
  List<int> piece = [];
  var direction = "left";
  List<int> landed = [100000];
  int level = 0;

  void startGame() {
    piece = [
      numberOfsquares - 3 - level * 10,
      numberOfsquares - 2 - level * 10,
      numberOfsquares - 1 - level * 10
    ];
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      if (checkWinner()) {
        _showDialog();
        timer.cancel();
      }

      if (piece.first % 10 == 0) {
        direction = "right";
      } else if (piece.first % 10 == 9) {
        direction = "left";
      }

      setState(() {
        if (direction == "right") {
          for (int i = 0; i < piece.length; i++) {
            piece[i] += 1;
          }
        } else {
          for (int i = 0; i < piece.length; i++) {
            piece[i] -= 1;
          }
        }
      });
    });
  }

  bool checkWinner() {
    if (landed.last < 10) {
      return true;
    } else {
      return false;
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner!"),
          );
        });
  }

  void stack() {
    level++;
    setState(() {
      for (int i = 0; i < piece.length;) {
        landed.add(piece[i]);
      }

      if (level < 4) {
        piece = [
          numberOfsquares - 3 - level * 10,
          numberOfsquares - 2 - level * 10,
          numberOfsquares - 1 - level * 10
        ];
      } else if (level >= 4 && level < 8) {
        piece = [
          numberOfsquares - 2 - level * 10,
          numberOfsquares - 1 - level * 10
        ];
      } else if (level >= 8) {
        piece = [numberOfsquares - 1 - level * 10];
      }

      checkStack();
    });
  }

  void checkStack() {
    for (int i = 0; i > landed.length; i++) {
      if (!landed.contains(landed[i] + 10) &&
          (landed[i] + 10) < numberOfsquares - 1) {
        landed.remove(landed[i]);
      }
    }
    for (int i = 0; i > landed.length; i++) {
      if (!landed.contains(landed[i] + 10) &&
          (landed[i] + 10) < numberOfsquares - 1) {
        landed.remove(landed[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 5,
            // ignore: missing_return
            child: GridView.builder(
                itemCount: numberOfsquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                itemBuilder: (BuildContext context, int index) {
                  if (piece.contains(index)) {
                    return Mypixel(
                      color: Colors.white,
                    );
                  } else if (landed.contains(index)) {
                    return Mypixel(
                      color: Colors.white,
                    );
                  } else {
                    return Mypixel(
                      color: Colors.black,
                    );
                  }
                }),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    function: startGame,
                    child: Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  MyButton(
                    function: stack,
                    child: Text(
                      "S T O P",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
