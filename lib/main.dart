import 'package:firebase_core/firebase_core.dart';
import 'package:firstore_curd/app/modules/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/modules/views/splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            home: SplashScreen(),
            initialBinding: HomeBinding(),
          );
        }),
  );
}
