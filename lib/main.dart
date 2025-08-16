import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'core/app_router.dart';
import 'data/repositories/booking_repository.dart';
import 'data/repositories/branch_repository.dart';
import 'data/repositories/notification_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NOTE: Firebase optional - app runs without it. See notes in README at end of file.
  // await Firebase.initializeApp();
  runApp(const CoworkApp());
}

class CoworkApp extends StatelessWidget {
  const CoworkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => BranchRepository()),
        RepositoryProvider(create: (_) => BookingRepository()),
        RepositoryProvider(create: (_) => NotificationRepository()),
      ],
      child: MaterialApp(
        title: 'Cowork Booking',
        theme: AppTheme.dark,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.splash,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
