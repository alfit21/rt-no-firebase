import 'package:get/get.dart';
import 'package:pemilihanrt/utils.dart';

class PilihPemilihProvider extends GetConnect {
  Future<Response> getData() async {
    try {
      final url = Controllers.url + 'pemilih/belomMemilih';
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

  Future<Response> getDataIdPemilih(id) async {
    try {
      final url = Controllers.url + 'pemilih/' + id.toString();
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
