/*
 * 1705081code.c
 *
 * Created: 4/18/2021 1:36:57 AM
 * Author : user
 */ 

#define F_CPU 1000000
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>

int mymatrix[8][8];
int movin=0;
//1 if the light is on.0 otherwise
void init(){
	int i,j;
	for(i=0;i<8;i++){
		for(j=0;j<8;j++) mymatrix[i][j]=0;
	}
	mymatrix[1][3]=1;
	mymatrix[1][4]=1;
	for(i=2;i<6;i++){
		mymatrix[i][2]=1;
		mymatrix[i][5]=1;
	}
	mymatrix[6][3]=1;
	mymatrix[6][4]=1;
	
	mymatrix[6][6]=1;
	//mymatrix[5][4]=1;
	//mymatrix[6][5]=1;
	//mymatrix[7][6]=1;
	return;
}

void sho(){
	int i,j;
	unsigned char ro=0,col=1,ropl;
	for(i=0;i<8;i++){
		ro=0;
		ropl=1;
		for(j=0;j<8;j++){
			if(mymatrix[j][i]==0){
				ro+=ropl;
			}
			ropl*=2;
		}
		PORTA=col;
		PORTB=ro;
		col*=2;
		_delay_ms(6.4);
		//_delay_us(6600);
	}
	return;
}

void moveup(){
	int temp[8];
	int i,j;
	for(i=0;i<8;i++) temp[i]=mymatrix[0][i];
	for(i=0;i<7;i++){
		for(j=0;j<8;j++){
			mymatrix[i][j]=mymatrix[i+1][j];
		}
	}
	for(i=0;i<8;i++) mymatrix[7][i]=temp[i];
	return;
}
ISR(INT1_vect)
{
	movin=1-movin;
	_delay_ms(50);
}

int main(void)
{
    /* Replace with your application code */
	DDRA=0b11111111;
	DDRB=0b11111111;
	int i;
	init();
	movin=0;
	GICR = (1<<INT1);
	MCUCR = 0b11111011;
	sei();
    while (1) 
    {
		if(movin==1){
			moveup();
		}
		sho();
		if(movin==1){
			for(i=0;i<4;i++) sho();
		}
    }
}

