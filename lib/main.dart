import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider_stub/providers/primary_provider.dart';
import 'package:provider_stub/res/app_theme.dart';
import 'package:provider_stub/utils/router.dart';
import 'package:provider_stub/utils/shared_prefs.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize shared preferences
  await SharedPreferenceHelper.init();
  // Load environment variables from .env file
  await dotenv.load(fileName: ".env");
  // Start the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root widget of the application
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Primary provider for managing user state
        ChangeNotifierProvider(
          create: (_) => PrimaryProvider()..loadUserState(),
        ),
      ],
      child: Consumer<PrimaryProvider>(
        builder: (context, primaryProvider, child) {
          return MaterialApp(
            // Disable the debug banner
            debugShowCheckedModeBanner: false,
            // Apply the app theme
            theme: AppTheme.theme,
            // Use the global navigator key
            navigatorKey: navigatorKey,
            // Generate routes based on the route settings
            onGenerateRoute: generateRoute,
          );
        },
      ),
    );
  }
}
