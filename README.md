# HerGuardian

**Tech for Women's Safety & Security** — a smart safety system that combines a mobile app with a safety trigger embedded into something already carried every day: a school/college ID card.

Built for the **SafeSphere: Tech for Women's Safety & Security** hackathon track.

---

## The idea

Most safety gadgets fail at the adoption stage — people don't carry a separate device they have to remember. HerGuardian embeds the panic trigger into an ID card/badge that's already part of a daily routine, paired with a mobile app that handles the actual response: alerting contacts, sharing location, recording audio, and escalating if nobody responds.

## Features

**Trigger setup**
- In-app SOS button, lock-screen access, shake-to-trigger, voice keyword ("help"), and (planned) hardware card button
- 3-second cancel window on motion/voice triggers to prevent false alarms

**Home dashboard**
- Central SOS button
- Fake Call (escape awkward or unsafe situations)
- Audio record (evidence)
- Share live location
- Status chips: online/offline, active triggers, contacts configured

**Emergency Mode**
- Full-screen SOS view: red banner, timer, live map, alerted contacts list, audio waveform indicator
- "I'm Safe" / Cancel and "Escalate" actions
- Discreet/silent mode option — alerts fire in the background without an alarming on-screen state

**Connectivity-aware alerting**
- Online → push/WhatsApp/SMS
- Offline with cellular → direct SMS + local storage
- No network → records audio, saves last known location, queues alerts to send once connectivity returns

**Auto-escalation**
- Resends to primary contacts if unacknowledged after 1–2 minutes
- Escalates to backup contacts (e.g. campus security)

**Fake Call**
- Configurable caller identity (Mom / Office / Unknown) and delay (Now / 10s / 30s)
- Realistic incoming-call UI

**Incident history**
- Logs time, contacts alerted, locations, and audio presence after each SOS
- Expandable history of past SOS events and fake calls

## Tech stack

- **Flutter** (Dart) — cross-platform app
- `geolocator` — location
- `telephony` / `flutter_sms` — offline SMS fallback
- `record` — audio capture
- `shake` — shake-to-trigger detection
- `speech_to_text` — voice keyword trigger
- `connectivity_plus` — online/offline branching
- `hive` / `sqflite` — local storage (contacts, incident history — works offline)
- `flutter_local_notifications` — lock-screen SOS access

**Hardware (conceptual / prototype)**: panic button embedded in an ID card, MCU + BLE module, optional LED/buzzer feedback, optional mic for future on-card audio capture.

## Design direction

**Tech-Blue Safety** theme — two visual states:

| State | Palette |
|---|---|
| Normal | Deep navy + teal, calm and trust-building |
| Emergency | High-contrast, red/coral accent |

Dark navy background in dark mode, off-white in light mode, clean sans-serif type.

## Project structure

```
lib/
├── main.dart
├── app/
│   ├── theme.dart
│   └── router.dart
├── core/
│   ├── services/
│   │   ├── location_service.dart
│   │   ├── sms_service.dart
│   │   ├── audio_service.dart
│   │   ├── trigger_service.dart
│   │   ├── connectivity_service.dart
│   │   └── storage_service.dart
│   └── models/
│       ├── contact.dart
│       ├── incident.dart
│       └── sos_state.dart
├── features/
│   ├── onboarding/
│   ├── contacts/
│   ├── home/
│   ├── emergency/
│   ├── fake_call/
│   └── history/
└── shared/
    └── widgets/
```

SOS is modeled as a state machine: `idle → triggered → alerting → escalated → resolved`.

## Getting started

```bash
git clone https://github.com/suneja18/phoenix-v2v.git
cd phoenix-v2v
flutter pub get
flutter run
```

Requires Flutter SDK and a connected device or emulator. For testing the SOS flow's connectivity branches, test online, SMS-only (airplane mode + mobile data), and fully offline states separately.

## Status

🚧 Hackathon prototype — core app flow and splash screen in progress. Hardware is represented as a digital prototype (ID card mockup + block diagram) for this stage.

## Team

Built for SafeSphere: Tech for Women's Safety & Security.
