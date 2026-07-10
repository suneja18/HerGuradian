// in_call_screen.dart
//
// Fake "in call" screen shown after accepting the fake incoming call —
// gives a believable excuse to step away, with a live call timer.

import 'dart:async';
import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';

class InCallScreen extends StatefulWidget {
  final String callerName;
  const InCallScreen({super.key, required this.callerName});

  @override
  State<InCallScreen> createState() => _InCallScreenState();
}

class _InCallScreenState extends State<InCallScreen> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _seconds++);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _formatted {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1B2B),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const Spacer(flex: 2),
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.lightBlue,
                  child: Icon(Icons.person, size: 64, color: AppColors.navy),
                ),
                const SizedBox(height: 24),
                Text(
                  widget.callerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatted,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const Spacer(flex: 3),
                GestureDetector(
                  onTap: () => Navigator.popUntil(context, (r) => r.isFirst),
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFF6B6B),
                    ),
                    child: const Icon(Icons.call_end,
                        color: Colors.white, size: 28),
                  ),
                ),
                const SizedBox(height: 8),
                Text(tr('end_call'),
                    style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
