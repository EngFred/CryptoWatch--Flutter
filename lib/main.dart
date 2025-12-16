import 'package:flutter/material.dart';
import 'package:flutter_cryptowatch/ui/nav/router.dart';
import 'package:workmanager/workmanager.dart';
import 'di/injection.dart';
import 'data/worker/background_worker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize DI for the UI Thread
  await configureDependencies();

  // 2. Initialize WorkManager with our Isolate Entry Point
  await Workmanager().initialize(callbackDispatcher);

  // 3. Register the Periodic Task
  await Workmanager().registerPeriodicTask(
    syncUniqueName,
    syncTaskName,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
      requiresBatteryNotLow: true,
    ),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
    backoffPolicy: BackoffPolicy.exponential,
  );

  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CryptoWatch',
      theme: ThemeData.dark(),
      routerConfig: goRouter,
    );
  }
}
