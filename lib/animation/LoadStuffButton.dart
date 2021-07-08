import 'package:flutter/material.dart';

class LoadStuffButton extends StatefulWidget {
  @override
  _LoadStuffButtonState createState() => _LoadStuffButtonState();
}

class _LoadStuffButtonState extends State<LoadStuffButton> {
  bool _startedLoading = false;
  bool _firstAnimationFinished = false;
  bool _dataAvailable = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _clickLoadStuff,
      child: Container(), // TODO implement
    );
  }

  // TODO use somewhere
  void _listenToAnimationFinished(status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _firstAnimationFinished = true;
      });
    }
  }

  void _clickLoadStuff() {
    setState(() {
      _startedLoading = true;
    });
    Future.delayed(Duration(milliseconds: 2000)).then((_) {
      setState(() {
        _dataAvailable = true;
      });
    });
  }
}
