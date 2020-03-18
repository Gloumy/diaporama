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
    await Hive.initFlutter();
    Hive.registerAdapter(ContentSourceAdapter());
    await Hive.openBox<ContentSource>("sources");
  }
}
