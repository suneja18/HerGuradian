// translations.dart
//
// Simple translation dictionary. Call tr('some_key') anywhere in the UI to
// get the string in whatever AppLanguage.current is set to.
//
// To add a new string: add one entry below with all 3 languages filled in,
// then use tr('your_key') in your widget instead of a hardcoded string.

import 'app_language.dart';

final Map<String, Map<AppLang, String>> _translations = {
  // Login
  'welcome_back': {
    AppLang.en: 'Welcome Back',
    AppLang.hi: 'वापस स्वागत है',
    AppLang.mr: 'पुन्हा स्वागत आहे',
  },
  'sign_in_subtitle': {
    AppLang.en: 'Sign in to stay protected',
    AppLang.hi: 'सुरक्षित रहने के लिए साइन इन करें',
    AppLang.mr: 'सुरक्षित राहण्यासाठी साइन इन करा',
  },
  'login': {
    AppLang.en: 'Login',
    AppLang.hi: 'लॉगिन',
    AppLang.mr: 'लॉगिन',
  },
  'email': {
    AppLang.en: 'Email',
    AppLang.hi: 'ईमेल',
    AppLang.mr: 'ईमेल',
  },
  'password': {
    AppLang.en: 'Password',
    AppLang.hi: 'पासवर्ड',
    AppLang.mr: 'पासवर्ड',
  },
  'new_user_register': {
    AppLang.en: 'New user? Register',
    AppLang.hi: 'नए उपयोगकर्ता? रजिस्टर करें',
    AppLang.mr: 'नवीन वापरकर्ता? नोंदणी करा',
  },

  // Register
  'create_account': {
    AppLang.en: 'Create Account',
    AppLang.hi: 'खाता बनाएं',
    AppLang.mr: 'खाते तयार करा',
  },
  'name': {
    AppLang.en: 'Name',
    AppLang.hi: 'नाम',
    AppLang.mr: 'नाव',
  },
  'emergency_contact_name': {
    AppLang.en: 'Emergency Contact Name',
    AppLang.hi: 'आपातकालीन संपर्क का नाम',
    AppLang.mr: 'आपत्कालीन संपर्काचे नाव',
  },
  'emergency_contact_phone': {
    AppLang.en: 'Emergency Contact Phone',
    AppLang.hi: 'आपातकालीन संपर्क फोन',
    AppLang.mr: 'आपत्कालीन संपर्क फोन',
  },
  'register_button': {
    AppLang.en: 'Register',
    AppLang.hi: 'रजिस्टर करें',
    AppLang.mr: 'नोंदणी करा',
  },

  // OTP
  'otp_sent_prefix': {
    AppLang.en: 'OTP sent to',
    AppLang.hi: 'ओटीपी भेजा गया',
    AppLang.mr: 'ओटीपी पाठवला',
  },
  'enter_otp': {
    AppLang.en: 'Enter OTP',
    AppLang.hi: 'ओटीपी दर्ज करें',
    AppLang.mr: 'ओटीपी टाका',
  },
  'verify': {
    AppLang.en: 'Verify',
    AppLang.hi: 'सत्यापित करें',
    AppLang.mr: 'सत्यापित करा',
  },

  // Permissions
  'permissions_title': {
    AppLang.en: 'Permissions',
    AppLang.hi: 'अनुमतियाँ',
    AppLang.mr: 'परवानग्या',
  },
  'permissions_desc': {
    AppLang.en: 'HerGuardian needs these permissions to keep you safe',
    AppLang.hi: 'आपको सुरक्षित रखने के लिए HerGuardian को इन अनुमतियों की आवश्यकता है',
    AppLang.mr: 'तुम्हाला सुरक्षित ठेवण्यासाठी HerGuardian ला या परवानग्यांची गरज आहे',
  },
  'grant_permissions': {
    AppLang.en: 'Grant Permissions',
    AppLang.hi: 'अनुमति दें',
    AppLang.mr: 'परवानगी द्या',
  },
  'continue_label': {
    AppLang.en: 'Continue',
    AppLang.hi: 'जारी रखें',
    AppLang.mr: 'पुढे चला',
  },
  'permission_location': {
    AppLang.en: 'Location',
    AppLang.hi: 'स्थान',
    AppLang.mr: 'स्थान',
  },
  'permission_mic': {
    AppLang.en: 'Microphone',
    AppLang.hi: 'माइक्रोफ़ोन',
    AppLang.mr: 'मायक्रोफोन',
  },
  'permission_phone': {
    AppLang.en: 'Phone',
    AppLang.hi: 'फ़ोन',
    AppLang.mr: 'फोन',
  },
  'permission_sms': {
    AppLang.en: 'SMS',
    AppLang.hi: 'एसएमएस',
    AppLang.mr: 'एसएमएस',
  },
  'permission_notifications': {
    AppLang.en: 'Notifications',
    AppLang.hi: 'सूचनाएं',
    AppLang.mr: 'सूचना',
  },
  'status_granted': {
    AppLang.en: 'Granted',
    AppLang.hi: 'स्वीकृत',
    AppLang.mr: 'मंजूर',
  },
  'status_denied': {
    AppLang.en: 'Not granted',
    AppLang.hi: 'स्वीकृत नहीं',
    AppLang.mr: 'मंजूर नाही',
  },

  // Emergency Contacts
  'ec_title': {
    AppLang.en: 'Emergency Contacts',
    AppLang.hi: 'आपातकालीन संपर्क',
    AppLang.mr: 'आपत्कालीन संपर्क',
  },
  'primary_contacts': {
    AppLang.en: 'Primary Contacts',
    AppLang.hi: 'प्राथमिक संपर्क',
    AppLang.mr: 'प्राथमिक संपर्क',
  },
  'backup_contacts': {
    AppLang.en: 'Backup Contacts (Security/Warden)',
    AppLang.hi: 'बैकअप संपर्क (सुरक्षा/वार्डन)',
    AppLang.mr: 'बॅकअप संपर्क (सुरक्षा/वॉर्डन)',
  },
  'add_contact': {
    AppLang.en: 'Add Contact',
    AppLang.hi: 'संपर्क जोड़ें',
    AppLang.mr: 'संपर्क जोडा',
  },
  'save_all': {
    AppLang.en: 'Save All',
    AppLang.hi: 'सभी सहेजें',
    AppLang.mr: 'सर्व जतन करा',
  },
  'no_contacts_yet': {
    AppLang.en: 'No contacts added yet',
    AppLang.hi: 'अभी तक कोई संपर्क नहीं जोड़ा गया',
    AppLang.mr: 'अजून कोणताही संपर्क जोडलेला नाही',
  },
  'contacts_saved': {
    AppLang.en: 'Contacts saved',
    AppLang.hi: 'संपर्क सहेजे गए',
    AppLang.mr: 'संपर्क जतन झाले',
  },

  // Home
  'tap_to_trigger': {
    AppLang.en: 'Tap to trigger emergency mode',
    AppLang.hi: 'आपातकालीन मोड शुरू करने के लिए टैप करें',
    AppLang.mr: 'आणीबाणी मोड सुरू करण्यासाठी टॅप करा',
  },
  'fake_call': {
    AppLang.en: 'Fake Call',
    AppLang.hi: 'फ़र्जी कॉल',
    AppLang.mr: 'बनावट कॉल',
  },
  'choose_caller': {
    AppLang.en: 'Choose Caller',
    AppLang.hi: 'कॉलर चुनें',
    AppLang.mr: 'कॉलर निवडा',
  },
  'caller_mom': {
    AppLang.en: 'Mom',
    AppLang.hi: 'माँ',
    AppLang.mr: 'आई',
  },
  'caller_office': {
    AppLang.en: 'Office',
    AppLang.hi: 'ऑफिस',
    AppLang.mr: 'ऑफिस',
  },
  'caller_unknown': {
    AppLang.en: 'Unknown',
    AppLang.hi: 'अज्ञात',
    AppLang.mr: 'अज्ञात',
  },
  'choose_delay': {
    AppLang.en: 'Delay',
    AppLang.hi: 'देरी',
    AppLang.mr: 'विलंब',
  },
  'delay_now': {
    AppLang.en: 'Now',
    AppLang.hi: 'अभी',
    AppLang.mr: 'आत्ता',
  },
  'delay_10s': {
    AppLang.en: '10s',
    AppLang.hi: '10 सेकंड',
    AppLang.mr: '10 सेकंद',
  },
  'delay_30s': {
    AppLang.en: '30s',
    AppLang.hi: '30 सेकंड',
    AppLang.mr: '30 सेकंद',
  },
  'start_fake_call': {
    AppLang.en: 'Start Fake Call',
    AppLang.hi: 'फ़र्जी कॉल शुरू करें',
    AppLang.mr: 'बनावट कॉल सुरू करा',
  },
  'incoming_call': {
    AppLang.en: 'Incoming call...',
    AppLang.hi: 'आने वाली कॉल...',
    AppLang.mr: 'येणारा कॉल...',
  },
  'decline': {
    AppLang.en: 'Decline',
    AppLang.hi: 'अस्वीकार करें',
    AppLang.mr: 'नाकारा',
  },
  'accept': {
    AppLang.en: 'Accept',
    AppLang.hi: 'स्वीकार करें',
    AppLang.mr: 'स्वीकारा',
  },
  'end_call': {
    AppLang.en: 'End Call',
    AppLang.hi: 'कॉल समाप्त करें',
    AppLang.mr: 'कॉल संपवा',
  },
  'calling_scheduled': {
    AppLang.en: 'Fake call scheduled',
    AppLang.hi: 'फ़र्जी कॉल निर्धारित',
    AppLang.mr: 'बनावट कॉल नियोजित',
  },
  'audio_record': {
    AppLang.en: 'Audio Record',
    AppLang.hi: 'ऑडियो रिकॉर्ड',
    AppLang.mr: 'ऑडिओ रेकॉर्ड',
  },
  'start_recording': {
    AppLang.en: 'Start Recording',
    AppLang.hi: 'रिकॉर्डिंग शुरू करें',
    AppLang.mr: 'रेकॉर्डिंग सुरू करा',
  },
  'stop_recording': {
    AppLang.en: 'Stop Recording',
    AppLang.hi: 'रिकॉर्डिंग रोकें',
    AppLang.mr: 'रेकॉर्डिंग थांबवा',
  },
  'recording_saved': {
    AppLang.en: 'Recording saved',
    AppLang.hi: 'रिकॉर्डिंग सहेजी गई',
    AppLang.mr: 'रेकॉर्डिंग जतन झाली',
  },
  'past_recordings': {
    AppLang.en: 'Past Recordings',
    AppLang.hi: 'पिछली रिकॉर्डिंग्स',
    AppLang.mr: 'मागील रेकॉर्डिंग्स',
  },
  'no_recordings_yet': {
    AppLang.en: 'No recordings yet',
    AppLang.hi: 'अभी तक कोई रिकॉर्डिंग नहीं',
    AppLang.mr: 'अजून रेकॉर्डिंग नाही',
  },
  'mic_permission_needed': {
    AppLang.en: 'Microphone permission needed',
    AppLang.hi: 'माइक्रोफ़ोन अनुमति आवश्यक है',
    AppLang.mr: 'मायक्रोफोन परवानगी आवश्यक आहे',
  },
  'share_location': {
    AppLang.en: 'Share Location',
    AppLang.hi: 'स्थान साझा करें',
    AppLang.mr: 'स्थान शेअर करा',
  },
  'fetching_location': {
    AppLang.en: 'Fetching your location...',
    AppLang.hi: 'आपका स्थान प्राप्त हो रहा है...',
    AppLang.mr: 'तुमचे स्थान मिळवत आहे...',
  },
  'open_in_maps': {
    AppLang.en: 'Open in Maps',
    AppLang.hi: 'मैप्स में खोलें',
    AppLang.mr: 'नकाशामध्ये उघडा',
  },
  'send_to_contacts': {
    AppLang.en: 'Send to Emergency Contacts',
    AppLang.hi: 'आपातकालीन संपर्कों को भेजें',
    AppLang.mr: 'आपत्कालीन संपर्कांना पाठवा',
  },
  'location_error': {
    AppLang.en: 'Could not get location. Check location permission/GPS.',
    AppLang.hi: 'स्थान प्राप्त नहीं हो सका। स्थान अनुमति/जीपीएस जांचें।',
    AppLang.mr: 'स्थान मिळाले नाही. स्थान परवानगी/जीपीएस तपासा.',
  },
  'no_contacts_for_share': {
    AppLang.en: 'Add an emergency contact first',
    AppLang.hi: 'पहले एक आपातकालीन संपर्क जोड़ें',
    AppLang.mr: 'आधी आपत्कालीन संपर्क जोडा',
  },
  'your_location': {
    AppLang.en: 'Your current location',
    AppLang.hi: 'आपका वर्तमान स्थान',
    AppLang.mr: 'तुमचे सध्याचे स्थान',
  },
  'incident_history': {
    AppLang.en: 'Incident History',
    AppLang.hi: 'घटना इतिहास',
    AppLang.mr: 'घटना इतिहास',
  },
  'no_incidents_yet': {
    AppLang.en: 'No incidents yet',
    AppLang.hi: 'अभी तक कोई घटना नहीं',
    AppLang.mr: 'अजून कोणतीही घटना नाही',
  },
  'sos_event': {
    AppLang.en: 'SOS Triggered',
    AppLang.hi: 'एसओएस सक्रिय हुआ',
    AppLang.mr: 'एसओएस सक्रिय झाले',
  },
  'fake_call_event': {
    AppLang.en: 'Fake Call Used',
    AppLang.hi: 'फ़र्जी कॉल का उपयोग हुआ',
    AppLang.mr: 'बनावट कॉल वापरला',
  },
  'duration_label': {
    AppLang.en: 'Duration',
    AppLang.hi: 'अवधि',
    AppLang.mr: 'कालावधी',
  },
  'caller_label': {
    AppLang.en: 'Caller',
    AppLang.hi: 'कॉलर',
    AppLang.mr: 'कॉलर',
  },
  'time_label': {
    AppLang.en: 'Time',
    AppLang.hi: 'समय',
    AppLang.mr: 'वेळ',
  },
  'profile': {
    AppLang.en: 'Profile',
    AppLang.hi: 'प्रोफ़ाइल',
    AppLang.mr: 'प्रोफाइल',
  },
  'swipe_for_more': {
    AppLang.en: 'Swipe for more',
    AppLang.hi: 'अधिक के लिए स्वाइप करें',
    AppLang.mr: 'अधिकसाठी स्वाइप करा',
  },
  'status_online': {
    AppLang.en: 'Online',
    AppLang.hi: 'ऑनलाइन',
    AppLang.mr: 'ऑनलाइन',
  },
  'status_triggers_active': {
    AppLang.en: 'Triggers Active',
    AppLang.hi: 'ट्रिगर सक्रिय',
    AppLang.mr: 'ट्रिगर सक्रिय',
  },
  'status_contacts_set': {
    AppLang.en: 'Contacts Set',
    AppLang.hi: 'संपर्क सेट',
    AppLang.mr: 'संपर्क सेट',
  },

  // Emergency Mode
  'sos_active': {
    AppLang.en: 'SOS Active — Alerts sent',
    AppLang.hi: 'एसओएस सक्रिय — अलर्ट भेजे गए',
    AppLang.mr: 'एसओएस सक्रिय — अलर्ट पाठवले',
  },
  'escalate': {
    AppLang.en: 'Escalate',
    AppLang.hi: 'एस्केलेट करें',
    AppLang.mr: 'एस्कलेट करा',
  },
  'im_safe': {
    AppLang.en: "I'm Safe",
    AppLang.hi: 'मैं सुरक्षित हूं',
    AppLang.mr: 'मी सुरक्षित आहे',
  },
  'escalated_msg': {
    AppLang.en: 'Escalated to backup contacts',
    AppLang.hi: 'बैकअप संपर्कों को एस्केलेट किया गया',
    AppLang.mr: 'बॅकअप संपर्कांना एस्कलेट केले',
  },
  'map_pending': {
    AppLang.en: 'Live location sharing\n(map integration pending)',
    AppLang.hi: 'लाइव स्थान साझाकरण\n(मानचित्र एकीकरण लंबित)',
    AppLang.mr: 'थेट स्थान शेअरिंग\n(नकाशा एकत्रीकरण प्रलंबित)',
  },

  // Language switcher itself
  'language': {
    AppLang.en: 'Language',
    AppLang.hi: 'भाषा',
    AppLang.mr: 'भाषा',
  },
};

String tr(String key) {
  final lang = AppLanguage.current.value;
  final entry = _translations[key];
  if (entry == null) return key;
  return entry[lang] ?? entry[AppLang.en] ?? key;
}
