import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 45.0,
      height: 14.0,
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: new BorderRadius.circular(10.0),
      ),
    );
  }
}

class PivotTransition extends AnimatedWidget {
  PivotTransition({
    Key key,
    this.alignment: FractionalOffset.centerRight,
    @required Animation<double> turns,
    this.child,
    this.isHalfPivot: true,
    this.isClockwise: true,
    @required this.name,
  }) : super(key: key, listenable: turns);

  Animation<double> get turns => listenable;
  final FractionalOffset alignment;
  final Widget child;
  final bool isHalfPivot;
  final bool isClockwise;
  final String name;
  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    var clockwiseFull = new Matrix4.rotationZ((turnsValue * math.pi * 2.0));
    var counterClockwiseFull =
    new Matrix4.rotationZ(-(turnsValue * math.pi * 2.0));
    var clockwiseHalf =
    new Matrix4.rotationZ((turnsValue * math.pi * 2.0) * .5);
    var counterClockwiseHalf =
    new Matrix4.rotationZ(-(turnsValue * math.pi * 2.0) * .5);

    var transform;
    switch (name) {
      case 'barOne':
        transform = clockwiseHalf;
        break;
      case 'barTwo':
        transform = counterClockwiseHalf;
        break;
      case 'barThree':
        transform = clockwiseHalf;
        break;
      case 'barFour':
        transform = counterClockwiseHalf;
        break;
    }

    return new Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

class StaggeredAnimation extends StatelessWidget {
  final Animation<double> controller;
  final Animation<double> barOneRotation;
  final Animation<double> barTwoRotation;
  final Animation<double> barThreeRotation;
  final Animation<double> barFourRotation;

  StaggeredAnimation({this.controller}) :
        barOneRotation = new Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.0,
              0.25,
              curve: Curves.linear,
            ),
          ),
        ),
        barTwoRotation = new Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.25,
              0.5,
              curve: Curves.linear,
            ),
          ),
        ),
        barThreeRotation = new Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.5,
              0.75,
              curve: Curves.linear,
            ),
          ),
        ),
        barFourRotation = new Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          new CurvedAnimation(
            parent: controller,
            curve: new Interval(
              0.75,
              1.0,
              curve: Curves.linear,
            ),
          ),
        );

  Widget barOne = new Bar();
  Widget barTwo = new Bar();
  Widget barThree = new Bar();
  Widget barFour = new Bar();

  Widget buildAnimation(BuildContext context, Widget child) {
    return Center(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new PivotTransition(
            turns: barOneRotation,
            alignment: FractionalOffset.centerRight,
            name: 'barOne',
            child: barOne,
          ),
          new PivotTransition(
            turns: barTwoRotation,
            alignment: FractionalOffset.centerRight,
            name: 'barTwo',
            child: barTwo,
          ),
          new PivotTransition(
            turns: barThreeRotation,
            alignment: FractionalOffset.centerRight,
            name: 'barThree',
            child: barThree,
          ),
          new PivotTransition(
            turns: barFourRotation,
            alignment: FractionalOffset.centerRight,
            isHalfPivot: false,
            name: 'barFour',
            child: barFour,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
      builder: buildAnimation,
      animation: controller,
    );
  }
}
