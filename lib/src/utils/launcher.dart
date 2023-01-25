import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

bool _isSocialLink(String url) {
  return url.contains("instagram") ||
      url.contains("twitter") ||
      url.contains("youtube");
}

Future launchExternalUrl(String url, BuildContext? context) async {
  if (!url.contains("http") && !url.contains("https")) {
    url = "https://$url";
  }
  if (_isSocialLink(url)) {
    await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );
    return;
  }
}

Future launchFacebookApp(String? pageId, String fallbackUrl) async {
  if (pageId == null) {
    launchExternalUrl(fallbackUrl, null);
    return;
  }
  String fbProtocolUrl;

  ///on Android,
  if (Platform.isAndroid) {
    if (pageId.length < 15) {
      fbProtocolUrl = 'fb://page/$pageId';
    } else if (pageId.length > 15) {
      fbProtocolUrl = 'fb://group/$pageId';
    } else {
      fbProtocolUrl = 'fb://page/$pageId';
    }
  } else {
    fbProtocolUrl = 'fb://profile/$pageId';
  }

  try {
    await launchUrlString(
      fbProtocolUrl,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    launchUrlString(
      fallbackUrl,
      mode: LaunchMode.externalApplication,
    );
  }
}

void launchMap(double lat, double lng) async {
  var url = '';
  if (Platform.isAndroid) {
    url = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
  } else {
    url = 'https://maps.apple.com/?q=$lat,$lng';
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
