import 'package:enable_bluetooh_profile_task/model/image_model.dart';
import 'package:enable_bluetooh_profile_task/model/profile_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:enable_bluetooh_profile_task/utils/constants.dart';
import 'response_handling_service.dart';

class ApiHandler {
  Dio? _dio;
  String deviceId = '';
  String deviceType = '';
  String deviceUniqueId = '';
  ApiHandler(String baseApiUrl) {
    BaseOptions options = BaseOptions(
      baseUrl: baseApiUrl,
      receiveTimeout: const Duration(milliseconds: 300000),
      connectTimeout: const Duration(milliseconds: 300000),
    );
    _dio = Dio(options);
    _dio!.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<OnComplete<String>> getRandomImages() async {
    ApiResponse apiResponse = await apiRequest(
        request: _dio!.get(
      Urls.images,
      options: Options(),
    ));
    if (apiResponse.success) {
      return OnComplete.success(apiResponse.messsage);
    } else {
      return OnComplete.error(StringConst.somethingWentWrong, 0);
    }
  }

  Future<OnComplete<ProfileModel>> getProfileData() async {
    ApiResponse apiResponse = await apiProfileRequest(
        request: _dio!.get(
      Urls.profile,
      options: Options(),
    ));
    if (apiResponse.success) {
      return OnComplete.success(ProfileModel.fromJson(apiResponse.result));
    } else {
      return OnComplete.error(StringConst.somethingWentWrong, 0);
    }
  }
}
