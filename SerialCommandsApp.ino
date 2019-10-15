int charRec = 0; // for incoming serial data
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
int pos;
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
    
  // read the incoming byte:   
    switch (charRec) {
      case 'u':
        digitalWrite(up, HIGH);
        break;

      case 'd':
        digitalWrite(down, HIGH);
        break;

      case 'l':
        digitalWrite(left, HIGH);
        break;

      case 'r':
        digitalWrite(right, HIGH);
        break;

      case 'e':
        digitalWrite(eMag, HIGH);
        break;
    }
    tamano();
    preguntar();
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
void preguntar() {
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
