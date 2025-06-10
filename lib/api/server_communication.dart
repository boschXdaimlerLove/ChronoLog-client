import 'dart:async' show Timer;
import 'dart:convert' show base64, jsonDecode, jsonEncode, utf8;

import 'package:chrono_log/api/api_calls.dart';
import 'package:chrono_log/api/internal_server_error.dart';
import 'package:chrono_log/blocs/event_bloc.dart';
import 'package:chrono_log/errors/server_not_found_error.dart';
import 'package:chrono_log/errors/wrong_login_error.dart';
import 'package:chrono_log/main.dart';
import 'package:chrono_log/models/events/notification_triggered_event.dart';
import 'package:chrono_log/models/notification.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http show get, patch, post, put, Response;
import 'package:string_translate/string_translate.dart' show Translate;

/// Communicates with the backend server via API calls
final class ServerCommunication {
  static void initStatusPolling(final String username, final String password) {
    if (isMobile) {
      return;
    }
    Timer.periodic(Duration(minutes: 1), (_) async {
      http.Response response = await getStatus(username, password);
      String? title;
      String? message;
      switch (response.body) {
        case '1':
          title = 'Working too long'.tr();
          message =
              'You\'ve worked too long for today. End work and go home'.tr();
          flutterLocalNotificationsPlugin.show(
            UniqueKey().hashCode,
            title,
            message,
            NotificationDetails(),
          );
          break;
        case '2':
          title = 'Break needed'.tr();
          message =
              'You\'ve worked to long without a break, consider taking a break'
                  .tr();
          flutterLocalNotificationsPlugin.show(
            UniqueKey().hashCode,
            title,
            message,
            NotificationDetails(),
          );
          break;
        case '3':
          title = 'Holiday'.tr();
          message = 'Today\'s a holiday, you shouldn\'t work today'.tr();
          flutterLocalNotificationsPlugin.show(
            UniqueKey().hashCode,
            title,
            message,
            NotificationDetails(),
          );
        case '4':
          // After working time
          // Not allowed to work
          break;
        case '5':
          title = 'Not logged in'.tr();
          message =
              'You\'re not logged in, please log in before trying to start work'
                  .tr();
          flutterLocalNotificationsPlugin.show(
            UniqueKey().hashCode,
            title,
            message,
            NotificationDetails(),
          );
          break;
        default:
          // Do nothing
          break;
      }
      if (title != null && message != null) {
        final Notification notification = Notification(title, message);
        EventBloc.eventStream.sink.add(
          NotificationTriggeredEvent(notification),
        );
      }
    });
  }

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

  static Future<DateTime> startWork(
    final String username,
    final String password,
  ) async {
    final http.Response response = await http.post(
      Uri.parse(APICalls.getStartTimeAPICall()),
      headers: getHeaders(username, password),
    );
    // TODO: handle stamp in time
    handleResponse(response);
    return DateTime.parse(response.body);
  }

  static Future<DateTime> endWork(
    final String username,
    final String password,
  ) async {
    final http.Response response = await http.post(
      Uri.parse(APICalls.getEndTimeAPICall()),
      headers: getHeaders(username, password),
    );
    // TODO: handle stamp out time
    handleResponse(response);
    return DateTime.parse(response.body);
  }

  static Future<List<TimeFrame>> getTimes(
    final String username,
    final String password,
  ) async {
    List<TimeFrame> frames = [];
    http.Response response = await http.get(
      Uri.parse(APICalls.getGetTimesAPICall()),
      headers: getHeaders(username, password),
    );
    if (handleResponse(response)) {
      List<dynamic> jsonMap = jsonDecode(response.body);
      for (Map<String, dynamic> jsonFrame in jsonMap) {
        frames.add(TimeFrame.fromJSON(jsonFrame));
      }
    } else {
      throw WrongLoginError();
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
  ) async {
    Map<String, dynamic> data = {
      'old_password': oldPassword,
      'new_password': newPassword,
    };
    http.Response response = await http.patch(
      Uri.parse(APICalls.getUpdatePasswordAPICall()),
      headers: getHeaders(username, oldPassword),
      body: jsonEncode(data),
    );
    // TODO: response: 200 -> good, 401 -> old password incorrect
  }

  static Future<http.Response> getStatus(
    final String username,
    final String password,
  ) async {
    http.Response response = await http.get(
      Uri.parse(APICalls.getStatusAPICall()),
      headers: getHeaders(username, password),
    );
    return response;
  }
}