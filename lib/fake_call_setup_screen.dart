// fake_call_setup_screen.dart
//
// Pick a caller identity and a delay, then schedule a realistic fake
// incoming call — used to help exit an uncomfortable/unsafe situation.

import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';
import 'incoming_call_screen.dart';
import 'services/incident_storage_service.dart';

class FakeCallSetupScreen extends StatefulWidget {
  const FakeCallSetupScreen({super.key});

  @override
  State<FakeCallSetupScreen> createState() => _FakeCallSetupScreenState();
}

enum _CallerOption { mom, office, unknown }

class _FakeCallSetupScreenState extends State<FakeCallSetupScreen> {
  _CallerOption _selectedCaller = _CallerOption.mom;
  int _delaySeconds = 0;

  String _callerLabel(_CallerOption option) {
    switch (option) {
      case _CallerOption.mom:
        return tr('caller_mom');
      case _CallerOption.office:
        return tr('caller_office');
      case _CallerOption.unknown:
        return tr('caller_unknown');
    }
  }

  void _scheduleCall() {
    final callerName = _callerLabel(_selectedCaller);

    if (_delaySeconds == 0) {
      _launchIncomingCall(callerName);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tr('calling_scheduled'))),
    );

    Future.delayed(Duration(seconds: _delaySeconds), () {
      if (!mounted) return;
      _launchIncomingCall(callerName);
    });

    Navigator.pop(context);
  }

  void _launchIncomingCall(String callerName) {
    IncidentStorageService.addIncident(
      IncidentEntry(
        type: IncidentType.fakeCall,
        timestamp: DateTime.now(),
        callerName: callerName,
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IncomingCallScreen(callerName: callerName),
        fullscreenDialog: true,
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.navy : AppColors.lightBlue,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.cream : AppColors.navy,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
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
            title: Text(tr('fake_call')),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(child: LanguageSwitcher()),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('choose_caller'),
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _chip(
                      tr('caller_mom'),
                      _selectedCaller == _CallerOption.mom,
                          () => setState(() => _selectedCaller = _CallerOption.mom),
                    ),
                    _chip(
                      tr('caller_office'),
                      _selectedCaller == _CallerOption.office,
                          () =>
                          setState(() => _selectedCaller = _CallerOption.office),
                    ),
                    _chip(
                      tr('caller_unknown'),
                      _selectedCaller == _CallerOption.unknown,
                          () => setState(
                              () => _selectedCaller = _CallerOption.unknown),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  tr('choose_delay'),
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _chip(tr('delay_now'), _delaySeconds == 0,
                            () => setState(() => _delaySeconds = 0)),
                    _chip(tr('delay_10s'), _delaySeconds == 10,
                            () => setState(() => _delaySeconds = 10)),
                    _chip(tr('delay_30s'), _delaySeconds == 30,
                            () => setState(() => _delaySeconds = 30)),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _scheduleCall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    foregroundColor: AppColors.cream,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(tr('start_fake_call')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
