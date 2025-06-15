import 'package:bloc_implementation/bloc_implementation.dart';
import 'package:chrono_log/api/server_communication.dart';
import 'package:chrono_log/blocs/calendar_day_bloc.dart';
import 'package:chrono_log/models/time_frame.dart';
import 'package:chrono_log/storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:string_translate/string_translate.dart' show Translate;

class AddTimesScreen extends StatefulWidget {
  const AddTimesScreen(this.reloadCallback, {super.key});

  final Function() reloadCallback;

  @override
  State<AddTimesScreen> createState() => _AddTimesScreenState();
}

class _AddTimesScreenState extends State<AddTimesScreen> {
  int _itemCount = 0;

  final List<TimeFrame> _frames = [];

  final List<bool> _edited = [];

  CalendarDayBloc? _bloc;

  @override
  void initState() {
    _increaseFrameCount();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (_frames.length != _itemCount) {
      int diff = _itemCount - _frames.length;
      for (int i = 0; i < diff; i++) {
        // Item count is bigger, so add to list
        _addTimeFrame();
      }
      for (int i = 0; i > diff; i--) {
        // [_frames.length] is bigger, so remove from the list
        _frames.removeLast();
      }
    }
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    _bloc ??= BlocParent.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 400, maxWidth: 620),
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
                itemBuilder: (_, counter) {
                  TimeFrame frame = _frames[counter];
                  return _AddTimeFrameContainer(
                    frame: frame,
                    removeCallback: () {
                      _frames.remove(frame);
                      _edited.removeAt(counter);
                      setState(() {
                        _itemCount--;
                      });
                    },
                    removable: counter != 0,
                    editCallback: () => setState(() => _edited[counter] = true),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: GestureDetector(
                onTap: _increaseFrameCount,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.add), Text('Add new time'.tr())],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.indigo.shade50,
                    foregroundColor: Colors.indigo.shade600,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'.tr()),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.indigo.shade50,
                    foregroundColor: Colors.indigo.shade600,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _edited.contains(true) ? _sendTimes : null,
                  child: Text('Submit'.tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _increaseFrameCount() {
    setState(() {
      _itemCount++;
      _addTimeFrame();
    });
  }

  void _addTimeFrame() {
    DateTime now = DateTime.now();
    _frames.add(
      TimeFrame(
        DateTime(now.year, now.month, now.day - 1, 7),
        DateTime(now.year, now.month, now.day - 1, 15),
      ),
    );
    _edited.add(false);
  }

  void _sendTimes() {
    final List<TimeFrame> localTimes = [];
    for (int i = 0; i < _edited.length; i++) {
      if (_edited[i]) {
        localTimes.add(_frames[i]);
      }
    }
    ServerCommunication.sendTimes(_bloc!.username, _bloc!.password, localTimes);
    for (TimeFrame frame in localTimes) {
      Storage.storeNewTime(frame);
    }
    Navigator.of(context).pop();
    widget.reloadCallback();
  }
}

final class _AddTimeFrameContainer extends StatefulWidget {
  const _AddTimeFrameContainer({
    required this.frame,
    required this.removeCallback,
    this.removable = true,
    required this.editCallback,
  });

  final TimeFrame frame;

  final Function() removeCallback;

  final bool removable;

  final Function() editCallback;

  @override
  State<_AddTimeFrameContainer> createState() => _AddTimeFrameContainerState();
}

final class _AddTimeFrameContainerState extends State<_AddTimeFrameContainer> {
  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _startController = TextEditingController();

  final TextEditingController _endController = TextEditingController();

  TimeOfDay _startTime = TimeOfDay(hour: 7, minute: 0);

  TimeOfDay _endTime = TimeOfDay(hour: 15, minute: 0);

  DateTime _date = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day - 1,
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 150,
          maxWidth: size.width,
          minHeight: 100,
        ),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            constraints: BoxConstraints(
                              maxWidth: 425,
                              maxHeight: 75,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText:
                                _dateController.text.isNotEmpty
                                    ? _dateController.text
                                    : 'Choose date'.tr(),
                          ),
                          onTap: () async {
                            final DateTime now = DateTime.now();
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                now.year,
                                now.month - 1,
                                now.day - 1,
                              ),
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
                                _date = picked;
                                widget.frame.start = DateTime(
                                  widget.frame.start.year,
                                  picked.month,
                                  picked.day,
                                  _startTime.hour,
                                  _startTime.minute,
                                );
                                widget.frame.end = DateTime(
                                  widget.frame.start.year,
                                  picked.month,
                                  picked.day,
                                  _endTime.hour,
                                  _endTime.minute,
                                );
                              });
                            }
                            widget.editCallback();
                          },
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 488,
                          maxHeight: 75,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Spacer(),
                            TextField(
                              controller: _startController,
                              decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                  maxHeight: 75,
                                ),
                                hintText: 'Start time'.tr(),
                              ),
                              onTap: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      confirmText: 'Ok'.tr(),
                                      cancelText: 'Cancel'.tr(),
                                      helpText: 'Select time'.tr(),
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                      orientation: Orientation.landscape,
                                    );
                                if (pickedTime != null) {
                                  final timeAsDateTime = DateTime(
                                    _date.year,
                                    _date.month,
                                    _date.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  setState(() {
                                    _startController.text = DateFormat(
                                      'HH:mm',
                                    ).format(timeAsDateTime);
                                  });
                                  _startTime = pickedTime;
                                  widget.frame.start = timeAsDateTime;
                                }
                                widget.editCallback();
                              },
                            ),
                            Spacer(),
                            TextField(
                              controller: _endController,
                              decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxWidth: 200,
                                  maxHeight: 75,
                                ),
                                hintText: 'End time'.tr(),
                              ),
                              onTap: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      confirmText: 'Ok'.tr(),
                                      cancelText: 'Cancel'.tr(),
                                      helpText: 'Select time'.tr(),
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                      orientation: Orientation.landscape,
                                    );
                                if (pickedTime != null) {
                                  final timeAsDateTime = DateTime(
                                    _date.year,
                                    _date.month,
                                    _date.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );
                                  setState(() {
                                    _endController.text = DateFormat(
                                      'HH:mm',
                                    ).format(timeAsDateTime);
                                    _endTime = pickedTime;
                                    widget.frame.end = timeAsDateTime;
                                  });
                                }
                                widget.editCallback();
                              },
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: widget.removable ? widget.removeCallback : null,
                icon: Icon(Icons.remove_circle_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}