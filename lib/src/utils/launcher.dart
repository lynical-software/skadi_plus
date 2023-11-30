import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

Future launchExternalUrl(String url) async {
  if (!url.contains("http") && !url.contains("https")) {
    url = "https://$url";
  }
  await launchUrlString(
    url,
    mode: LaunchMode.externalApplication,
  );
}

Future launchFacebookApp(String? pageId, String fallbackUrl,
    {String? type}) async {
  if (pageId == null) {
    launchExternalUrl(fallbackUrl);
    return;
  }
  String fbProtocolUrl;

  ///on Android,
  if (Platform.isAndroid) {
    if (type != null) {
      fbProtocolUrl = 'fb://$type/$pageId';
    } else {
      fbProtocolUrl = 'fb://page/$pageId';
    }
  } else {
    fbProtocolUrl = 'fb://profile/$pageId';
  }

  try {
    bool result = await launchUrlString(
      fbProtocolUrl,
      mode: LaunchMode.externalApplication,
    );
    if (!result) {
      throw "Unable to launch Facebook app";
    }
  } catch (e) {
    launchUrlString(
      fallbackUrl,
      mode: LaunchMode.externalApplication,
    );
  }
}

void launchMap(double lat, double lng, {bool adaptive = true}) async {
  var url = '';
  if (Platform.isIOS && adaptive) {
    url = 'https://maps.apple.com/?q=$lat,$lng';
  } else {
    url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
  }
  await launchUrlString(
    url,
    mode: LaunchMode.externalApplication,
  );
}

void launchPhoneCall(String phoneNumber) async {
  String number = phoneNumber.replaceAll(" ", "");
  await launchUrlString(
    "tel:$number",
    mode: LaunchMode.externalApplication,
  );
}

void launchMail(String email) async {
  await launchUrlString(
    "mailto:$email",
    mode: LaunchMode.externalApplication,
  );
}
