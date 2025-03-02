import 'package:flutter/material.dart';

extension DoubleExtension on double {
  SizedBox get verticalSpace => SizedBox(height: this);
  SizedBox get horizontalSpace => SizedBox(width: this);
  BorderRadius get circular => BorderRadius.circular(this);
  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: this);
}
