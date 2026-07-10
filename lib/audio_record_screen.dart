// audio_record_screen.dart
//
// Tap to record evidence audio, see a live timer while recording, then
// browse and play back past recordings. Files are saved to the app's
// documents directory and tracked in Hive.

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';
import 'services/recording_storage_service.dart';

class AudioRecordScreen extends StatefulWidget {
  const AudioRecordScreen({super.key});

  @override
  State<AudioRecordScreen> createState() => _AudioRecordScreenState();
}

class _AudioRecordScreenState extends State<AudioRecordScreen> {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  bool _isRecording = false;
  int _secondsElapsed = 0;
  Timer? _timer;

  List<RecordingEntry> _recordings = [];
  int? _playingIndex;

  @override
  void initState() {
    super.initState();
    _loadRecordings();
    _player.onPlayerComplete.listen((_) {
      setState(() => _playingIndex = null);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<void> _loadRecordings() async {
    final list = await RecordingStorageService.loadRecordings();
    setState(() => _recordings = list);
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final path = await _recorder.stop();
      _timer?.cancel();
      setState(() {
        _isRecording = false;
        _secondsElapsed = 0;
      });

      if (path != null) {
        final entry = RecordingEntry(path: path, timestamp: DateTime.now());
        await RecordingStorageService.addRecording(entry);
        await _loadRecordings();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(tr('recording_saved'))),
        );
      }
      return;
    }

    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('mic_permission_needed'))),
      );
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    final path =
        '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(const RecordConfig(), path: path);
    setState(() {
      _isRecording = true;
      _secondsElapsed = 0;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _secondsElapsed++);
    });
  }

  String get _formattedTime {
    final m = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Future<void> _togglePlayback(int index) async {
    final entry = _recordings[index];
    if (_playingIndex == index) {
      await _player.stop();
      setState(() => _playingIndex = null);
    } else {
      await _player.stop();
      await _player.play(DeviceFileSource(entry.path));
      setState(() => _playingIndex = index);
    }
  }

  Future<void> _deleteRecording(int index) async {
    final entry = _recordings[index];
    try {
      final file = File(entry.path);
      if (await file.exists()) await file.delete();
    } catch (_) {}
    await RecordingStorageService.deleteRecording(index);
    await _loadRecordings();
  }

  String _formatTimestamp(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLang>(
      valueListenable: AppLanguage.current,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: AppColors.cream,
          appBar: AppBar(
            backgroundColor: AppColors.navy,
            foregroundColor: AppColors.cream,
            title: Text(tr('audio_record')),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(child: LanguageSwitcher()),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _toggleRecording,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isRecording
                              ? const Color(0xFFFF6B6B)
                              : AppColors.navy,
                        ),
                        child: Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _isRecording ? _formattedTime : tr('start_recording'),
                      style: const TextStyle(
                        color: AppColors.navy,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr('past_recordings'),
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _recordings.isEmpty
                    ? Center(
                  child: Text(
                    tr('no_recordings_yet'),
                    style: TextStyle(
                        color: AppColors.navy.withValues(alpha: 0.6)),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _recordings.length,
                  itemBuilder: (context, index) {
                    final entry = _recordings[index];
                    final isPlaying = _playingIndex == index;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(
                            isPlaying
                                ? Icons.stop_circle
                                : Icons.play_circle,
                            color: AppColors.navy,
                          ),
                          onPressed: () => _togglePlayback(index),
                        ),
                        title: Text(_formatTimestamp(entry.timestamp)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: AppColors.navy),
                          onPressed: () => _deleteRecording(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
