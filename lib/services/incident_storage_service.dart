// incident_storage_service.dart
//
// Logs SOS events and Fake Call usage to Hive so they show up in
// Incident History. Same append/load pattern as the other storage services.

import 'package:hive/hive.dart';

enum IncidentType { sos, fakeCall }

class IncidentEntry {
  final IncidentType type;
  final DateTime timestamp;
  final int? durationSeconds; // for SOS
  final String? callerName; // for fake call

  IncidentEntry({
    required this.type,
    required this.timestamp,
    this.durationSeconds,
    this.callerName,
  });

  Map<String, dynamic> toMap() => {
    'type': type.name,
    'timestamp': timestamp.toIso8601String(),
    'durationSeconds': durationSeconds,
    'callerName': callerName,
  };

  factory IncidentEntry.fromMap(Map map) => IncidentEntry(
    type: (map['type'] == 'fakeCall')
        ? IncidentType.fakeCall
        : IncidentType.sos,
    timestamp:
    DateTime.tryParse(map['timestamp'] as String? ?? '') ??
        DateTime.now(),
    durationSeconds: map['durationSeconds'] as int?,
    callerName: map['callerName'] as String?,
  );
}

class IncidentStorageService {
  static const String boxName = 'incidentsBox';

  static Future<Box> _openBox() async {
    if (Hive.isBoxOpen(boxName)) return Hive.box(boxName);
    return Hive.openBox(boxName);
  }

  static Future<void> addIncident(IncidentEntry entry) async {
    final box = await _openBox();
    await box.add(entry.toMap());
  }

  static Future<List<IncidentEntry>> loadIncidents() async {
    final box = await _openBox();
    return box.values
        .map((e) => IncidentEntry.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList()
        .reversed
        .toList(); // newest first
  }
}
