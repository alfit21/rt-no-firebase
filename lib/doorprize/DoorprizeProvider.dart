import 'package:get/get.dart';
import 'package:pemilihanrt/utils.dart';

class DoorprizeProvider extends GetConnect {
  Future<Response> getData() async {
    try {
      final url = Controllers.url + 'pemilih/doorprize';
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
