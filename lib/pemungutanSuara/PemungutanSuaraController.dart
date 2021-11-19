import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihanrt/pemungutanSuara/PemungutanSuaraProvider.dart';
import 'package:pemilihanrt/pemungutanSuara/PemungutanSuaraShowPasswordPage.dart';

class PemungutanSuaraController extends GetxController {
  TextEditingController psw = TextEditingController();

  var listData = [];
  var isReady = false.obs;
  var listPoin = [];
  var totalSuara = 0.obs;
  var totalPoin = 0.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() {
    try {
      PemungutanSuaraProvider().getData().then(
        (response) {
          if (response != null) {
            if (response.statusCode == 200) {
              if (response.body != null) {
                if (response.body['data'] != null) {
                  try {
                    listData = jsonDecode(jsonEncode(response.body['data']));
                    isReady.value = true;
                    update();
                  } catch (e) {
                    Get.defaultDialog(
                        title: 'info', middleText: 'error encode');
                  }
                } else {
                  Get.defaultDialog(title: 'info', middleText: 'data null');
                }
              } else {
                Get.defaultDialog(title: 'info', middleText: 'body null');
              }
            } else {
              Get.defaultDialog(
                  title: 'info',
                  middleText: 'response ' + response.statusCode.toString());
            }
          } else {
            Get.defaultDialog(title: 'info', middleText: 'response null ');
          }
        },
      );
    } catch (e) {
      Get.defaultDialog(title: 'info', middleText: 'erro get api');
    }
    update();
  }

  kirimData(id) {
    try {
      // ambil nilai akhir total poin
      PemungutanSuaraProvider().getPoin().then(
        (response) {
          if (response != null) {
            if (response.statusCode == 200) {
              if (response.body != null) {
                if (response.body['data'] != null) {
                  try {
                    listPoin = jsonDecode(jsonEncode(response.body['data']));
                    totalSuara.value = int.parse(listPoin[0]['totalpoin']) + 1;

// ambil nilai akhir point calon rt
                    PemungutanSuaraProvider().getDataId(id).then(
                      (response) {
                        if (response != null) {
                          if (response.statusCode == 200) {
                            if (response.body != null) {
                              if (response.body['data'] != null) {
                                try {
                                  totalPoin.value = int.parse(jsonDecode(
                                              jsonEncode(
                                                  response.body['data']))[0]
                                          ['poin']) +
                                      1;
// edit poin calon rt
                                  prosesEditCalonRt(jsonDecode(
                                          jsonEncode(response.body['data']))[0]
                                      ['id']);

                                  // edit total poin
                                  prosesEditPoin(listPoin[0]['id']);

                                  successMemilih();
                                } catch (e) {
                                  Get.defaultDialog(
                                      title: 'info',
                                      middleText: 'error encode');
                                }
                              } else {
                                Get.defaultDialog(
                                    title: 'info', middleText: 'data null');
                              }
                            } else {
                              Get.defaultDialog(
                                  title: 'info', middleText: 'body null');
                            }
                          } else {
                            Get.defaultDialog(
                                title: 'info',
                                middleText: 'response ' +
                                    response.statusCode.toString());
                          }
                        } else {
                          Get.defaultDialog(
                              title: 'info', middleText: 'response null ');
                        }
                      },
                    );
                  } catch (e) {
                    Get.defaultDialog(
                        title: 'info', middleText: 'error encode');
                  }
                } else {
                  Get.defaultDialog(title: 'info', middleText: 'data null');
                }
              } else {
                Get.defaultDialog(title: 'info', middleText: 'body null');
              }
            } else {
              Get.defaultDialog(
                  title: 'info',
                  middleText: 'response ' + response.statusCode.toString());
            }
          } else {
            Get.defaultDialog(title: 'info', middleText: 'response null ');
          }
        },
      );
    } catch (e) {
      Get.defaultDialog(title: 'info', middleText: 'erro get api');
    }
  }

  prosesEditCalonRt(id) {
    PemungutanSuaraProvider().updateCalonRt(id, totalPoin).then(
      (response) {
        if (response != null) {
          if (response.statusCode == 200) {
          } else {
            Get.defaultDialog(
                title: 'info',
                middleText: 'response ' + response.statusCode.toString());
          }
        } else {
          Get.defaultDialog(title: 'info', middleText: 'response null ');
        }
      },
    );
  }

  prosesEditPoin(id) {
    PemungutanSuaraProvider().updatePoin(id, totalSuara.value).then(
      (response) {
        if (response != null) {
          if (response.statusCode == 200) {
          } else {
            Get.defaultDialog(
                title: 'info',
                middleText: 'response ' + response.statusCode.toString());
          }
        } else {
          Get.defaultDialog(title: 'info', middleText: 'response null ');
        }
      },
    );
  }

  successMemilih() {
    Get.defaultDialog(
      backgroundColor: Colors.teal,
      title: '',
      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      buttonColor: Colors.white,
      content: Container(
        height: Get.height * 0.5,
        width: Get.width,
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                child: Text(
                  'Terimakasih, anda telah memilih'.toString(),
                  style: GoogleFonts.josefinSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white)),
                ),
              ),
            ),
            Lottie.asset('assets/lottie/jempolLike.json'),
          ],
        ),
      ),
    ).then((_) {
      Get.to(() => PemungutanSuaraShowPasswordPage());
    });
  }

  @override
  void onClose() {
    psw.dispose();
    super.onClose();
  }
}
