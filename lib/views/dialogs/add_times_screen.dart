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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add), Text('Add new time'.tr())],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _AddTimeFrameContainer extends StatefulWidget {
  const _AddTimeFrameContainer();

  @override
  State<_AddTimeFrameContainer> createState() => _AddTimeFrameContainerState();
}

final class _AddTimeFrameContainerState extends State<_AddTimeFrameContainer> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100, maxHeight: 100),
            child: Expanded(
              flex: 1,
              child: TextField(
                controller: _controller,
                readOnly: true,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: 100),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  hintText:
                      _controller.text.isNotEmpty
                          ? _controller.text
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
                      _controller.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(picked);
                    });
                  }
                },
              ),
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
                        _controller.text = DateFormat(
                          'HH:mm',
                        ).format(timeAsDateTime);
                      });
                    }
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
                        _controller.text = DateFormat(
                          'HH:mm',
                        ).format(timeAsDateTime);
                      });
                    }
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