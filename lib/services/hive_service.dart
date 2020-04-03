import 'package:diaporama/models/app_settings.dart';
import 'package:diaporama/models/content_source.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _singleton = HiveService._internal();

  factory HiveService() {
    return _singleton;
  }

  HiveService._internal();

  static Future<void> initHive() async {
    // Init
    await Hive.initFlutter();
    // Register adapters
    Hive.registerAdapter(ContentSourceAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
    // Open boxes
    await Hive.openBox<ContentSource>("sources");
    await Hive.openBox<AppSettings>("settings");
  }
}
