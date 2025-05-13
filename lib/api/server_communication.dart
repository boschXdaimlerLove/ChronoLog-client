import 'dart:convert' show base64, jsonEncode, utf8;

import 'package:chrono_log/api/api_calls.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:http/http.dart' as http show get, post, put, Response;

/// Communicates with the backend server via API calls
final class ServerCommunication {
  static Map<String, String> getHeaders(
    final String username,
    final String password,
  ) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'authorization':
          "Basic ${base64.encode(utf8.encode('$username:$password'))}",
    };
  }

  static bool handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // Ok
        return true;
      case 401:
        // unauthorized
        return false;
      case 404:
        // Not found
        return false;
        // TODO: throw error
        break;
      case 500:
        // Server error
        // TODO: throw error
        return false;
        break;
      default:
        return false;
    }
  }

  static Future<bool> login(
    final String username,
    final String password,
  ) async {
    final http.Response response = await http.post(
      Uri.parse(APICalls.getLoginAPICall()),
      headers: getHeaders(username, password),
    );
    return handleResponse(response);
  }

  static void startWork(final String username, final String password) async {
    final http.Response response = await http.post(
      Uri.parse(APICalls.getStartTimeAPICall()),
      headers: getHeaders(username, password),
      body: jsonEncode({'start': DateTime.now().toIso8601String()}),
    );
    handleResponse(response);
  }

  static void endWork(final String username, final String password) async {
    final http.Response response = await http.post(
      Uri.parse(APICalls.getEndTimeAPICall()),
      headers: getHeaders(username, password),
      body: jsonEncode({'start': DateTime.now().toIso8601String()}),
    );
    handleResponse(response);
  }

  static List<TimeFrame> getTimes(
    final String username,
    final String password,
  ) {
    List<TimeFrame> frames = [];
    Future<http.Response> response = http.get(
      Uri.parse(APICalls.getGetTimesAPICall()),
    );
    // TODO: handle http response
    return frames;
  }

  static void sendTimes(
    final String username,
    final String password,
    final List<TimeFrame> frames,
  ) {
    List<String> jsonObjects = [];
    Map<String, dynamic> data = {};
    for (TimeFrame frame in frames) {
      jsonObjects.add(frame.toJSON());
    }
    data['times'] = jsonObjects;
    http.post(
      Uri.parse(APICalls.getSendTimesAPICall()),
      headers: getHeaders(username, password),
      body: jsonEncode(data),
    );
    // TODO: update
  }

  static void updateTimes(
    final String username,
    final String password,
    final List<TimeFrame> frames,
  ) {
    List<String> jsonObjects = [];
    Map<String, dynamic> data = {};
    for (TimeFrame frame in frames) {
      jsonObjects.add(frame.toJSON());
    }
    data['times'] = jsonObjects;
    http.put(
      Uri.parse(APICalls.getUpdateTimeAPICall()),
      headers: getHeaders(username, password),
      body: jsonEncode(data),
    );
  }

  static void changePassword(
    String username,
    String oldPassword,
    String newPassword,
  ) {
    Map<String, dynamic> data = {
      'username': username,
      'old_password': oldPassword,
      'new_password': newPassword,
    };
    http.put(
      Uri.parse(APICalls.getUpdatePasswordAPICall()),
      headers: getHeaders(username, oldPassword),
      body: jsonEncode(data),
    );
  }
}