# HerGuardian Hardware SOS Simulation

This repository contains a **digital prototype** of the HerGuardian women’s safety hardware module. Instead of building the full physical circuit, we simulate the core behavior using an Arduino board, a push button, an LED, and serial output in Wokwi.

## Concept

HerGuardian is a smart safety system where an **SOS button embedded in an ID card or badge** triggers an emergency workflow:

- Activates an emergency state (visualized by an LED).
- Simulates reading GPS coordinates.
- Simulates sending SMS alerts to trusted contacts.
- Simulates starting audio recording as evidence.

This mirrors the logic of many IoT-based women’s safety devices that use a microcontroller, GPS, GSM/SMS, and a panic button [web:73][web:171][web:175].

## How the simulation works

- The push button represents the **hardware SOS trigger**.
- The Arduino sketch detects button presses and toggles **SOS / Safe** states.
- The LED turns on in **SOS mode** and off when cancelled.
- The **Serial Monitor** prints:
  - Fake GPS coordinates.
  - “SMS sent” messages.
  - “Audio recording started/stopped” messages.

Together, this forms a digital proof-of-concept for the HerGuardian ID-card hardware module [web:183][web:185].

## Purpose

This simulation is designed for:

- Hackathon presentations.
- Explaining the hardware architecture without building a full PCB.
- Showing how the hardware and the HerGuardian app can work together:
  - Hardware = physical trigger + basic sensing.
  - App = rich UI, live location, history, fake call, and escalation logic.
