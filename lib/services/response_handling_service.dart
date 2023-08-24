import 'package:dio/dio.dart';
import 'package:enable_bluetooh_profile_task/utils/connectivity.dart';

class ApiResponse<T> {
  final int? statusCode;
  T? result;
  late bool success;
  late String messsage;
  ApiResponse({
    this.result,
    this.statusCode,
    required this.success,
    required this.messsage,
  });
}

Future<ApiResponse> apiRequest({required Future<dynamic> request}) async {
  try {
    if (isConnected.value) {
      Response response = await request;
      return ApiResponse(
          success: true,
          messsage: (response.data != null && response.data.isNotEmpty)
              ? response.data['message']
              : "",
          result: (response.data != null && response.data.isNotEmpty)
              ? response.data['data']
              : "");
    } else {
      return ApiResponse(
        success: false,
        messsage: 'No internet connection',
      );
    }

    //here we can check the response status and show error message
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 401:
          return ApiResponse(
              statusCode: 401,
              success: false,
              messsage: (e.response!.data)
                  ? e.response!.data['message']
                  : "Something Went Wrong");

        case 400:
          return ApiResponse(
            statusCode: 400,
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );

        case 403:
          return ApiResponse(
            statusCode: 403,
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );
        case 404:
          return ApiResponse(
            statusCode: 404,
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );
        case 422:
          return ApiResponse(
            statusCode: 422,
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );
        case 500:
          return ApiResponse(
              statusCode: 500,
              success: false,
              messsage:
                  "It's a temporary server issue. Please try after sometime! ");

        default:
          return ApiResponse(
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );
      }
    } else {
      return ApiResponse(
        success: false,
        messsage: 'Something went wrong!',
      );
    }
  }
}

Future<ApiResponse> apiProfileRequest(
    {required Future<dynamic> request}) async {
  try {
    if (isConnected.value) {
      Response response = await request;
      return ApiResponse(
          success: true,
          messsage: "",
          result: (response.data != null && response.data.isNotEmpty)
              ? response.data
              : "");
    } else {
      return ApiResponse(
        success: false,
        messsage: 'No internet connection',
      );
    }

    //here we can check the response status and show error message
  } on DioError catch (e) {
    // The request was made and the server responded with a status code
    // that falls out of the range of 2xx and is also not 304.
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 401:
          return ApiResponse(
              statusCode: 401,
              success: false,
              messsage: (e.response!.data)
                  ? e.response!.data['message']
                  : "Something Went Wrong");

        case 400:
          return ApiResponse(
            statusCode: 400,
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );

        case 403:
          return ApiResponse(
            statusCode: 403,
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );
        case 404:
          return ApiResponse(
            statusCode: 404,
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );
        case 422:
          return ApiResponse(
            statusCode: 422,
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );
        case 500:
          return ApiResponse(
              statusCode: 500,
              success: false,
              messsage:
                  "It's a temporary server issue. Please try after sometime! ");

        default:
          return ApiResponse(
            success: false,
            messsage: e.response!.data['message'] ?? "",
          );
      }
    } else {
      return ApiResponse(
        success: false,
        messsage: 'Something went wrong!',
      );
    }
  }
}

class OnComplete<T> {
  T? data;
  bool isUnauthenticated;
  bool isSuccessed;
  String? message;
  int? statusCode;
  OnComplete(
      {this.data,
      required this.isSuccessed,
      this.message,
      this.statusCode,
      this.isUnauthenticated = false});
  factory OnComplete.success(T data, {String? messagee}) {
    return OnComplete(
        data: data,
        isSuccessed: true,
        isUnauthenticated: false,
        message: messagee);
  }
  factory OnComplete.successWithStatusCode(T data, int statusCode) {
    return OnComplete(
        data: data,
        isSuccessed: true,
        isUnauthenticated: false,
        statusCode: statusCode);
  }

  factory OnComplete.error(String message, int statusCode) {
    return OnComplete(
      data: null,
      isSuccessed: false,
      message: message,
      isUnauthenticated: false,
      statusCode: statusCode,
    );
  }
}

enum CurrentState { loading, success, error, initial }

class DataState<T> {
  final T? data;
  final CurrentState state;
  final String? errorMessage;
  bool get isLoading => state == CurrentState.loading;
  bool get isInitail => state == CurrentState.initial;
  bool get isSuccess => state == CurrentState.success;
  bool get isError => state == CurrentState.error;

  DataState({this.data, required this.state, this.errorMessage});

  factory DataState.loading() {
    return DataState(
      state: CurrentState.loading,
      data: null,
    );
  }
  factory DataState.initial() {
    return DataState(state: CurrentState.initial, data: null);
  }
  factory DataState.success({required T data}) {
    return DataState(state: CurrentState.success, data: data);
  }

  factory DataState.error({required String message}) {
    return DataState(
        state: CurrentState.error, data: null, errorMessage: message);
  }
}
