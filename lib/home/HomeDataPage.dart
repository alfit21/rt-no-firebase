import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihanrt/home/homeController.dart';

class HomeDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0XFF916BBF),
        onPressed: () {
          homeC.refreshData();
        },
        child: Icon(
          Icons.refresh_rounded,
          size: 30,
        ),
      ),
      backgroundColor: Color(0XFFC996CC),
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: FittedBox(
                    child: Text(
                      'Selamat datang disistem pemilihan rt 6/8 Jatijajar - Tapos - Depok',
                      style: GoogleFonts.arvo(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.7,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Card(
                        color: Color(0XFFF0E3E3),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: double.infinity,
                                width: double.infinity,
                                child: Lottie.asset(
                                  'assets/lottie/kumpulanorangngobrol.json',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GetBuilder<HomeController>(
                                        initState: homeC.getData(),
                                        builder: (controller) {
                                          return Text(
                                            controller.totalPemilihan
                                                .toString(),
                                            style: GoogleFonts.arvo(
                                                textStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 80,
                                                    color: Color(0XFF3F3351))),
                                          );
                                        }),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Total Suara Pemilih',
                                      style: GoogleFonts.arvo(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: Color(0XFF3F3351))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
