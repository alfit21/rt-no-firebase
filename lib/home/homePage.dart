import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihanrt/home/homeController.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  final c = Get.lazyPut<HomeController>(() => HomeController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
      ],
    );
    final homeC = Get.find<HomeController>();

    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          return Get.defaultDialog(
            backgroundColor: Color(0XFFC996CC),
            title: '',
            middleText: 'Anda akan keluar?',
            onConfirm: () {
              SystemNavigator.pop();
            },
            onCancel: () {
              return false;
            },
          ).then((value) => false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0XFFC996CC),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: homeC.currentIndex.value,
            onTap: (i) {
              // if (i == 3) {
              //   Get.to(() => DoorprizePage());
              // } else {
              // }
              homeC.currentIndex.value = i;
            },
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Color(0XFF1E5128),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.view_list_sharp),
                title: Text("Hasil Suara"),
                selectedColor: Colors.purple,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.add),
                title: Text("Tambah Pemilih"),
                selectedColor: Colors.teal,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.star_border_outlined),
                title: Text("Doorprize"),
                selectedColor: Colors.purple,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.recent_actors),
                title: Text("Pemungutan Suara"),
                selectedColor: Colors.pink,
              ),
            ],
          ),
          body: homeC.isReady.value
              ? GetBuilder<HomeController>(
                  initState: homeC.getIndex(),
                  builder: (cotroller) {
                    return homeC.listPage[homeC.currentIndex.value];
                  })
              : Center(
                  child: Lottie.asset(
                    'assets/lottie/loadingText.json',
                  ),
                ),
        ),
      ),
    );
  }
}
