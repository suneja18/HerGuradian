// share_location_screen.dart
//
// Fetches the real current GPS position, then lets you open it in Maps
// or send it directly to your saved emergency contacts via SMS.

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';
import 'contact_model.dart';
import 'services/contact_storage_service.dart';

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({super.key});

  @override
  State<ShareLocationScreen> createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  Position? _position;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _error = tr('location_error');
          _loading = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _error = tr('location_error');
          _loading = false;
        });
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setState(() {
        _position = pos;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = tr('location_error');
        _loading = false;
      });
    }
  }

  String get _mapsUrl {
    if (_position == null) return '';
    return 'https://www.google.com/maps/search/?api=1&query=${_position!.latitude},${_position!.longitude}';
  }

  Future<void> _openInMaps() async {
    final uri = Uri.parse(_mapsUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('location_error'))),
      );
    }
  }

  Future<void> _sendToContacts() async {
    final all = await ContactStorageService.loadContacts();
    final primary = all.where((c) => c.isPrimary).toList();
    final contacts = primary.isNotEmpty ? primary : all;

    if (contacts.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('no_contacts_for_share'))),
      );
      return;
    }

    final numbers = contacts.map((c) => c.phone).join(',');
    final body = Uri.encodeComponent(
      'I need help. Here is my current location: $_mapsUrl',
    );
    final uri = Uri.parse('sms:$numbers?body=$body');

    try {
      await launchUrl(uri);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr('location_error'))),
      );
    }
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
            title: Text(tr('share_location')),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(child: LanguageSwitcher()),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: _loading
                ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: AppColors.navy),
                  const SizedBox(height: 16),
                  Text(tr('fetching_location'),
                      style: const TextStyle(color: AppColors.navy)),
                ],
              ),
            )
                : _error != null
                ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_off,
                      size: 48, color: AppColors.navy),
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.navy),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.navy,
                      foregroundColor: AppColors.cream,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.my_location,
                              color: AppColors.navy),
                          const SizedBox(width: 8),
                          Text(
                            tr('your_location'),
                            style: const TextStyle(
                              color: AppColors.navy,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Lat: ${_position!.latitude.toStringAsFixed(6)}',
                        style: const TextStyle(color: AppColors.navy),
                      ),
                      Text(
                        'Lng: ${_position!.longitude.toStringAsFixed(6)}',
                        style: const TextStyle(color: AppColors.navy),
                      ),
                      Text(
                        'Accuracy: ±${_position!.accuracy.toStringAsFixed(0)}m',
                        style: TextStyle(
                          color: AppColors.navy.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _openInMaps,
                  icon: const Icon(Icons.map),
                  label: Text(tr('open_in_maps')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navy,
                    foregroundColor: AppColors.cream,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _sendToContacts,
                  icon: const Icon(Icons.sms, color: AppColors.navy),
                  label: Text(tr('send_to_contacts'),
                      style: const TextStyle(color: AppColors.navy)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.navy),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
