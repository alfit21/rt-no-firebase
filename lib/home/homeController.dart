import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemilihanrt/doorprize/doorprizePage.dart';
import 'package:pemilihanrt/hasilSuara/hasilSuaraShowPasswordPage.dart';
import 'package:pemilihanrt/home/HomeDataPage.dart';
import 'package:pemilihanrt/home/homeProvider.dart';
import 'package:pemilihanrt/pemilih/pemilihPage.dart';
import 'package:pemilihanrt/pemungutanSuara/PemungutanSuaraShowPasswordPage.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var isReady = false.obs;
  var totalPemilihan = 0.obs;
  List<Widget> listPage = [];

  @override
  void onInit() {
    getData();
    currentIndex.value = 0;
    super.onInit();
  }

  void refreshData() {
    isReady.value = false;
    update();
    return getData();
  }

  getIndex() {
    listPage = [
      HomeDataPage(),
      HasilSuaraShowPasswordPage(),
      PemilihPage(),
      DoorprizePage(),
      PemungutanSuaraShowPasswordPage(),
    ];
  }

  getData() {
    try {
      HomeProvider().totalPoint().then(
        (response) {
          if (response != null) {
            if (response.statusCode == 200) {
              if (response.body != null) {
                if (response.body['data'] != null) {
                  try {
                    totalPemilihan.value =
                        int.parse(response.body['data']['totalPemilih']);
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

  @override
  void onClose() {
    super.onClose();
  }
}
