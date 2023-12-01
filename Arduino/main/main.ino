#include "I2Cdev.h"
#include "MPU6050_6Axis_MotionApps20.h"
#include "Wire.h"

#include "MAX30105.h"

#include "heartRate.h"

MAX30105 particleSensor;

const byte RATE_SIZE = 4;  //Increase this for more averaging. 4 is good.
byte rates[RATE_SIZE];     //Array of heart rates
byte rateSpot = 0;
long lastBeat = 0;  //Time at which the last beat occurred

float beatsPerMinute;
int beatAvg;

MPU6050 mpu;

bool dmpReady = false;
uint8_t mpuIntStatus;
uint8_t devStatus;
uint16_t packetSize;
uint16_t fifoCount;
uint8_t fifoBuffer[64];

Quaternion q;
VectorFloat gravity;
float ypr[3];

volatile bool mpuInterrupt = false;

const int N = 30;
float pitchArray[N];
float offsetVal = 0;

void dmpDataReady() {
  mpuInterrupt = true;
}

float average(float arr[], int n) {
  float ret = 0;
  for (int i = 0; i < n; i++) {
    ret += arr[i];
  }
  return ret / n;
}

void setGyro() {
  mpu.initialize();

  while (!mpu.testConnection()) {
  }

  devStatus = mpu.dmpInitialize();

  if (devStatus == 0) {
    mpu.setDMPEnabled(true);
    // attachInterrupt(
    //   digitalPinToInterrupt(PIN_INTERRUPT),
    //   dmpDataReady, RISING);
    mpuIntStatus = mpu.getIntStatus();
    dmpReady = true;
    packetSize = mpu.dmpGetFIFOPacketSize();
  }

  delay(1000);

  for (int i = 0; i < N; i++) {
    pitchArray[i] = getPitch();
  }
  offsetVal = average(pitchArray, N);
}

void setHeart() {
  // Initialize sensor
  if (!particleSensor.begin(Wire, I2C_SPEED_FAST))  //Use default I2C port, 400kHz speed
  {
    // Serial.println("MAX30105 was not found. Please check wiring/power. ");
    while (1)
      ;
  }
  // Serial.println("Place your index finger on the sensor with steady pressure.");

  particleSensor.setup();                     //Configure sensor with default settings
  particleSensor.setPulseAmplitudeRed(0x0A);  //Turn Red LED to low to indicate sensor is running
  particleSensor.setPulseAmplitudeGreen(0);   //Turn off Green LED
}

void setup() {
  Serial.begin(9600);
  Wire.begin();
  Wire.setClock(400000);

  setGyro();
  setHeart();
}

void loop() {
  Serial.print(getPitch() - offsetVal);
  Serial.print(",");
  Serial.println(getHeart());
}

float getPitch() {
  float pitch = 0;

  if (!dmpReady) {
    return;
  }

  mpuInterrupt = false;
  mpuIntStatus = mpu.getIntStatus();
  fifoCount = mpu.getFIFOCount();

  if ((mpuIntStatus & 0x10) || fifoCount == 1024) {
    mpu.resetFIFO();
  } else if (mpuIntStatus & 0x02) {
    while (fifoCount < packetSize) {
      fifoCount = mpu.getFIFOCount();
    }

    mpu.getFIFOBytes(fifoBuffer, packetSize);
    fifoCount -= packetSize;

    mpu.dmpGetQuaternion(&q, fifoBuffer);
    mpu.dmpGetGravity(&gravity, &q);
    mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);

    pitch = ypr[1] * 180 / M_PI;
    float roll = ypr[2] * 180 / M_PI;

    // Serial.print("pitch: ");
    // Serial.println(pitch);
    // Serial.print("roll: ");
    // Serial.println(roll);
  }
  delay(10);
  return pitch;
}

float getHeart() {
  long irValue = particleSensor.getIR();

  if (checkForBeat(irValue) == true) {
    //We sensed a beat!
    long delta = millis() - lastBeat;
    lastBeat = millis();

    beatsPerMinute = 60 / (delta / 1000.0);

    if (beatsPerMinute < 255 && beatsPerMinute > 20) {
      rates[rateSpot++] = (byte)beatsPerMinute;  //Store this reading in the array
      rateSpot %= RATE_SIZE;                     //Wrap variable

      //Take average of readings
      beatAvg = 0;
      for (byte x = 0; x < RATE_SIZE; x++)
        beatAvg += rates[x];
      beatAvg /= RATE_SIZE;
    }
  }

  // Serial.print("IR=");
  // Serial.print(irValue);
  // Serial.print(", BPM=");
  // Serial.print(beatsPerMinute);
  // Serial.print(", Avg BPM=");
  // Serial.print(beatAvg);

  if (irValue < 50000) {
    return -1.0;
  }

  return beatAvg;

  // Serial.println();
}