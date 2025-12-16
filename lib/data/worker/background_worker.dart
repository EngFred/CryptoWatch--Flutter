import 'package:workmanager/workmanager.dart';
import 'package:flutter/widgets.dart';
import '../../core/logger.dart';
import '../../di/injection.dart';
import '../../domain/repository/crypto_repository.dart';

const String syncTaskName = "com.engfred.cryptowatch.sync_task";
const String syncUniqueName = "crypto_periodic_sync";

/// This is the "Main" function for your Background Thread.
/// It runs in a totally separate environment from your UI.
@pragma('vm:entry-point') // Tells Dart compiler not to strip this function
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // We use a local variable for the logger instance
    // since we cannot rely on it being configured until after configureDependencies()
    AppLogger? logger;

    try {
      // 1. Initialize Flutter Bindings for the background isolate
      WidgetsFlutterBinding.ensureInitialized();

      // 2. RE-INITIALIZE Dependency Injection
      await configureDependencies();

      // 3. Grab the Logger from our fresh DI graph
      logger = getIt<AppLogger>();
      logger.info("Background Worker: Task received: $task");

      // 4. Router logic based on task name
      switch (task) {
        case syncTaskName:
          logger.info("Background Worker: Starting Crypto Sync...");

          // 5. Grab the Repo from our fresh DI graph
          final repository = getIt<CryptoRepository>();

          // 6. Execute the actual business logic
          await repository.triggerSync();

          logger.info("Background Worker: Sync Completed Successfully.");
          break;

        default:
          logger.warning("Background Worker: Unknown task: $task");
          break;
      }

      return Future.value(true);
    } catch (e, stack) {
      // Use the logger if available, otherwise fallback to print (shouldn't happen here)
      if (logger != null) {
        logger.error(
          "Background Worker Failed to execute task: $task",
          e,
          stack,
        );
      }

      // Return false = Retry (WorkManager will use exponential backoff)
      return Future.value(false);
    }
  });
}
