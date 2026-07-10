// recording_storage_service.dart
//
// Tracks saved audio recordings (file path + timestamp) using Hive,
// same append/load pattern as contact_storage_service.dart.

import 'package:hive/hive.dart';

class RecordingEntry {
  final String path;
  final DateTime timestamp;

  RecordingEntry({required this.path, required this.timestamp});

  Map<String, dynamic> toMap() => {
    'path': path,
    'timestamp': timestamp.toIso8601String(),
  };

  factory RecordingEntry.fromMap(Map map) => RecordingEntry(
    path: map['path'] as String? ?? '',
    timestamp:
    DateTime.tryParse(map['timestamp'] as String? ?? '') ??
        DateTime.now(),
  );
}

class RecordingStorageService {
  static const String boxName = 'recordingsBox';

  static Future<Box> _openBox() async {
    if (Hive.isBoxOpen(boxName)) return Hive.box(boxName);
    return Hive.openBox(boxName);
  }

  static Future<void> addRecording(RecordingEntry entry) async {
    final box = await _openBox();
    await box.add(entry.toMap());
  }

  static Future<List<RecordingEntry>> loadRecordings() async {
    final box = await _openBox();
    return box.values
        .map((e) => RecordingEntry.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList()
        .reversed
        .toList(); // newest first
  }

  static Future<void> deleteRecording(int hiveKeyIndex) async {
    final box = await _openBox();
    final keys = box.keys.toList();
    // keys are stored oldest-first; reversed list means we need the
    // original (non-reversed) index to map back to the right key.
    final originalIndex = keys.length - 1 - hiveKeyIndex;
    if (originalIndex >= 0 && originalIndex < keys.length) {
      await box.delete(keys[originalIndex]);
    }
  }
}
