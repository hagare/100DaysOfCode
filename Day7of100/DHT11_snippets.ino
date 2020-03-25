# Arduino Code

# DHT11 Humidty Sensor with 3 pins
# Sensor  Arduino
# Signal  PWM (7)
# VCC      5V
# GND     GND


# Install the DHTLib library
# Output Serial
#include <dht.h>

dht DHT;

#define DHT11_PIN 7

void setup(){
  Serial.begin(9600);
}

void loop()
{
  int chk = DHT.read11(DHT11_PIN);
  Serial.print("Temperature = ");
  Serial.println(DHT.temperature);
  Serial.print("Humidity = ");
  Serial.println(DHT.humidity);
  delay(1000);
}

# Output to LCD

#include <dht.h>
#include <LiquidCrystal.h>

LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

dht DHT;

#define DHT11_PIN 7

void setup(){
  lcd.begin(16, 2);
}

void loop()
{
  int chk = DHT.read11(DHT11_PIN);
  lcd.setCursor(0,0); 
  lcd.print("Temp: ");
  lcd.print(DHT.temperature);
  lcd.print((char)223);
  lcd.print("C");
  lcd.setCursor(0,1);
  lcd.print("Humidity: ");
  lcd.print(DHT.humidity);
  lcd.print("%");
  delay(1000);
}

# Use DHT data in other programs
#include <dht.h>

dht DHT;

#define DHT11_PIN 7

void setup(){
}

void loop()
{
  int chk = DHT.read11(DHT11_PIN);
  delay(1000);
}
