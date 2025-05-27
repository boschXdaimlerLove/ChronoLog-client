/// Contains all the API calls done in this app
final class APICalls {
  static const String host = 'http://localhost:8080/chronolog/api';

  static String getUpdateTimeAPICall() {
    return '$host/times/update-times'; // Change times to a later date // Response 200 -> optional
  }

  static String getSendTimesAPICall() {
    return '$host/times/new-times'; // Send new times
  }

  static String getGetTimesAPICall() {
    return '$host/times';
  }

  static String getStartTimeAPICall() {
    return '$host/times/stamp-in';
  }

  static String getEndTimeAPICall() {
    return '$host/times/stamp-out';
  }

  static String getUpdatePasswordAPICall() {
    return '$host/settings/update-password'; // Update password to new password
  }

  static String getStatusAPICall() {
    return '$host/times/status';
  }
}