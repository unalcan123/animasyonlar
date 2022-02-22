import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedContainerApp extends StatefulWidget {
  const AnimatedContainerApp({Key? key}) : super(key: key);

  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        lowerBound: 20,
        upperBound: 60);
    controller?.addListener(() {
      setState(() {
        debugPrint(controller?.value.toString());
      });
    });
    controller?.forward(from: 20);
    controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller?.reverse().orCancel;
      } else if (status == AnimationStatus.dismissed) {
        controller?.forward().orCancel;
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.withOpacity((controller?.value)! / 100),
      appBar: AppBar(
        title: Text('container animasyon'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          width: _width,
          height: _height,
          decoration: BoxDecoration(color: _color, borderRadius: _borderRadius),
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            final random = Random();

            // hoogde en bredde
            _width = random.nextInt(300).toDouble();
            _height = random.nextInt(300).toDouble();

            //color
            _color = Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                random.nextInt(256), 1);

            _borderRadius =
                BorderRadius.circular(random.nextInt(100).toDouble());
          });
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
