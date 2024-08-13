import 'package:get/get.dart';
import 'package:suhol_van_sales/domain/data_source/remote/login/response/app_icon.dart';
import 'package:suhol_van_sales/domain/data_source/remote/user_details/response/user_details_response.dart';

class SessionService extends GetxService {
  String? _appToken;

  List<AppIcon>? _appIcons;

  List<AppIcon>? get appIcons => _appIcons;

  String? get appToken => _appToken;

  void setAppIcons(List<AppIcon> icons) {
    _appIcons = icons;
  }

  void registerAppToken(String? token) {
    _appToken = token;
  }

  void unregisterAppToken() {
    _appToken = null;
  }

  UserDetailsResponse? _detailsResponse;

  UserDetailsResponse? get userDetails => _detailsResponse;

  void injectUserDetails(UserDetailsResponse? userDetails) {
    _detailsResponse = userDetails;
  }
}
