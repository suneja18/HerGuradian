// incoming_call_screen.dart
//
// Realistic full-screen fake incoming call UI. Accept -> InCallScreen,
// Decline -> pops back to wherever the user was (e.g. an uncomfortable
// conversation they wanted an excuse to leave).

import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'in_call_screen.dart';

class IncomingCallScreen extends StatefulWidget {
  final String callerName;
  const IncomingCallScreen({super.key, required this.callerName});

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // back button shouldn't dismiss a "ringing" call
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1B2B),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const Spacer(flex: 2),
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale = 1 + _pulseController.value * 0.12;
                    return Transform.scale(scale: scale, child: child);
                  },
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.lightBlue,
                    child: Icon(Icons.person, size: 64, color: AppColors.navy),
                  ),
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
                  tr('incoming_call'),
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const Spacer(flex: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _callButton(
                      icon: Icons.call_end,
                      color: const Color(0xFFFF6B6B),
                      label: tr('decline'),
                      onTap: () => Navigator.pop(context),
                    ),
                    _callButton(
                      icon: Icons.call,
                      color: const Color(0xFF4CAF7D),
                      label: tr('accept'),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                InCallScreen(callerName: widget.callerName),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _callButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }
}
