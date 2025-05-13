/// Contains all the API calls done in this app
final class APICalls {
  static const String HOST = "localhost:8080/chronolog/api";

  static String getLoginAPICall() {
    return "$HOST/login";
  }

  static String getUpdateTimeAPICall() {
    return "$HOST/update_times";
  }

  static String getSendTimesAPICall() {
    return "$HOST/new_times";
  }

  static String getGetTimesAPICall() {
    return "$HOST/get_times";
  }

  static String getStartTimeAPICall() {
    return "$HOST/start";
  }

  static String getEndTimeAPICall() {
    return "$HOST/end";
  }

  static String getUpdatePasswordAPICall() {
    return "$HOST/update_settings";
  }
}
