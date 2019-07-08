#include <LiquidCrystal.h> //Librería para el LCD
LiquidCrystal lcd(7, 8, 9, 10, 11, 12); //    LCD: pines de control y de datos (RS, EN, d4, d5, d6, d7)
//Entrada de todos los pines:
const int Sensor =0;       //Entrada del sensor de temperatura LM35  
int ledrojo=5;            
int ledamarillo=6;
int ledverde=4;
float voltaje;             //Variable de calculo
float temperatura;         //Variable de resultado final
int PinPWM = 3;            //Para el ventilador, para poder variar el DC

void setup() {
          pinMode(ledrojo,OUTPUT);
          pinMode(ledamarillo,OUTPUT);
          pinMode(ledverde,OUTPUT);
          Serial.begin(9600); //Para ver los serialPrint por Monitor Serial, 9600 es la velocidad de muestreo. 
          lcd.begin(16, 2);   //Para fijar el numero de columnas y de filas del LCD.
}
void loop ()
{         float lectura = analogRead(Sensor); 
          voltaje = (5.0/1023.0) * lectura; //Convierte la lectura analogica de 0-1023V a un Voltaje de 0-5 volts.
          temperatura = (voltaje*100)/9.7 ; //Calculamos la temperatura, si salian 1,76V de la salida del amplificador, la Temperatura 
          //es de 18°C (por la ganancia del amplificador que es de 9,7 aprox.).
          
          //Para visualizar la temperatura por el monitor serial:
          Serial.print("Temperatura:"); //Imprime "temperatura" para verlo por el monitor serial.
          Serial.println(temperatura); //Imprime la temperatura con un SALTO de linea (si fuera solo Serial.print(temperatura) no lo hace). 
          Serial.print("Grados Celsius.");
          //Para visualizar el voltaje por el monitor serial:
          Serial.print("Voltaje:");
          Serial.println(voltaje);

          //Control de la temperatura: 
          if (temperatura<17){
            digitalWrite (ledverde, HIGH);   //Prendo el led verde.
            digitalWrite (ledamarillo, LOW); //Apago el led amarillo.
            digitalWrite (ledrojo, LOW);     //Apago el led rojo.
            analogWrite(PinPWM,87);          //VENTILADOR A 8.6V, DC=35%.
        }
         if (temperatura>=17 && temperatura<=18){
            digitalWrite (ledverde, LOW);
            digitalWrite (ledamarillo, HIGH);
            digitalWrite (ledrojo, LOW);
            analogWrite(PinPWM,127);         //VENTILADOR A 8.6V,DC=50%.
        }
         if (temperatura>19){
            digitalWrite (ledverde, LOW);
            digitalWrite (ledamarillo, LOW);
            digitalWrite (ledrojo, HIGH);
            analogWrite(PinPWM,255);        //VENTILADOR A 8.6V,DC=100%.                                        
       }
         delay(2000);//Para evitar errores, se esperan 2000ms (2 seg) para volver a tomar la temperatura.
            //LCD:
            lcd.setCursor(0, 0);        // Ubicacion del printeo de abajo, columna 0, fila 0.
            lcd.print("Temperatura:");  // Printeo "temperatura".             
            lcd.setCursor(0, 1);        // Ubicacion del printeo de abajo.
            lcd.print(temperatura);     // Printeo la temperatura sea amarillo, verde o rojo.            
            lcd.setCursor(4, 1);        //Columna 4, fila 1.
            lcd.print((char)223);       //Printeo °
            lcd.setCursor(5,1);         //Columna 5, fila 1.
            lcd.print('C');             //Printeo C
}
