import 'package:barcode_mapping/global/themes/themes.dart';
import 'package:barcode_mapping/old/pages/login/user_login_page.dart';
import 'package:barcode_mapping/old/providers/dispatch_management/gln_provider.dart';
import 'package:barcode_mapping/old/providers/login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// laka da maar
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GlnProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(context.screenWidth, context.screenHeight),
        builder: (context, child) => GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Barcode Mapping',
            theme: Themes.lightTheme(),
            home: const UserLoginPage(),
          ),
        ),
      ),
    );
  }
}
