import 'package:flutter/services.dart';

TextInputFormatter decimalFormatter([int decimal = 2]) {
  return FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,' '$decimal}'));
}
