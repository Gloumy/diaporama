import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 1)
class AppSettings extends HiveObject {
  @HiveField(0)
  bool stillAVirgin;

  @HiveField(1)
  String credentials;

  AppSettings({
    this.stillAVirgin,
    this.credentials,
  });

  AppSettings copyWith({
    bool stillAVirgin,
    String credentials,
  }) =>
      AppSettings(
        stillAVirgin: stillAVirgin ?? this.stillAVirgin,
        credentials: credentials ?? this.credentials,
      );
}
