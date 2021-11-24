import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:pemilihanrt/doorprize/doorprizeController.dart';

class DoorprizePage extends StatelessWidget {
  final c = Get.lazyPut<DoorprizeController>(() => DoorprizeController());
  @override
  Widget build(BuildContext context) {
    final doorprizeC = Get.find<DoorprizeController>();
    StreamController<int> controller = StreamController<int>();
    return Scaffold(
      backgroundColor: Color(0XFF5C527F),
      body: Center(
        child: SizedBox(
          height: 100,
          width: Get.width,
          child: Container(
            child: GetBuilder<DoorprizeController>(
                initState: doorprizeC.getData(),
                builder: (cont) {
                  if (cont.listData.length == 0) {
                    return Center(
                        child: Text('Pemilih belum ada',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25)));
                  } else {
                    return Row(
                      children: [
                        Expanded(
                          child: FortuneBar(
                              physics: CircularPanPhysics(
                                duration: Duration(seconds: 2),
                                curve: Curves.decelerate,
                              ),
                              onFling: () {
                                Random random = new Random();
                                cont.randomNumber.value = random.nextInt(
                                    int.parse(cont.listData.length.toString()));
                                controller.add(cont.randomNumber.value);
                              },
                              selected: controller.stream,
                              items: [
                                for (var i = 0; i < cont.listData.length; i++)
                                  FortuneItem(
                                      child: FittedBox(
                                          child: Text(
                                              cont.listData[i]['nama']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)))),
                              ]),
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
