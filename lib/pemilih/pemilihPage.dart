import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihanrt/pemilih/pemilihanController.dart';

class PemilihPage extends StatelessWidget {
  final c = Get.lazyPut<PemilihController>(() => PemilihController());
  @override
  Widget build(BuildContext context) {
    final pemilihController = Get.find<PemilihController>();
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0XFF864879),
            onPressed: () {
              pemilihController.refreshData();
            },
            child: Icon(
              Icons.refresh_rounded,
              size: 30,
            ),
          ),
          FloatingActionButton(
            backgroundColor: Color(0XFF916BBF),
            onPressed: () {
              addPemilih(pemilihController);
            },
            child: Icon(
              Icons.add,
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
              controller: pemilihController.txtSearch,
              onChanged: (filterText) {
                pemilihController.filterSearch();
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
        () => pemilihController.isReady.value
            ? RefreshIndicator(
                onRefresh: () async {
                  pemilihController.refreshData();
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
                                    child: GetBuilder<PemilihController>(
                                      initState: pemilihController.getData(),
                                      builder: (controller) {
                                        return Column(
                                            children: controller
                                                        .listData.length ==
                                                    0
                                                ? [
                                                    Center(
                                                      child: Text(
                                                        'Data tidak ada',
                                                        style: GoogleFonts
                                                            .architectsDaughter(
                                                          fontSize: 20,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    )
                                                  ]
                                                : [
                                                    for (var i = 0;
                                                        i <
                                                            controller.listData
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
                                                          color: (i % 2) == 0
                                                              ? Colors.white
                                                              : Colors.black
                                                                  .withOpacity(
                                                                      0.1),
                                                        ),
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(10, 10,
                                                                  0, 10),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
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
                        visible: pemilihController.isLoading.value,
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

  Future addPemilih(PemilihController pemilihController) {
    return Get.bottomSheet(Container(
        decoration: BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                onTap: () {
                  pemilihController.pemilih.text = '';
                },
                controller: pemilihController.pemilih,
                autofocus: true,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Masukan Nama Pemilih.',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0XFF3E065F),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    pemilihController.addPemilih();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent,
                  ),
                  child: Text('Simpan')),
            )
          ],
        )));
  }
}
