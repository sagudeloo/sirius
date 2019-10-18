//Definición de pines
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
        
      case 'd':
        digitalWrite(eMag, LOW);
        break;
    }

    tamano();
    preguntarPosHor();
    preguntarPosVer();

  }
}

/*
Método encargado de recuperar el tamaño del disco con el que se esté manteniendo contacto. Se realiza mediante la comunicación 
directa con el puerto, y se saca la informacipon del mismo.
b: big
m: medium
s: small
*/
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

/*
Método encargado de recuperar la posición horizontal en la que el electroimán se encuentre (P1, P2, P3) y la retorna en la 
variable pos
*/
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

/*
Método que retorna la posición vertical en la que el electroimán se encuentre (arriba o abajo), todo esto mediante sensores que
que activan cuando el electroimán pase por ellos.
1: Arriba
2: Abajo
*/
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
