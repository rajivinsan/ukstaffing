import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sterling/constants/color_constant.dart';
import 'package:sterling/routes/route_generator.dart';
import 'package:sterling/routes/screen_routes.dart';
import 'package:sterling/services/aws_amplify_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwsS3Configuration.configureAmplify();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sterling Staffing',
      debugShowCheckedModeBanner: false,
      initialRoute: ScreenRoute.splashPageRoute,
      onGenerateRoute: RouteGenerator.generateRoutes,
      // onGenerateRoute: RouteGenerator.(settings) => ,        debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: kPrimaryColor),
      // home: const ProfessionalDetailListing(),
    );
  }
}

 // <-- Prints 7.