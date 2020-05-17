import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skillbox_test/api/api_client.dart';
import 'package:skillbox_test/services/service_locator.dart';
import 'package:skillbox_test/skillboxTestApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  service.registerSingleton<ApiClient>(ApiClient((HttpClient())));

  runApp(SkillboxTestApp(routeObserver));
}
