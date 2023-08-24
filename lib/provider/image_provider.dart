import 'package:enable_bluetooh_profile_task/services/api_handler.dart';
import 'package:enable_bluetooh_profile_task/services/response_handling_service.dart';
import 'package:enable_bluetooh_profile_task/utils/constants.dart';
import 'package:flutter/material.dart';

class RandomImagePovider with ChangeNotifier {
  ApiHandler? apiHandler;

  bool isloading = true;
  String imageUrl = "";
  String baseUrl = Urls.imageBaseApiUrl;
  Future<OnComplete<String>> imageData(
    BuildContext context,
  ) async {
    isloading = true;
    notifyListeners();
    apiHandler = ApiHandler(baseUrl);
    return await apiHandler!.getRandomImages().then((value) {
      isloading = false;
      notifyListeners();
      try {
        if (value.isSuccessed) {
          imageUrl = value.data!;
          notifyListeners();
        } else {}
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(StringConst.somethingWentWrong)));
      }
      return value;
    });
  }
}
