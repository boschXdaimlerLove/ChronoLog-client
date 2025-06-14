/// Contains all the API calls done in this app
final class APICalls {
  static const String host =
      'http://localhost:8080/worktime-server-1.0-SNAPSHOT/api';

  static String getUpdateTimeAPICall() {
    return '$host/time/update-times'; // Change times to a later date // Response 200 -> optional
  }

  static String getSendTimesAPICall() {
    return '$host/time/new-times'; // Send new times
  }

  static String getGetTimesAPICall() {
    return '$host/time';
  }

  static String getStartTimeAPICall() {
    return '$host/time/stamp-in';
  }

  static String getEndTimeAPICall() {
    return '$host/time/stamp-out';
  }

  static String getUpdatePasswordAPICall() {
    return '$host/settings/password'; // Update password to new password
  }

  static String getStatusAPICall() {
    return '$host/time/status';
  }
}