// home_screen.dart
//
// Home = SOS trigger only, front and center. Everything else (Fake Call,
// Audio Record, Share Location, Incident History, Profile) lives in a
// swipeable slider dashboard below it.

import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';
import 'emergency_screen.dart';
import 'profile_screen.dart';
import 'fake_call_setup_screen.dart';
import 'share_location_screen.dart';
import 'audio_record_screen.dart';
import 'incident_history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.78);
    _pageController.addListener(() {
      final next = _pageController.page?.round() ?? 0;
      if (next != _currentPage) {
        setState(() => _currentPage = next);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _placeholder(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature — coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLang>(
      valueListenable: AppLanguage.current,
      builder: (context, _, __) {
        final slides = <_SlideData>[
          _SlideData(
            icon: Icons.phone_in_talk,
            label: tr('fake_call'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FakeCallSetupScreen()),
              );
            },
          ),
          _SlideData(
            icon: Icons.mic,
            label: tr('audio_record'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AudioRecordScreen()),
              );
            },
          ),
          _SlideData(
            icon: Icons.share_location,
            label: tr('share_location'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShareLocationScreen()),
              );
            },
          ),
          _SlideData(
            icon: Icons.history,
            label: tr('incident_history'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const IncidentHistoryScreen()),
              );
            },
          ),
          _SlideData(
            icon: Icons.person,
            label: tr('profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ];

        return Scaffold(
          backgroundColor: AppColors.cream,
          appBar: AppBar(
            backgroundColor: AppColors.navy,
            foregroundColor: AppColors.cream,
            title: const Text('HerGuardian'),
            automaticallyImplyLeading: false,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(child: LanguageSwitcher()),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Central SOS button — the only thing on the main screen
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const EmergencyScreen()),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF6B6B),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF6B6B).withValues(alpha: 0.4),
                          blurRadius: 28,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'SOS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  tr('tap_to_trigger'),
                  style: const TextStyle(color: AppColors.navy, fontSize: 13),
                ),

                const Spacer(flex: 2),

                // Slider dashboard
                Text(
                  tr('swipe_for_more'),
                  style: TextStyle(
                    color: AppColors.navy.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 130,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      final slide = slides[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _SlideCard(data: slide),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(slides.length, (i) {
                    final active = i == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: active ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.navy
                            : AppColors.navy.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SlideData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  _SlideData({required this.icon, required this.label, required this.onTap});
}

class _SlideCard extends StatelessWidget {
  final _SlideData data;
  const _SlideCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data.icon, size: 34, color: AppColors.navy),
            const SizedBox(height: 10),
            Text(
              data.label,
              style: const TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
