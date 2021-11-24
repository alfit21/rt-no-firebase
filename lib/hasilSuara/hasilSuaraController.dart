import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemilihanrt/hasilSuara/HasilSuaraProvider.dart';

class HasilSuaraController extends GetxController {
  TextEditingController psw = TextEditingController();

  var listData = [];
  var totalPemilihan = 0.obs;
  var isReady = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() {
    try {
      HasilSuaraProvider().totalPoint().then(
        (response) {
          if (response != null) {
            if (response.statusCode == 200) {
              if (response.body != null) {
                if (response.body['data'] != null) {
                  try {
                    totalPemilihan.value =
                        int.parse(response.body['data']['totalPemilih']);
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

      HasilSuaraProvider().getData().then(
        (response) {
          if (response != null) {
            if (response.statusCode == 200) {
              if (response.body != null) {
                if (response.body['data'] != null) {
                  try {
                    listData.clear();
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

  @override
  void onClose() {
    if (psw != null) {
      psw.text = '';
    }
    super.onClose();
  }
}
