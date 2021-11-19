import 'package:get/get.dart';
import 'package:pemilihanrt/utils.dart';

class HasilSuaraProvider extends GetConnect {
  Future<Response> getPoin() async {
    try {
      final url = Controllers.url + 'poin';
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

  Future<Response> getData() async {
    try {
      final url = Controllers.url + 'calonrt';
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
