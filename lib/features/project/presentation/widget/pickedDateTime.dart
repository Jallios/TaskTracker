import 'package:flutter/material.dart';

Future<DateTime> pickDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());
    TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedDate == null || pickedTime == null) return DateTime.now();
    return DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
        pickedTime.hour, pickedTime.minute);
  }