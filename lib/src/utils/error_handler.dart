import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:skadi/skadi.dart';
import 'package:skadi_plus/skadi_plus.dart';

enum SkadiErrorDisplay { dialog, toast }

class SkadiErrorHandler {
  static Future run(
    BuildContext? context,
    FutureOr Function() function, {
    SkadiErrorDisplay display = SkadiErrorDisplay.toast,
  }) async {
    try {
      return await function();
    } catch (ex) {
      final errorMessage = SkadiError.getReadableErrorMessage(ex);

      if (context != null) {
        var errorDisplay = SkadiPlusProvider.of(context)?.errorDisplay;
        if (errorDisplay != null) {
          display = errorDisplay;
        }
      }
      if (display == SkadiErrorDisplay.toast) {
        showToast(
          errorMessage,
          context: context,
        );
      } else if (context != null) {
        showDialog(
          context: context,
          builder: (context) {
            return SkadiSimpleDialog.error(
              content: errorMessage,
              title: "Error",
            );
          },
        );
      }
    }
  }
}
