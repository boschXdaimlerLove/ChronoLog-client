import 'package:hive_ce/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 1)
final class Notification {
  @HiveField(0)
  final String _title;

  String get title => _title;

  @HiveField(1)
  final String _message;

  String get message => _message;

  bool _read = false;

  bool get alreadyRead => _read;

  Notification(this._title, this._message, {bool read = false}) {
    _read = read;
  }

  void read() {
    _read = true;
  }
}