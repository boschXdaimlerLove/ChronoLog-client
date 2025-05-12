import 'dart:convert';

import 'package:chrono_log/api/api_calls.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:http/http.dart' as http show get, post, put, Response;

/// Communicates with the backend server via API calls
final class ServerCommunication {
  static Future<bool> login(String username, String password) async {
    await http.post(
      Uri.parse(APICalls.getLoginAPICall()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );
    // TODO: handle response
    return true;
  }

  static void startWork() {
    http.post(
      Uri.parse(APICalls.getStartTimeAPICall()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'start': DateTime.now().toIso8601String()}),
    );
  }

  static void endWork() {
    http.post(
      Uri.parse(APICalls.getEndTimeAPICall()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'start': DateTime.now().toIso8601String()}),
    );
  }

  static List<TimeFrame> getTimes() {
    List<TimeFrame> frames = [];
    Future<http.Response> response = http.get(
      Uri.parse(APICalls.getGetTimesAPICall()),
    );
    // TODO: handle http response
    return frames;
  }

  static void sendTimes(final List<TimeFrame> frames) {
    List<String> jsonObjects = [];
    Map<String, dynamic> data = {};
    for (TimeFrame frame in frames) {
      jsonObjects.add(frame.toJSON());
    }
    data['times'] = jsonObjects;
    http.post(
      Uri.parse(APICalls.getSendTimesAPICall()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    // TODO: update
  }

  static void updateTimes(final List<TimeFrame> frames) {
    List<String> jsonObjects = [];
    Map<String, dynamic> data = {};
    for (TimeFrame frame in frames) {
      jsonObjects.add(frame.toJSON());
    }
    data['times'] = jsonObjects;
    http.put(
      Uri.parse(APICalls.getUpdateTimeAPICall()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
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
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
  }
}
