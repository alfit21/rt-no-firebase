import 'package:get/get.dart';
import 'package:pemilihanrt/utils.dart';

class PemungutanSuaraProvider extends GetConnect {
  Future<Response> updateCalonRt(id, poin) async {
    try {
      final url = Controllers.url + 'calonrt/' + id.toString();
      Map<String, String> mRequest = {
        "poin": poin.toString(),
      };
      final response = put(
        url,
        mRequest,
        headers: {
          "Accept": "application/json",
        },
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response> updatePoin(id, totalpoin) async {
    try {
      final url = Controllers.url + 'poin/' + id.toString();
      Map<String, String> mRequest = {
        "totalpoin": totalpoin.toString(),
      };
      final response = put(
        url,
        mRequest,
        headers: {
          "Accept": "application/json",
        },
      );
      print(url);
      print(mRequest);

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

  Future<Response> getDataId(id) async {
    try {
      final url = Controllers.url + 'calonrt/' + id.toString();
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
}
