import 'dart:convert' show base64, jsonDecode, jsonEncode, utf8;
import 'dart:io';

import 'package:chrono_log/api/api_calls.dart';
import 'package:chrono_log/api/internal_server_error.dart';
import 'package:chrono_log/errors/server_not_found_error.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:http/http.dart' as http show get, post, put, Response;
import 'package:path_provider/path_provider.dart';

/// Communicates with the backend server via API calls
final class ServerCommunication {
  static Map<String, String> getHeaders(
    final String username,
    final String password,
  ) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':
          "Basic ${base64.encode(utf8.encode('$username:$password'))}",
    };
  }

  static bool handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        // Ok
        return true;
      case 400:
        // Bad request => already checked in or out
        // TODO: throw error for bad request
        return false;
      case 401:
        // unauthorized
        return false;
      case 404:
        // Not found
        throw ServerNotFoundError();
      case 500:
        // Server error
        throw InternalServerError();
      default:
        return false;
    }
  }

  static void startWork(final String username, final String password) async {
    final http.Response response = await http.post(
      Uri.parse(APICalls.getStartTimeAPICall()),
      headers: getHeaders(username, password),
    );
    // TODO: handle stamp in time
    handleResponse(response);
  }

  static void endWork(final String username, final String password) async {
    final http.Response response = await http.post(
      Uri.parse(APICalls.getEndTimeAPICall()),
      headers: getHeaders(username, password),
    );
    // TODO: handle stamp out time
    handleResponse(response);
  }

  static Future<List<TimeFrame>> getTimes(
    final String username,
    final String password,
  ) async {
    Directory directory = await getApplicationSupportDirectory();
    File file = File('${directory.path}/http-response.txt');
    List<TimeFrame> frames = [];
    http.Response response = await http.get(
      Uri.parse(APICalls.getGetTimesAPICall()),
      headers: getHeaders(username, password),
    );
    file.writeAsString('''
    http-response:
    status-code: ${response.statusCode},
    headers: ${response.headers},
    body: ${response.body}
    
    request:
    headers: ${response.request?.headers ?? 'no request'}
    ''');
    if (handleResponse(response)) {
      List<dynamic> jsonMap = jsonDecode(response.body);
      for (Map<String, dynamic> jsonFrame in jsonMap) {
        frames.add(TimeFrame.fromJSON(jsonFrame));
      }
    }
    return frames;
  }

  static void sendTimes(
    final String username,
    final String password,
    final List<TimeFrame> frames,
  ) {
    List<Map<String, dynamic>> data = [];
    for (TimeFrame frame in frames) {
      data.add(frame.toJSON());
    }
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
    List<Map<String, dynamic>> jsonObjects = [];
    for (TimeFrame frame in frames) {
      jsonObjects.add(frame.toJSON());
    }
    http.put(
      Uri.parse(APICalls.getUpdateTimeAPICall()),
      headers: getHeaders(username, password),
      body: jsonEncode(jsonObjects),
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

  static void getStatus() {
    // TODO: implement method
  }
}