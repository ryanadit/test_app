import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:test_app_project/core/misc/app_color.dart';
import 'package:test_app_project/core/module/di/di_init_config.dart';
import 'package:test_app_project/feature/contact/presentation/page/home_page.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // keep screen to potrait
  await Future.wait([
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);
  await configureDependencies();
  runApp(const MyApp());
  await Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() {
    FlutterNativeSplash.remove();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contacts App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary)
      ),
      home: const HomePage(),
    );
  }
}