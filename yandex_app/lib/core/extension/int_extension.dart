import 'package:flutter/material.dart';

extension IntExtension on int {
  SizedBox get verticalSpace => SizedBox(height: toDouble());
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}
