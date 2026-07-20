# HerGuardian

**Tech for Women's Safety & Security** 

## Why HerGuardian is different

There's no shortage of women's safety apps — most offer the same checklist: an SOS button, location sharing, maybe a fake call. They all fail at the same point: **adoption**. A safety app only works if it's open and ready in the exact moment someone needs it, and in a real threat, pulling out a phone, unlocking it, and finding the right app is often not possible.

HerGuardian's difference is that the trigger isn't inside the phone at all — it's built into an **ID card or badge** people already wear every day, for school, college, or work. No extra gadget to remember, no app to unlock in a crisis. A single press on the card is the trigger; the phone and app handle everything after, automatically:

- The **card/hardware** is the always-on, always-carried trigger — physically pressed, no unlocking required
- The **app** is the response engine — it receives the trigger and handles location sharing, contact alerts, audio recording, and escalation without further input
- Together, they solve the two problems that sink most safety apps or gadgets on their own: hardware alone can't call for help intelligently, and apps alone are too slow to reach in a real emergency

That combination — a wearable physical trigger paired with a smart, offline-capable app — is what makes HerGuardian a system, not just another app with an SOS button. The app is the working core right now; the ID-card trigger is represented by a hardware simulation (see below) at this stage.

## Features

- **One-tap SOS** — trigger emergency mode instantly from the home screen
- **Emergency contacts** — set primary and backup contacts to be alerted
- **Multi-language support** — English, हिंदी, मराठी
- **Fake call, audio recording, live location sharing** *(in progress)*
- **Offline-first** — contacts and settings are stored locally, no internet required to set up

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


## By suneja

Built with care to help people feel safer, one tap at a time.
