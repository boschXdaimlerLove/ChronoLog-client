import 'package:chrono_log/api/server_communication.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:string_translate/string_translate.dart';

class AddTimesScreen extends StatefulWidget {
  const AddTimesScreen({super.key});

  @override
  State<AddTimesScreen> createState() => _AddTimesScreenState();
}

class _AddTimesScreenState extends State<AddTimesScreen> {
  int _itemCount = 1;

  final List<TimeFrame> _frames = [];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 600),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: _itemCount,
                itemBuilder: (_, __) {
                  return _AddTimeFrameContainer();
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() => _itemCount++);
              },
              child: Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.add), Text('Add new time'.tr())],
                ),
              ),
            ),
            TextButton(onPressed: _sendTimes, child: Text('Submit'.tr())),
          ],
        ),
      ),
    );
  }

  void _sendTimes() {
    ServerCommunication.sendTimes('username', 'password', _frames);
  }
}

final class _AddTimeFrameContainer extends StatefulWidget {
  const _AddTimeFrameContainer();

  @override
  State<_AddTimeFrameContainer> createState() => _AddTimeFrameContainerState();
}

final class _AddTimeFrameContainerState extends State<_AddTimeFrameContainer> {
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _startController = TextEditingController();

  final TextEditingController _endController = TextEditingController();

  TimeOfDay? _startTime;

  TimeOfDay? _endTime;

  TimeFrame _frame = TimeFrame(DateTime.now(), DateTime.now());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                constraints: BoxConstraints(maxWidth: 100),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText:
                    _dateController.text.isNotEmpty
                        ? _dateController.text
                        : 'Choose date'.tr(),
              ),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 1)),
                  lastDate: DateTime.now(),
                  cancelText: 'Cancel'.tr(),
                  confirmText: 'Ok'.tr(),
                  currentDate: DateTime.now(),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialDatePickerMode: DatePickerMode.day,
                );
                if (picked != null) {
                  setState(() {
                    _dateController.text = DateFormat(
                      'yyyy-MM-dd',
                    ).format(picked);
                  });
                }
                // TODO: respect already entered times
                _frame = TimeFrame(picked!, picked);
              },
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100),
            child: Row(
              children: [
                TextField(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      confirmText: 'Ok'.tr(),
                      cancelText: 'Cancel'.tr(),
                      helpText: 'Select time'.tr(), // Optional
                    );

                    if (pickedTime != null) {
                      final now = DateTime.now();
                      final timeAsDateTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      setState(() {
                        _startController.text = DateFormat(
                          'HH:mm',
                        ).format(timeAsDateTime);
                      });
                    }
                    _startTime = pickedTime;
                    // TODO: update frame
                  },
                ),
                TextField(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      confirmText: 'Ok'.tr(),
                      cancelText: 'Cancel'.tr(),
                      helpText: 'Select time'.tr(), // Optional
                    );

                    if (pickedTime != null) {
                      final now = DateTime.now();
                      final timeAsDateTime = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      setState(() {
                        _endController.text = DateFormat(
                          'HH:mm',
                        ).format(timeAsDateTime);
                      });
                    }
                    _endTime = pickedTime;
                    // TODO: update frame
                  },
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}