import 'package:flutter/material.dart';

class AnimatedContainerApp2 extends StatefulWidget {
  const AnimatedContainerApp2({Key? key}) : super(key: key);

  @override
  _AnimatedContainerApp2State createState() => _AnimatedContainerApp2State();
}

class _AnimatedContainerApp2State extends State<AnimatedContainerApp2> {
  double gen = 100;
  double yuk = 100;
  String yaz = 'Buyuk';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              color: Colors.redAccent,
              width: gen,
              height: yuk,
              duration: Duration(seconds: 3),
              curve: Curves.easeInExpo,
            ),
            ElevatedButton(
                onPressed: () {
                  if (yaz == 'Buyuk') {
                    setState(() {
                      gen = 300;
                      yuk = 300;
                      yaz = 'kucuk';
                    });
                  } else {
                    gen = 100;
                    yuk = 100;
                    yaz = 'Buyuk';
                    setState(() {});
                  }
                },
                child: Text(yaz))
          ],
        ),
      ),
    );
  }
}
