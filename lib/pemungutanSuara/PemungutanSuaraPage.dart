import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pemilihanrt/pemungutanSuara/PemungutanSuaraController.dart';

class PemungutanSuaraPage extends StatelessWidget {
  final c =
      Get.lazyPut<PemungutanSuaraController>(() => PemungutanSuaraController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
      ],
    );
    final pemungutanSuaraC = Get.find<PemungutanSuaraController>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0XFF5C5470),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      'Untuk memilih silakan sentuh gambar atau nama',
                      style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white)),
                    ),
                  ),
                ),
                GetBuilder<PemungutanSuaraController>(
                    init: pemungutanSuaraC.getData(),
                    builder: (controller) {
                      if (controller.listData.length == 0) {
                        return Container();
                      } else {
                        return SizedBox(
                          height: Get.height * 0.7,
                          width: Get.width * 0.9,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.listData.length,
                            itemBuilder: (context, index) {
                              var data = controller.listData[index];
                              return TextButton(
                                onPressed: () {
                                  pemungutanSuaraC.kirimData(data['id']);
                                },
                                child: SizedBox(
                                  width: 215,
                                  child: Card(
                                      color: Color(0xffBDB8E3),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            ClipOval(
                                              child: Image.network(
                                                data['urlgambar'].toString(),
                                                height: 180,
                                                width: 180,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Expanded(
                                              child: FittedBox(
                                                child: Text(
                                                  data['nama'].toString(),
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
