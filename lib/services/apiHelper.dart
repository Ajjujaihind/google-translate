import 'package:dio/dio.dart';

import '../model/myModel.dart';

class ApiHelper {
  final Dio _dio = Dio();

  ApiHelper() {
    // Set up the base URL and headers in the constructor.
    _dio.options.baseUrl =
        'https://google-translate1.p.rapidapi.com/language/translate/v2';
    _dio.options.headers = {
      'X-Rapidapi-Key': 'ab713b37d1msh5721b15dd6e37a0p16cec3jsn93b1f88cb9c9',
      'X-Rapidapi-Host': 'google-translate1.p.rapidapi.com',
      'Accept-Encoding': 'application/gzip',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
  }

  Future<MyModel> translateText(
      String source, String target, String textToTranslate) async {
    final body = {
      'q': textToTranslate,
      'target': target,
      'source': source,
    };

    try {
      final response = await _dio.post('', data: body);

      if (response.statusCode == 200) {
        print('Response Body : ${response.data}');
        final data = response.data;
        return MyModel.fromJson(data);
      } else {
        throw Exception('Failed to translate text');
      }
    } catch (e) {
      throw Exception('Failed to make the API call: $e');
    }
  }
}
