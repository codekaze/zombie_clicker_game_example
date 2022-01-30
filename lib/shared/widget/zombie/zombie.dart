import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Map<String, ZombieSpriteState> zombieState = {};

class ZombieSprite extends StatefulWidget {
  final String id;
  final double top;
  final double left;
  final double speed;

  ZombieSprite({
    required this.id,
    required this.top,
    required this.left,
    required this.speed,
  });

  @override
  ZombieSpriteState createState() => ZombieSpriteState();
}

class ZombieSpriteState extends State<ZombieSprite> {
  String mode = "walk";
  int index = 1;
  late double top;
  late double left;
  bool zombieDead = false;

  late Timer timer;
  @override
  void initState() {
    super.initState();
    zombieState[widget.id] = this;
    top = widget.top;
    left = widget.left;
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (left > Get.width) {
        left = -50;
      }

      if (mode == "walk") {
        left += 4 * widget.speed;
      }

      if (mode == "dead" && index == 10) {
        timer.cancel();
        Future.delayed(Duration(seconds: 1), () {
          zombieDead = true;
          setState(() {});
        });
        return;
      }

      if (index < 10) {
        index++;
      } else {
        index = 1;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  killZombie() {
    if (mode == "dead") return;
    mode = "dead";
    index = 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (zombieDead) return Container();
    return Positioned(
      top: top,
      left: left,
      child: InkWell(
        onTap: () => killZombie(),
        child: Image.asset(
          "assets/image/$mode$index.png",
          width: mode == "walk" ? 120.0 : 140.0,
          height: mode == "walk" ? 120.0 : 140.0,
        ),
      ),
    );
  }
}
