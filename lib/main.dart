import 'package:animasyonlar/animation_container.dart';
import 'package:flutter/material.dart';

import 'animated_container_app2.dart';
import 'animated_container_app3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  Animation? animation;
  Animation? animation1;

  Animation? animation2;
  Animation? animation3;

  AnimationController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );

    controller?.addListener(() {
      setState(() {
        // debugPrint(controller?.value.toString());
        // debugPrint(animation2?.value.toString());
      });
    });
    controller?.forward();
    controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller?.reverse().orCancel;
      } else if (status == AnimationStatus.dismissed) {
        controller?.forward().orCancel;
      }
    });
    // controller?.reverse();
    animation1 = Tween(begin: 1, end: 60).animate(controller!);
    // animation =        ColorTween(begin: Colors.red, end: Colors.yellow).animate(controller!);
    animation3 = CurvedAnimation(parent: controller!, curve: Curves.bounceIn);
    animation2 =
        AlignmentTween(begin: Alignment(-1.0, 1.0), end: Alignment(1.0, -1.0))
            .animate(controller!);

    animation3 = CurvedAnimation(parent: controller!, curve: Curves.bounceIn);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.green.withOpacity((controller?.value)! / 100),
      backgroundColor: animation?.value,

      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: (animation3?.value)! * 30),
            ),
            Container(
              color: Colors.green,
              height: 100,
              width: 300,
              alignment: animation2?.value,
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: (controller?.value)! * 20),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
                size: (controller?.value)! * 30,
              ),
              onPressed: () {},
            ),
            Text('Container animation 1'),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AnimatedContainerApp())),
                child: Icon(Icons.arrow_forward)),
            Text('Container animation 2'),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AnimatedContainerApp2())),
                child: Icon(Icons.arrow_forward)),
            Text('Container animation 3'),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AnimatedContainerApp3())),
                child: Icon(Icons.arrow_forward))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
