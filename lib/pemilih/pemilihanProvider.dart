import 'package:get/get.dart';
import 'package:pemilihanrt/utils.dart';

class PemilihProvider extends GetConnect {
  Future<Response> getData() async {
    try {
      final url = Controllers.url + 'pemilih';
      final response = get(
        url,
        headers: {
          "Accept": "application/json",
        },
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response> addPemilih($nama) async {
    try {
      final url = Controllers.url + 'pemilih/tambah/' + $nama;
      final response = get(
        url,
        headers: {
          "Accept": "application/json",
        },
      );

      return response;
    } catch (e) {
      return null;
    }
  }
}
