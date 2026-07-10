# HerGuardian

**Tech for Women's Safety & Security** — built by **Team Phoenix** for the SafeSphere hackathon track.

## The idea

Most safety gadgets fail at the adoption stage — people don't carry a separate device they have to remember. HerGuardian embeds the panic trigger into something already carried every day, like a school/college **ID card or badge**, paired with a mobile app that handles the actual response: alerting emergency contacts, sharing location, recording audio, and escalating if nobody responds.

The app is the working core right now; the ID-card trigger is represented by a hardware simulation (see below) at this stage.

## Features

- **One-tap SOS** — trigger emergency mode instantly from the home screen
- **Emergency contacts** — set primary and backup contacts to be alerted
- **Multi-language support** — English, हिंदी, मराठी
- **Fake call, audio recording, live location sharing** *(in progress)*
- **Offline-first** — contacts and settings are stored locally, no internet required to set up

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



## Hardware Prototype

A simulated ID-card trigger — button + LED — runnable straight from your browser, no hardware needed:

👉 **[Run the live Wokwi simulation](https://wokwi.com/projects/469107045314170881)**

See [`hardware/README.md`](hardware/README.md) for details.

## Tech Stack

- **Flutter** (Dart)
- **Hive** — local, offline storage
- **permission_handler** — location, microphone, phone, SMS, notifications

## Getting Started

```bash
git clone https://github.com/suneja18/phoenix-v2v.git
cd phoenix-v2v
flutter pub get
flutter run
```

## Status

🚧 Hackathon prototype — core app flow (auth, contacts, home dashboard, emergency mode) is working. The ID-card hardware trigger exists as a digital simulation for now.

## Team Phoenix

Built with care to help people feel safer, one tap at a time.

