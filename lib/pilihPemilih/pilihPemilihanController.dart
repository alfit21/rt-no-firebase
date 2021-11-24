import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pemilihanrt/pemungutanSuara/PemungutanSuaraPage.dart';
import 'package:pemilihanrt/pilihPemilih/pilihPemilihanProvider.dart';

class PilihPemilihController extends GetxController {
  var defaultListData = [];
  var listData = [];
  var listPemilih = [];
  var isReady = false.obs;
  var isLoading = false.obs;
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
      PilihPemilihProvider().getData().then(
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

  cekPemilih(id, nama) {
    try {
      // ambil data pemilih, apakan dia udah memilih
      PilihPemilihProvider().getDataIdPemilih(id.toString()).then(
        (response) {
          if (response != null) {
            if (response.statusCode == 200) {
              if (response.body != null) {
                if (response.body['data'] != null) {
                  try {
                    listPemilih.clear();
                    listPemilih = jsonDecode(jsonEncode(response.body['data']));
                    // jika belom
                    if (listPemilih[0]['pilih'] == '0') {
                      Get.to(() => PemungutanSuaraPage(),
                          arguments: id.toString());
                    } else {
                      Get.back();
                      Get.defaultDialog(
                              backgroundColor: Colors.blueAccent,
                              title: 'info',
                              middleTextStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              middleText: '$nama telah memilih')
                          .then((value) => refreshData());
                    }
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

  @override
  void onClose() {
    if (txtSearch != null) {
      txtSearch.text = '';
    }
    super.onClose();
  }
}
