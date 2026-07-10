const int BUTTON_PIN = 2;   // SOS button
const int LED_PIN = 3;      // SOS LED indicator

bool sosActive = false;

void setup() {
  Serial.begin(9600);

  pinMode(BUTTON_PIN, INPUT_PULLUP); // button to GND
  pinMode(LED_PIN, OUTPUT);

  digitalWrite(LED_PIN, LOW);

  Serial.println("HerGuardian digital hardware prototype ready.");
  Serial.println("Press the SOS button to simulate an emergency alert.");
}

void loop() {
  int buttonState = digitalRead(BUTTON_PIN);

  if (buttonState == LOW && !sosActive) {
    sosActive = true;
    digitalWrite(LED_PIN, HIGH);

    Serial.println("=== SOS TRIGGERED ===");
    Serial.println("Reading GPS coordinates (simulated)...");
    Serial.println("Location: lat=12.9716, lon=77.5946");
    Serial.println("Sending SMS to emergency contacts (simulated)...");
    Serial.println("Starting audio recording (simulated)...");
    Serial.println("HerGuardian hardware module is now in EMERGENCY mode.\n");
    delay(500); // debounce
  }

  if (buttonState == HIGH && sosActive) {
    sosActive = false;
    digitalWrite(LED_PIN, LOW);

    Serial.println("=== SOS CANCELLED ===");
    Serial.println("User is safe. Stopping alert and recording.\n");
    delay(500); // debounce
  }

  delay(50);
}