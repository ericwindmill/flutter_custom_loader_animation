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

  @override
  initState() {
    super.initState();
    _forwardController = new AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _playAnimation();
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
    super.dispose();
  }

  Widget get forwardStaggeredAnimation {
    return new StaggeredAnimation(
      controller: _forwardController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: forwardStaggeredAnimation
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
