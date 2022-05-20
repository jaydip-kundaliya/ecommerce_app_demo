import 'package:ecommerce_app_demo/app.dart';
import 'package:ecommerce_app_demo/services/api_service.dart';
import 'package:ecommerce_app_demo/services/local_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _serviceLocatorSetup();
  await GetIt.I.get<LocalPrefService>().initialPreferences();
  runApp(const EcommerceApp());
}

void _serviceLocatorSetup() {
  final getIt = GetIt.instance;

  final localPrefService = LocalPrefService();
  getIt.registerSingleton<LocalPrefService>(localPrefService);

  final apiService = ApiService();
  getIt.registerSingleton<ApiService>(apiService);
}
