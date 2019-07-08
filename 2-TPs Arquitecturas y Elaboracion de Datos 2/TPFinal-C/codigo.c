#include <stdio.h>
#include <stdlib.h>
#include <xc.h>
#define _XTAL_FREQ 4000000
#pragma config FOSC = XT
#pragma config WDTE = OFF
#pragma config PWRTE = OFF
#pragma config BOREN = ON
#pragma config LVP = OFF
#pragma config CPD = OFF
#pragma config CP = OFF

//Defino los pines que uso para posteriormente incluir la librería lcd.h:
#define RS RD2
#define EN RD3
#define D4 RD4
#define D5 RD5
#define D6 RD6
#define D7 RD7
//Incluyo la librería lcd.h:
#include "lcd.h"

//Defino los pulsadores que representan los numeros,
//estan todos a 5V y al apretarlos a 0V, RESISTENCIAS PULL UP:
#define cero PORTCbits.RC4
#define uno PORTBbits.RB0
#define dos PORTBbits.RB1
#define tres PORTBbits.RB2
#define cuatro PORTBbits.RB3
#define cinco PORTBbits.RB4
#define seis PORTBbits.RB5
#define siete PORTBbits.RB6
#define ocho PORTBbits.RB7
#define nueve PORTCbits.RC5

//Defino el zumbador, el contacto dentro de la caja para saber si está
//cerrada o no y el pwm para usar el servo:
#define beep PORTEbits.RE2
#define contactor PORTCbits.RC0
#define pwm PORTCbits.RC2

//Defino los leds:
#define ledRojo PORTDbits.RD1
#define ledVerde PORTDbits.RD0

//Funciones auxiliares / rutinas:
int mostrarIntentos(int intentos){
    if (intentos==1){
        Lcd_Set_Cursor(2,8);
        Lcd_Write_String("Quedan 3");
        return 0;
    }
    else if (intentos==2){
        Lcd_Set_Cursor(2,8);
        Lcd_Write_String("Quedan 2");
        return 0;
    }
    else if (intentos==3){
        Lcd_Set_Cursor(2,8);
        Lcd_Write_String("Queda 1");
        return 0;
    }
    else {
        Lcd_Clear();
        Lcd_Set_Cursor(1,1);
        Lcd_Write_String("INTRUSO, ingresa");
        Lcd_Set_Cursor(2,1);
        Lcd_Write_String("la clave");
        return 1;
    }
}

char nroObtenido(){
   //Al presionar un numero SALE de la funcion nroObtenido
   //y retorna el valor que corresponde a ese num
   if(nueve==0){return '9';}
   else if(ocho==0){return '8';}
   else if(siete==0){return '7';}
   else if(seis==0){return '6';}
   else if(cinco==0){return '5';}
   else if(cuatro==0){return '4';}
   else if(tres==0){return '3';}
   else if(dos==0){return '2';}
   else if(uno==0){return '1';}
   else if(cero==0){return '0';}
   else return 'n';
}

