import 'package:flutter/material.dart';
import 'package:platform_game/shared/widget/zombie/zombie.dart';
import '../controller/game_level1_controller.dart';

import 'package:get/get.dart';

class GameLevel1View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameLevel1Controller>(
      init: GameLevel1Controller(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 3.4 / 2,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/image/ground.jpg",
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Stack(
                        children: [
                          ...List.generate(controller.zombieList.length,
                              (index) {
                            return controller.zombieList[index];
                          }),
                          Positioned(
                            top: 10.0,
                            right: 10.0,
                            child: InkWell(
                              onTap: () {
                                controller.timer!.cancel();
                                controller.zombieList.clear();
                                controller.startGame();
                                controller.update();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange[700],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(60.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40.0,
                                    right: 40.0,
                                    top: 10.0,
                                    bottom: 10.0,
                                  ),
                                  child: Text(
                                    "Restart",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
