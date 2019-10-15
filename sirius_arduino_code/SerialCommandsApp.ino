int charRec = 0; // for incoming serial data
int up = 23;
int down = 24;
int left = 25;
int right = 26;
int eMag = 27;

void setup() {
  Serial.begin(9600); 
  pinMode(up,OUTPUT);
  pinMode(down,OUTPUT);
  pinMode(left,OUTPUT);
  pinMode(right,OUTPUT);
  pinMode(eMag,OUTPUT);
}

void loop() {
  // send data only when you receive data:
  if (Serial.available() > 0) {
    // read the incoming byte:
    charRec = Serial.read();
    
    if(charRec == 'u'){
      digitalWrite(up, HIGH);
    }
    if(charRec == 'd'){
      digitalWrite(down, HIGH);
    }
    if(charRec == 'l'){
      digitalWrite(left, HIGH);
    }
    if(charRec == 'r'){
      digitalWrite(right, HIGH);
    }
    if(charRec == 'e'){
      digitalWrite(eMag, HIGH);
    }
  }
}
