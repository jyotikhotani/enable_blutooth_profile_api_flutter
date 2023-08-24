import 'package:enable_bluetooh_profile_task/model/profile_model.dart';
import 'package:enable_bluetooh_profile_task/services/api_handler.dart';
import 'package:enable_bluetooh_profile_task/services/response_handling_service.dart';
import 'package:enable_bluetooh_profile_task/utils/constants.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  bool isloading = true;

  String baseUrl = Urls.profileBaseApiUrl;
  ApiHandler? apiHandler;
  ProfileModel? profileModel;
  List<Results> profileList = [];

  Future<OnComplete<ProfileModel>> profileData(
    BuildContext context,
  ) async {
    isloading = true;
    notifyListeners();
    apiHandler = ApiHandler(baseUrl);
    return await apiHandler!.getProfileData().then((value) {
      isloading = false;
      notifyListeners();
      try {
        if (value.isSuccessed) {
          profileList = value.data!.results!;
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
