import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:my_project/middleware/auth_middleware.dart';
import 'package:my_project/routes/app_routes.dart';
import 'package:my_project/services/bindings/auth_binding.dart';
import 'package:my_project/services/bindings/blog_binding.dart';
import 'package:my_project/services/bindings/firebase_message_binding.dart';
import 'package:my_project/services/bindings/profile_binding.dart';
import 'package:my_project/src/views/screens/authscreens/sign_in_screen.dart';
import 'package:my_project/src/views/screens/authscreens/sign_up_screen.dart';
import 'package:my_project/src/views/screens/authscreens/verify_otp_screen.dart';
import 'package:my_project/src/views/screens/create_blog_screen.dart';
import 'package:my_project/src/views/screens/splash_screen.dart';
import 'package:my_project/src/views/widgets/layout/tab_layout.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
        GetPage(
          name: AppRoutes.signIn,
          page: () => const SignInScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: AppRoutes.signUp,
          page: () => const SignUpScreen(),
          middlewares: [AuthMiddleware()],
        ),

        GetPage(name: AppRoutes.home,
            page: () => const TabLayout()
            ,
            bindings: [
              BlogBinding(),
              ProfileBinding(),
              FirebaseMessageBinding()
            ]
        ),
        GetPage(name: AppRoutes.otp, page: () => const VerifyOtpScreen()),
        GetPage(
            name: AppRoutes.createBlog, page: () => const CreateBlogScreen())
      ],
    );
  }
}
