import 'dart:async';
import 'package:custom_loader/animations.dart';
import 'package:flutter/material.dart';

class BarLoadingScreen extends StatefulWidget {
  @override
  _BarLoadingScreenState createState() => new _BarLoadingScreenState();
}

class _BarLoadingScreenState extends State<BarLoadingScreen>
    with TickerProviderStateMixin {
  AnimationController _forwardController;
  AnimationController _reverseController;
  bool isMovingForward = true;

  @override
  initState() {
    super.initState();
    _forwardController = new AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addStatusListener((status) => handleAnimatorComplete(status));
    _reverseController = new AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..addStatusListener((status) => handleReverseAnimatorComplete(status));
    _playAnimation();
  }

  handleAnimatorComplete(AnimationStatus status) {
//    if (status == AnimationStatus.completed) {
//      setState(() => isMovingForward = false);
//    }
  }

  handleReverseAnimatorComplete(AnimationStatus status) {
//    if (status == AnimationStatus.completed) {
//      setState(() => isMovingForward = true);
//    }
  }

  Future<Null> _playAnimation() async {
    try {
      await _forwardController.forward();
      await _forwardController.reverse();
      _playAnimation();
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
      print(this.toString());
    }
  }

  @override
  dispose() {
    _forwardController.dispose();
    _reverseController.dispose();
    super.dispose();
  }

  Widget get forwardStaggeredAnimation {
    return new StaggeredAnimation(
      isMovingForward: true,
      controller: _forwardController,
    );
  }

  Widget get reversedStaggeredAnimation {
    return new StaggeredAnimation(
      isMovingForward: false,
      controller: _reverseController,
    );
  }

  @override
  Widget build(BuildContext context) {
    _playAnimation();
    return new Container(
      child: isMovingForward
          ? forwardStaggeredAnimation
          : reversedStaggeredAnimation,
    );
  }
}

void main() {
  runApp(new MaterialApp(
    home: Scaffold(
      body: new BarLoadingScreen(),
    ),
  ));
}
