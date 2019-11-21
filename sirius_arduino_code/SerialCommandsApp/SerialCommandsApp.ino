//Definición de pines
// for incoming serial data
#define down 22
#define up 23
#define eMag 24
#define left 25
#define right 26
#define sen1 37
#define sen2 36
#define sen3 35
#define sen4 34
#define p3 31
#define p2 32
#define p1 33
#define saba 29
#define sarr 30
int posicion = 0;
int tamanno = 0;
char charRec = 0; 
boolean iman = false;
boolean confirm = false;
String lastResponse = "";
String response = "";

void setup() {
  pinMode(up, OUTPUT);
  pinMode(down, OUTPUT);
  pinMode(left, OUTPUT);
  pinMode(right, OUTPUT);
  pinMode(eMag, OUTPUT);
  pinMode(p1, INPUT);
  pinMode(p2, INPUT);
  pinMode(p3, INPUT);
  pinMode(saba, INPUT);
  pinMode(sarr, INPUT);
  pinMode(sen1, INPUT);
  pinMode(sen2, INPUT);
  pinMode(sen3, INPUT);
  pinMode(sen4, INPUT);
  Serial.begin(9600);
  moveUp();
  while ( digitalRead(p1) == LOW) {
    digitalWrite(left, HIGH);
  }
  digitalWrite(left, LOW);
}

/*
Evalúa cada comando como un caracter.
 En caso de que sean movimeintos horizontales, se espera a que el electroimán esté en una posición determinada para  volver a 
 moverse.
 En caso de ser movimientos verticales, solo permite que se mueva en el límite de los sensores de arriba y abajo.
 */
void loop() {
  // Enviar los datos cuando los reciba
  if (Serial.available() > 0) {
    charRec = Serial.read();
    Serial.println(charRec);
    switch (charRec) {
    case 'u':
      moveUp();
      break;
    case 'd':
      moveDown();
      break;
    case 'l':
      moveLeft();
      Serial.println("l1");
      break;
    case 'r':
      moveRight();
      Serial.println("r1");
      break;
    case 'e':
      grabAndDrop();
      break;
    case '¬':
      confirm = true;
    default:
      break;
    }
  }
  posicion = preguntarPosHor();
  tamanno = iman? tamanno:getTamanno();
  response = String(posicion) +","+ String(iman) +","+ String(tamanno) +","+ String(confirm);
  if(response != lastResponse){
    lastResponse = response;
    Serial.println(response);
  }
  confirm = false;
}

/*
Método encargado de recuperar el tamaño del disco con el que se esté manteniendo contacto. Se realiza mediante la comunicación 
 directa con el puerto, y se saca la informacipon del mismo.
 b: big
 m: medium
 s: small
 */
int getTamanno() {
  if(digitalRead(sen4)){
    return 4;
  }
  else if(digitalRead(sen3)){
    return 3;
  }
  else if(digitalRead(sen2)){
    return 2;
  }
  else if(digitalRead(sen1)){
    return 1;
  }
  else{
    return 0;
  }
}

/*
Método encargado de recuperar la posición horizontal en la que el electroimán se encuentre (P1, P2, P3) y la retorna en la 
 variable pos
 */
int preguntarPosHor() {
  if (digitalRead(p1) == HIGH) {
    return 1;
  }
  else if (digitalRead(p2) == HIGH) {
    return 2;
  }
  else if (digitalRead(p3) == HIGH) {
    return 3;
  }
  else {
    return preguntarPosHor();
  }
}

/*
Método que retorna la posición vertical en la que el electroimán se encuentre (arriba o abajo), todo esto mediante sensores que
 que activan cuando el electroimán pase por ellos.
 1: Arriba
 2: Abajo
 */
int preguntarPosVer() {
  if (digitalRead(sarr) == HIGH) {
    return 1;
  }
  else if (digitalRead(saba) == HIGH) {
    return 2;
  }
  else {
    return 0;
  }
}

void moveLeft(){
  if (posicion == 2) {
    Serial.println("l2");
    while ( digitalRead(p1) == LOW) {
      digitalWrite(left, HIGH);
    }
    delay(10);
    digitalWrite(left, LOW);
  } 
  else if (posicion == 3) {
    Serial.println("l3");
    while (digitalRead(p2) == LOW) {
      digitalWrite(left, HIGH);
    }
    delay(10);
    digitalWrite(left, LOW);
  }
}

void moveRight(){
  Serial.println(posicion);
  if (posicion == 1) {
    Serial.println("r2");
    while ( digitalRead(p2) == LOW) {
      digitalWrite(right, HIGH);
    }
    delay(10);
    digitalWrite(right, LOW);
  } 
  else if (posicion == 2) {
    Serial.println("r3");
    while (digitalRead(p3) == LOW) {
      digitalWrite(right, HIGH);
    }
    delay(10);
    digitalWrite(right, LOW);
  }
}

void moveUp(){
  while (digitalRead(sarr) == LOW) {
    digitalWrite(up, HIGH);
  }
  digitalWrite(up, LOW);
}

void moveDown(){
  unsigned long time = millis();
  while (digitalRead(saba) == LOW && millis() - time < 5000) {
    digitalWrite(down, HIGH);
  }
  digitalWrite(down, LOW);
}

void grabAndDrop(){
  iman = !iman;
  digitalWrite(eMag, iman);
  delay(200);
}






