// incident_history_screen.dart
//
// Lists past SOS events and Fake Call usage, newest first, with
// expandable details for each entry.

import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';
import 'services/incident_storage_service.dart';

class IncidentHistoryScreen extends StatefulWidget {
  const IncidentHistoryScreen({super.key});

  @override
  State<IncidentHistoryScreen> createState() => _IncidentHistoryScreenState();
}

class _IncidentHistoryScreenState extends State<IncidentHistoryScreen> {
  List<IncidentEntry> _incidents = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await IncidentStorageService.loadIncidents();
    setState(() {
      _incidents = list;
      _loading = false;
    });
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _formatDuration(int? seconds) {
    if (seconds == null) return '-';
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
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
            title: Text(tr('incident_history')),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(child: LanguageSwitcher()),
              ),
            ],
          ),
          body: _loading
              ? const Center(
              child: CircularProgressIndicator(color: AppColors.navy))
              : _incidents.isEmpty
              ? Center(
            child: Text(
              tr('no_incidents_yet'),
              style: TextStyle(
                  color: AppColors.navy.withValues(alpha: 0.6)),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _incidents.length,
            itemBuilder: (context, index) {
              final entry = _incidents[index];
              final isSos = entry.type == IncidentType.sos;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Icon(
                      isSos ? Icons.warning_amber : Icons.phone_in_talk,
                      color: isSos
                          ? const Color(0xFFFF6B6B)
                          : AppColors.navy,
                    ),
                    title: Text(
                      isSos ? tr('sos_event') : tr('fake_call_event'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy,
                      ),
                    ),
                    subtitle: Text(_formatDateTime(entry.timestamp)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                            16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${tr('time_label')}: ${_formatDateTime(entry.timestamp)}',
                              style: const TextStyle(
                                  color: AppColors.navy),
                            ),
                            if (isSos)
                              Text(
                                '${tr('duration_label')}: ${_formatDuration(entry.durationSeconds)}',
                                style: const TextStyle(
                                    color: AppColors.navy),
                              ),
                            if (!isSos)
                              Text(
                                '${tr('caller_label')}: ${entry.callerName ?? '-'}',
                                style: const TextStyle(
                                    color: AppColors.navy),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
