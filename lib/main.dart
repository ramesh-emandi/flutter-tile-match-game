import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("Match Tiles"),
      ),
      body: ShapeWidget(),
    ),
  ));
}

class ShapeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShapeWidgetState();
  }
}

class _ShapeWidgetState extends State<ShapeWidget> {
  var infoString = "Get Started";
  var containerOneColor = Colors.blue;
  var containerTwoColor = Colors.red;
  var containerThreeColor = Colors.orange;
  var containerFourColor = Colors.green;
  var containerFiveColor = Colors.yellow;
  var containerSixColor = Colors.teal;
  var containerSevenColor = Colors.brown;
  var colorsList = [
    Colors.pink,
    Colors.red,
    Colors.purple,
    Colors.indigo,
    Colors.yellow,
    Colors.green,
// Game can be prolonged by adding more colors
//    Colors.orange,
//    Colors.grey,
//    Colors.brown
  ];
  var random = new Random();

  MaterialColor generateRandomColor() {
    var random = new Random();
    return colorsList[random.nextInt(colorsList.length)];
  }

  Timer _timer;
  int _timeLeft = 0;

  void startTimer() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Match tiles to ONE color'),
      duration: Duration(seconds: 3),
    ));
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_timeLeft < 1) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Time\'s up !!!'),
              duration: Duration(seconds: 3),
            ));
            resetColors();
            timer.cancel();
          } else {
            _timeLeft = _timeLeft - 1;
          }
        },
      ),
    );
  }

  void stopTimer() {
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
    }
  }

  void isGameOver() {
    var setOfColors = {
      containerOneColor,
      containerTwoColor,
      containerThreeColor,
      containerFourColor,
      containerFiveColor,
      containerSixColor,
      containerSevenColor
    };
    if (_timer == null) {
      //timer instance null. on first run
      startTimer();
    }
    if (_timer != null && !_timer.isActive) {
      //2nd time game is run. 
      infoString = "Game ON";
      startTimer();
    } else if (setOfColors.length > 1) {
      print(setOfColors.length);
      infoString = "Clock is ticking... Tik Tok...";
    } else {
      print("Game Over!!!!");
      stopTimer();
      infoString = "Game Over. Cleaning up.";
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Hooray!!! Finished with $_timeLeft seconds left'),
        duration: Duration(seconds: 3),
      ));
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          resetColors();
        });
      });
    }
  }

  void resetColors() {
    containerOneColor = Colors.blue;
    containerTwoColor = Colors.red;
    containerThreeColor = Colors.orange;
    containerFourColor = Colors.green;
    containerFiveColor = Colors.yellow;
    containerSixColor = Colors.teal;
    containerSevenColor = Colors.brown;
    _timeLeft = 30;
    infoString = "You are THE EQUALIZER. \t Equalize to one color";
  }

  @override
  void initState() {
    resetColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "$_timeLeft",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: Icon(
                  Icons.play_circle_filled,
                  color: Colors.amberAccent,
                  size: 40.0,
                ),
                onPressed: () {
                  startTimer();
                  setState(() {
                    infoString = "Clock is ticking... Tik Tok...";
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.stop,
                  color: Colors.deepOrangeAccent,
                  size: 40.0,
                ),
                onPressed: () {
                  if (_timer.isActive) {
                    setState(() {
                      _timeLeft = 15;
                    });
                    _timer.cancel();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Timer Stopped...'),
                      duration: Duration(seconds: 3),
                    ));
                    resetColors();
                  }
                },
              ),
            ],
          ),
        ),
        _topRow(),
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              containerFourColor = generateRandomColor();
              isGameOver();
            });
          },
          child: Container(
            constraints: BoxConstraints.expand(),
            height: 100.0,
            width: 100.0,
            color: containerFourColor,
            child: Center(
                child: Text(
              infoString,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            )),
          ),
        )),
        _bottomRow(),
      ],
    ));
  }
  _topRow() {
    return Row(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                containerOneColor = generateRandomColor();
                isGameOver();
              });
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              color: containerOneColor,
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                containerTwoColor = generateRandomColor();
                isGameOver();
              });
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              color: containerTwoColor,
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                containerThreeColor = generateRandomColor();
                isGameOver();
              });
            },
            child: Container(
                height: 100.0, width: 100.0, color: containerThreeColor),
          ))
        ],
      );
  }

  _bottomRow() {
    return Row(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                containerFiveColor = generateRandomColor();
                isGameOver();
              });
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              color: containerFiveColor,
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                containerSixColor = generateRandomColor();
                isGameOver();
              });
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              color: containerSixColor,
            ),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              setState(() {
                containerSevenColor = generateRandomColor();
                isGameOver();
              });
            },
            child: Container(
              height: 100.0,
              width: 100.0,
              color: containerSevenColor,
            ),
          ))
        ],
      );
  }
}
