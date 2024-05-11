import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class AppContact {
  late final Contact info;
  final Color color;

  AppContact({
    required this.info,
    required this.color, required key,
  });
}
