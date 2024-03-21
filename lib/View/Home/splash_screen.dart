import 'dart:async';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:easflow_v1/Widgets/palette.dart';
import 'package:easflow_v1/Services/animation_route.dart';
import 'package:easflow_v1/View/Home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1;
      });
    });
  }

  late Timer timer;
  void goHome() {
    timer = Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        SlideButtom(page: Home()),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Expanded(flex: 4, child: SizedBox()),
        AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _opacity,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Animator<double>(
                tween: Tween<double>(begin: 120, end: 150),
                duration: const Duration(seconds: 3),
                cycles: 0,
                builder: (context, AnimatorState, child) => Center(
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: AnimatorState.value,
                          width: AnimatorState.value,
                          child: const Image(
                            image: AssetImage("assets/images/logo.png"),
                          )),
                    )),
          ),
        ),
        const Expanded(flex: 4, child: SizedBox()),
        const CircularProgressIndicator(
          color: Palette.apple,
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Text("Agendium",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Palette.apple)),
          ),
        )
      ],
    ));
  }
}
