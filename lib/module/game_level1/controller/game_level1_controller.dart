import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_game/shared/widget/zombie/zombie.dart';
import 'package:uuid/uuid.dart';
import '../view/game_level1_view.dart';

class GameLevel1Controller extends GetxController {
  GameLevel1View? view;
  List<ZombieSprite> zombieList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    Get.defaultDialog(
      title: "Welcome!",
      middleText: "Start Game?",
      actions: [
        ElevatedButton(
          onPressed: () {
            startGame();
            Get.back();
          },
          child: Text("GO"),
        ),
      ],
    );
  }

  @override
  void onClose() {
    super.onClose();
    timer!.cancel();
  }

  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;

  Timer? timer;
  startGame() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (zombieList.length >= 30) {
        return;
      }

      spawnZombie(
        left: -160,
        top: 60.0,
        speed: doubleInRange(Random(), 0.6, 2.0),
      );
      spawnZombie(
        left: -160,
        top: 160.0,
        speed: doubleInRange(Random(), 0.6, 2.0),
      );

      spawnZombie(
        left: -160,
        top: 260.0,
        speed: doubleInRange(Random(), 0.6, 2.0),
      );

      spawnZombie(
        left: -160,
        top: 360.0,
        speed: doubleInRange(Random(), 0.6, 2.0),
      );
    });
  }

  spawnZombie({
    required double left,
    required double top,
    required double speed,
  }) {
    zombieList.add(ZombieSprite(
      id: Uuid().v4(),
      left: left,
      top: top,
      speed: speed,
    ));
    update();
  }
}
