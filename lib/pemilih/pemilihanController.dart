import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemilihanrt/pemilih/pemilihanProvider.dart';

class PemilihController extends GetxController {
  var defaultListData = [];
  var listData = [];
  var isReady = false.obs;
  var isLoading = false.obs;
  TextEditingController pemilih = TextEditingController();
  TextEditingController txtSearch = new TextEditingController();

  @override
  void onInit() {
    getData();
    update();
    super.onInit();
  }

  void refreshData() {
    isReady.value = false;
    isLoading.value = false;
    pemilih.text = '';
    txtSearch.text = '';
    update();
    return getData();
  }

  void filterSearch() {
    if (txtSearch.text.length != 0) {
      var filterList = defaultListData
          .where((string) => string
              .toString()
              .toUpperCase()
              .contains(txtSearch.text.toString().toUpperCase()))
          .toList();

      listData = filterList;

      isLoading.value = false;
    } else {
      listData = defaultListData;
    }
    update();
  }

  getData() {
    try {
      PemilihProvider().getData().then(
        (response) {
          if (response != null) {
            if (response.statusCode == 200) {
              if (response.body != null) {
                if (response.body['data'] != null) {
                  try {
                    listData.clear();
                    listData = jsonDecode(jsonEncode(response.body['data']));
                    defaultListData.clear();
                    defaultListData = listData;
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

  addPemilih() {
    if (pemilih.text.isEmpty) {
      pemilih.text = '';
      Get.defaultDialog(
        title: 'Info',
        middleText: 'Nama wajib di isi',
      );
    } else {
      try {
        PemilihProvider().addPemilih(pemilih.text).then(
          (response) {
            if (response != null) {
              if (response.statusCode == 200) {
                pemilih.text = '';
                Get.defaultDialog(title: 'info', middleText: 'Success..')
                    .then((value) {
                  Get.back();
                  Get.focusScope.unfocus();
                  refreshData();
                });
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

  @override
  void onClose() {
    if (txtSearch != null) {
      txtSearch.text = '';
    }
    if (pemilih != null) {
      pemilih.text = '';
    }
    super.onClose();
  }
}
