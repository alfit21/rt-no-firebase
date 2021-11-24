import 'dart:convert';
import 'package:get/get.dart';
import 'package:pemilihanrt/doorprize/DoorprizeProvider.dart';

class DoorprizeController extends GetxController {
  var listData = [];
  var isReady = false.obs;
  var randomNumber = 0.obs;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  getData() {
    try {
      DoorprizeProvider().getData().then(
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
    super.onClose();
  }
}