//Función principal:
void main(){

    //Entradas y salidas de puertos:
    //Declaro todo el puerto D como salida (lcd y los 2 leds):
    TRISD=0x00;
    //Pulsadores 0 y 9 y contactor como entrada (aunque marque warnings estan bien hechos):
    TRISCbits.TRISC4=1; //pulsador 0
    TRISCbits.TRISC5=1; //pulsador 9
    TRISCbits.TRISC0=1; //contactor
    //Pwm y zumbador como salida:
    TRISCbits.TRISC2=0; //PWM
    TRISEbits.TRISE2=0; //BEEP
    //Pulsadores de 1-8como entrada:
    TRISBbits.TRISB0=1;
    TRISBbits.TRISB1=1;
    TRISBbits.TRISB2=1;
    TRISBbits.TRISB3=1;
    TRISBbits.TRISB4=1;
    TRISBbits.TRISB5=1;
    TRISBbits.TRISB6=1;
    TRISBbits.TRISB7=1;
    //Si quiero puedo hacer TRISB=11111111; para poner a todos los pulsadores (del 1-8) como entrada

    //Mando un 0 a los dos leds y al zumbador:
    ledRojo=0;
    ledVerde=0;
    beep=0;

    int intentos=0;
    int ejecucion=1;
    int estabaabierta=0; //vale 0 si esta cerrada y 1 si esta abierta.
    int error=0; //para ver los intentos
    int longitudclave=4;
    //Vector donde esta la contraseña:
    int clave[4]={'1','1','2','3'};
    //Vector donde se ingresa la clave por medio del teclado
    //y luego se compara con el vector anterior para ver si son iguales o no:
    int dato[4];
    int i=0;
    char numeroingresado;

    Lcd_Init(); //Inicio el LCD.

    Lcd_Clear(); //Limpio el LCD.
    Lcd_Set_Cursor(1,1); //Fila 1, Columna 1 del LCD.
    //Escribo "Bienvenido" en la posicion que puse anteriormente (1,1):
    Lcd_Write_String("Bienvenido");
    __delay_ms(2000); //Espero 2 seg.

    Lcd_Clear();
    Lcd_Set_Cursor(1,1);
    Lcd_Write_String("Ingrese su clave");
    int veces=0;

    //Para que el servo empiece en una posición inicial:
    while(veces<200){
    pwm=1;
    __delay_us(1000);
    pwm=0;
    __delay_us(19000);
    veces++;
    }

    while(ejecucion==1)
    {
          //While de ingreso de datos
          while(i<longitudclave)
              {
              //Le asigno al char numeroingresado, el valor char que retorna nroObtenido dependiendo de cual bonton
              //se pulso.
              numeroingresado=nroObtenido();
              if (numeroingresado!='n')
                   { dato[i]=numeroingresado; //En la posicion i (empieza en 0) lo igualo al numero que ingrese.
                     Lcd_Set_Cursor(2,i+1); //En la fila 2 (o sea abajo) y columna "i+1", escribe los **** de la
                    //contraseña ingresada.
                     Lcd_Write_Char(numeroingresado);//Si quiero que se muestre el número ingresado le paso
                    //numeroingresado, sino simplemente un ´*´.
                     __delay_ms(500); //Espero medio seg para volver a presionar otro boton.
                     i++; //Aumento i.
                   }
              }

          //Ahora los datos se procesan, comparo los 2 vectores de contraseñas
          //(la guardada y la ingresada por el usuario):
          if(dato[0]==clave[0] && dato[1]==clave[1] && dato[2]==clave[2] && dato[3]==clave[3])
          { //Si coinciden...
            Lcd_Clear();
            Lcd_Set_Cursor(1,1);
            Lcd_Write_String("Clave correcta");
            ledRojo=0;
            ledVerde=1;
            beep=0; //Apago el zumbador
            __delay_ms(500);
            if(contactor==0)
                    {
                        Lcd_Set_Cursor(2,1);
                        Lcd_Write_String("Estaba Abierta");
                        beep=1;
                        __delay_ms(1000);
                        beep=0;
                        estabaabierta=1;
                        ejecucion=0; //Para que no entre al while y tenga que reiniciar.
                    }
            else{
                    Lcd_Set_Cursor(2,1);
                    __delay_ms(500);
                    Lcd_Write_String("Destrabando");
                    __delay_ms(500);
                    int veces=0;
                    while(veces<200)
                        {
                            pwm=1;
                            __delay_us(2000);
                            pwm=0;
                            __delay_us(18000);
                            veces++;
                        }
                    estabaabierta=0;
                    Lcd_Clear();
                    Lcd_Set_Cursor(1,1); //Fila 1, Columna 1 del LCD.
                    Lcd_Write_String("Abra caja");
                }
            if (estabaabierta==0)
            {
                int esperaapertura=1;
                while (esperaapertura==1)
                {
                    if(contactor==0)
                    {
                        Lcd_Clear();
                        Lcd_Set_Cursor(1,1);
                        Lcd_Write_String("Caja abierta");
                        __delay_ms(1000);
                        esperaapertura=0;
                    }
                }
                __delay_ms(3000);
                Lcd_Clear();
                Lcd_Set_Cursor(1,1); //Fila 1, Columna 1 del LCD.
                Lcd_Write_String("Cierre caja");

                int esperacierre=1;
                while (esperacierre==1)
                    {
                        if(contactor==1)
                        {
                            Lcd_Clear();
                            Lcd_Set_Cursor(1,1);
                            Lcd_Write_String("Caja Cerrada");
                            __delay_ms(1000);
                            esperacierre=0;
                        }
                    }
                Lcd_Set_Cursor(2,1);
                __delay_ms(500);
                Lcd_Write_String("Trabando");
                __delay_ms(500);
                int veces=0;
                while(veces<200)
                    {
                        pwm=1;
                        __delay_us(1000);
                        pwm=0;
                        __delay_us(19000);
                        veces++;
                    }

                ejecucion=0; //Para que no entre al while y tenga que reiniciar.

            } //Cierre del if (estabaabierta==0).
          } //Cierre del if(dato[0]==clave[0] && dato[1]==clave[1], etc.)

          else
          {//Si no coinciden...
            Lcd_Clear();
            Lcd_Set_Cursor(1,1);
            Lcd_Write_String("Clave Incorrecta");
            intentos++;
            i=0;  //Siempre hay que volver el cursor al equivocar la clave
            ledRojo=1;
            error = mostrarIntentos(intentos);
            if (error==1)
                {
                    beep=1; //Suena la alarma hasta que ingrese la clave correcta (si es correcta hago beep=0).
                    //Estas 2 lineas de abajo no tendrían que estar, es solo para que no escuchemos
                    //siempre el zumbido en la práctica y solo sean 2 seg y se apague el zumbador.
                    __delay_ms(2000);
                    beep=0;
                    intentos=3;
                }
            //Aca NO tengo que hacer ejecucion=0; porque tiene que volver al while hasta que sea la contra correcta.
           }//Cierre del else
    }//Cierre del while(ejecucion).

    //Al terminarse el programa debemos reiniciar el sistema:
    while (1)
        {
        Lcd_Clear();
        Lcd_Set_Cursor(1,1);
        Lcd_Write_String("Reiniciar sistema");
        //El programa se quedará en este while hasta que se reinicie
        }
}//Fin del main
