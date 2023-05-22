import 'package:deeplinking/navigation/mobile_app_root.dart';
import 'package:deeplinking/url_strategy.dart';
import 'package:flutter/material.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MobileAppRoot());
}
