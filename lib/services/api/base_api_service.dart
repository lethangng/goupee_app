import '../../configs/configs.dart';

abstract class BaseApiService {
  final String baseUrl = Configs.baseUrl;

  Future<dynamic> getResponse(String url);

  Future<dynamic> postResponse({
    required String url,
    required Object jsonBody,
  });
}
