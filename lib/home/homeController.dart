import 'dart:convert';

import 'package:get/get.dart';
import 'package:pemilihanrt/home/homeProvider.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var isReady = false.obs;
  var listData = [];

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

  getData() {
    try {
      HomeProvider().getData().then(
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
}
