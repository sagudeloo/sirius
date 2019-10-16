int charRec = 0; // for incoming serial data
bool inPosition = false;
int up = 23;
int down = 22;
int left = 25;
int right = 26;
int eMag = 24;
int sen1 = 37;
int sen2 = 36;
int sen3 = 35;
int sen4 = 34;
int p1 = 33;
int p2 = 32;
int p3 = 31;
int sarr = 30;
int saba = 21;
int pos;
int posV;
char tam;

void setup() {
  Serial.begin(9600);
  pinMode(up, OUTPUT);
  pinMode(down, OUTPUT);
  pinMode(left, OUTPUT);
  pinMode(right, OUTPUT);
  pinMode(eMag, OUTPUT);
  pinMode(p1, OUTPUT);
  pinMode(p2, OUTPUT);
  pinMode(p3, OUTPUT);
  DDRC = B11110000;
}

void loop() {
  // send data only when you receive data:
  if (Serial.available() > 0) {
    charRec = Serial.read();

    switch (charRec) {
      case 'u':
        while (digitalRead(sarr) == LOW) {
          digitalWrite(up, HIGH);
        }
        digitalWrite(down, LOW);
        break;

      case 'd':
        while (digitalRead(saba) == LOW) {
          digitalWrite(down, HIGH);
        }
        digitalWrite(down, LOW);
        break;

      case 'l':
        pos = preguntarPosHor();
        if (pos == 1) {
          while ( digitalRead(p2) == LOW || digitalRead(p3) == LOW) {
            digitalWrite(left, HIGH);
          }
          digitalWrite(left, LOW);
        } else if (pos == 2) {
          while ( digitalRead(p1) == LOW || digitalRead(p3) == LOW) {
            digitalWrite(left, HIGH);
          }
          digitalWrite(left, LOW);
        } else if (pos == 3) {
          while ( digitalRead(p1) == LOW || digitalRead(p2) == LOW) {
            digitalWrite(left, HIGH);
          }
          digitalWrite(left, LOW);
        }
        break;

      case 'r':
        pos = preguntarPosHor();
        if (pos == 1) {
          while ( digitalRead(p2) == LOW || digitalRead(p3) == LOW) {
            digitalWrite(right, HIGH);
          }
          digitalWrite(right, LOW);
        } else if (pos == 2) {
          while ( digitalRead(p1) == LOW || digitalRead(p3) == LOW) {
            digitalWrite(right, HIGH);
          }
          digitalWrite(right, LOW);
        } else if (pos == 3) {
          while ( digitalRead(p1) == LOW || digitalRead(p2) == LOW) {
            digitalWrite(right, HIGH);
          }
          digitalWrite(right, LOW);
        }
        break;

      case 'e':
        digitalWrite(eMag, HIGH);
        break;
    }

    tamano();
    preguntarPosHor();

  }
}

void tamano() {
  byte tamanno;
  tamanno = PINC;
  switch (PINC) {
    case B11100000:
      tam = 'b'; //Big
      break;

    case B11000000:
      tam = 'm'; //Medium
      break;

    case B10000000:
      tam = 's'; //Small
      break;
  }
}
int preguntarPosHor() {
  if (digitalRead(p1) == HIGH) {
    pos = 1;
    return pos;
  }

  if (digitalRead(p2) == HIGH) {
    pos = 2;
    return pos;
  }

  if (digitalRead(p3) == HIGH) {
    pos = 3;
    return pos;
  }
}

void preguntarPosVer() {
  if (digitalRead(sarr) == HIGH) {
    posV = 1;
    return posV;
  }

  if (digitalRead(saba) == HIGH) {
    posV = 2;
    return posV;
  }
}
