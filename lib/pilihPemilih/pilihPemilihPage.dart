import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihanrt/pilihPemilih/pilihPemilihanController.dart';

class PilihPemilihPage extends StatelessWidget {
  final c = Get.lazyPut<PilihPemilihController>(() => PilihPemilihController());
  @override
  Widget build(BuildContext context) {
    final pilihPemilihC = Get.find<PilihPemilihController>();
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0XFF864879),
            onPressed: () {
              pilihPemilihC.refreshData();
            },
            child: Icon(
              Icons.refresh_rounded,
              size: 30,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Container(
          height: 50,
          child: TextField(
              controller: pilihPemilihC.txtSearch,
              onChanged: (filterText) {
                pilihPemilihC.filterSearch();
              },
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                prefixIcon: Icon(Icons.search),
                prefixStyle: TextStyle(color: Colors.white),
                hintText: "Cari Data..",
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 32.0),
                    borderRadius: BorderRadius.circular(0.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue.withOpacity(0.2), width: 32.0),
                    borderRadius: BorderRadius.circular(0.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue.withOpacity(0.2), width: 32.0),
                    borderRadius: BorderRadius.circular(0.0)),
              )),
        ),
      ),
      body: Obx(
        () => pilihPemilihC.isReady.value
            ? RefreshIndicator(
                onRefresh: () async {
                  pilihPemilihC.refreshData();
                },
                backgroundColor: Colors.purple,
                color: Colors.white,
                child: SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: GetBuilder<PilihPemilihController>(
                                      initState: pilihPemilihC.getData(),
                                      builder: (controller) {
                                        return Column(
                                            children:
                                                controller.listData.length == 0
                                                    ? [
                                                        Center(
                                                          child: Text(
                                                            'Data tidak ada',
                                                            style: GoogleFonts
                                                                .architectsDaughter(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                          ),
                                                        )
                                                      ]
                                                    : [
                                                        for (var i = 0;
                                                            i <
                                                                controller
                                                                    .listData
                                                                    .length;
                                                            i++)
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.6),
                                                                    width: 2),
                                                              ),
                                                              color: (i % 2) ==
                                                                      0
                                                                  ? Colors.white
                                                                  : Colors.black
                                                                      .withOpacity(
                                                                          0.1),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Get.defaultDialog(
                                                                        confirmTextColor: Colors.red,
                                                                        backgroundColor: Colors.teal[50],
                                                                        textConfirm: "Iya Benar",
                                                                        onConfirm: () {
                                                                          controller.cekPemilih(
                                                                              controller.listData[i]['id'].toString(),
                                                                              controller.listData[i]['nama'].toString());
                                                                        },
                                                                        buttonColor: Colors.white,
                                                                        middleTextStyle: TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                        title: 'info',
                                                                        middleText: 'Nama pemilih ' + controller.listData[i]['nama'].toString())
                                                                    .then((value) => controller.refreshData());
                                                              },
                                                              splashColor:
                                                                  Colors.indigo,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            10,
                                                                            10,
                                                                            0,
                                                                            10),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <
                                                                            Widget>[
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: <Widget>[
                                                                                        Container(
                                                                                          padding: EdgeInsets.all(10),
                                                                                          child: Text(
                                                                                            'Nama',
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontSize: 20,
                                                                                              fontWeight: FontWeight.bold,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Flexible(
                                                                                          child: Container(
                                                                                            padding: EdgeInsets.all(10),
                                                                                            child: Text(
                                                                                              controller.listData[i]['nama'].toString(),
                                                                                              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                      ]);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: pilihPemilihC.isLoading.value,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: Lottie.asset(
                                      'assets/lottie/loadingText.json')),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Lottie.asset('assets/lottie/loadingText.json')),
                  ],
                ),
              ),
      ),
    );
  }
}
