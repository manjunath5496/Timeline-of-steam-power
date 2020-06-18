
#include <msp430x22x4.h>
#include "crc.h"

// radio constants
#define START 0xFF
#define ESC 0xFE
#define RX_COMPLETE 9
#define RX_IDLE 10
#define TX_COMPLETE 17

// other constants
#define MOTOR_VOLTAGE 6.0
#define K_VOLTAGE 0.0293

unsigned char rx_i = RX_IDLE;
volatile unsigned char tx_i = TX_COMPLETE;
unsigned char rx_data[9];
unsigned char tx_data[17];
unsigned char command[4];
unsigned char motor[4];
unsigned char digital;
unsigned int analog[4];
unsigned int battery;
unsigned int signal;

float vscale;
unsigned int duty[4];

int inits(void);
int rx(void);
int tx(void);
int adc(void);

#pragma vector=USCIAB0RX_VECTOR
__interrupt void UART_RX(void)
{
  unsigned char rx_byte;
  rx_byte = UCA0RXBUF;
  
  if(rx_byte == START)  
  { 
    rx_data[0] = START;
    rx_i = 1;
  }
  else if(rx_i <= 8)
  {
    rx_data[rx_i] = rx_byte;
    rx_i++;
  }	

}

#pragma vector=USCIAB0TX_VECTOR
__interrupt void UART_TX(void)
{
  // when TX data is clear, transmit next byte
  if(tx_i < TX_COMPLETE)
  { 
    UCA0TXBUF = tx_data[tx_i];
    tx_i++;
  }
  IFG2 &= ~UCA0TXIFG;
}

int main(void)
{
  unsigned char i = 0;
  unsigned char n = 0;
  
  // Stop watchdog timer to prevent time out reset.
  WDTCTL = WDTPW + WDTHOLD;
  // global interrupt enable
  _EINT();
  // initialization routine
  inits();
  
  while(1)
  {
    if(rx_i == RX_COMPLETE)
    {
      if(rx())
      {
        
        if(n == 0)
        {
          vscale = ((float) battery * K_VOLTAGE) / MOTOR_VOLTAGE * 255.0;
          TACCR0 = (int) vscale;
          TBCCR0 = (int) vscale;
        }
        n++;
        if(n >= 30) { n = 0; }
        
        for(i = 0; i <= 3; i++)
        {
          motor[i] = command[i];
          if(motor[i] > 128)
          {
            duty[i] = (motor[i] - 127) << 1;
            P1OUT |= (0x10 << i);
          }
          else if(motor[i] < 127)
          {
            duty[i] = (127 - motor[i]) << 1;
            P1OUT &= ~(0x10 << i);
          }
          else
          {
            duty[i] = 0;
          }
        }
  
        TACCR1 = duty[0];
        TACCR2 = duty[1];
        TBCCR1 = duty[2];
        TBCCR2 = duty[3];
        adc();
        tx();
        P4OUT ^= BIT7;
      }
      else
      {
      }
      rx_i = RX_IDLE;
    }
  }

  return 0;
}

int adc(void)
{
  // handles analog-to-digital conversion
  unsigned char i;
  
  for(i = 0; i <= 3; i++)
  {
    ADC10CTL1 = (ADC10CTL1 & 0xFFF) | ((12 + i) << 12);
    ADC10CTL0 |= ENC | ADC10SC;
    while((ADC10CTL1 & ADC10BUSY) != 0);
    analog[i] = ADC10MEM;
    ADC10CTL0 &= ~(ENC | ADC10SC);
  }
  
  ADC10CTL1 = (ADC10CTL1 & 0xFFF) | (6 << 12);
  ADC10CTL0 |= ENC | ADC10SC;
  while((ADC10CTL1 & ADC10BUSY) != 0);
  battery = ADC10MEM;
  ADC10CTL0 &= ~(ENC | ADC10SC);
  
  ADC10CTL1 = (ADC10CTL1 & 0xFFF) | (7 << 12);
  ADC10CTL0 |= ENC | ADC10SC;
  while((ADC10CTL1 & ADC10BUSY) != 0);
  signal = ADC10MEM;
  ADC10CTL0 &= ~(ENC | ADC10SC);
  
  return 1;
}
  

int tx(void)
{
  unsigned char i;
  unsigned char tx_crc = CRC_SEED;
  unsigned char rflags1 = 0x00;
  unsigned char rflags2 = 0x00;
  
  // fill TX data
  tx_data[0] = START;
  tx_data[1] = motor[0];
  tx_data[2] = motor[1];
  tx_data[3] = motor[2];
  tx_data[4] = motor[3];
  tx_data[5] = digital;
  tx_data[6] = (unsigned char) (analog[0] >> 2);
  tx_data[7] = (unsigned char) (analog[1] >> 2);
  tx_data[8] = (unsigned char) (analog[2] >> 2);
  tx_data[9] = (unsigned char) (analog[3] >> 2);
  tx_data[10] = (analog[0] & 0x03);
  tx_data[10] |= (analog[1] & 0x03) << 2;
  tx_data[10] |= (analog[2] & 0x03) << 4;
  tx_data[10] |= (analog[3] & 0x03) << 6;
  tx_data[11] = (unsigned char) (battery >> 2);
  tx_data[12] = (unsigned char) (signal >> 2);
  tx_data[13] = 0x00;
  
  // calculate CRC
  for(i = 1; i <= 13; i++)
  {
    tx_crc = CRC8LUT[tx_data[i] ^ tx_crc]; 
  }
  tx_data[14] = tx_crc;
  
  // escape characters
  for(i = 1; i <= 7; i++)
  {
    if(tx_data[i] == START)
    {
      tx_data[i] = ESC;
      rflags1 |= 0x01 << (i - 1);
    }
  }
  tx_data[15] = rflags1;
  for(i = 1; i <= 7; i++)
  {
    if(tx_data[7 + i] == START)
    {
      tx_data[7 + i] = ESC;
      rflags2 |= 0x01 << (i - 1);
    }
  }
  tx_data[16] = rflags2;
  
  // begin transmission
  tx_i = 1;
  UCA0TXBUF = START;
  
  return 1;
}

int rx(void)
{
  unsigned char i;
  unsigned char rflags;
  unsigned char rx_crc = CRC_SEED;

  rflags = rx_data[8];
  for(i = 1; i <= 7; i++)
  {
    if((rflags & 0x01 << (i - 1)) != 0x00)
    {
      rx_data[i] = START;
    }
  }
  for(i = 1; i <= 6; i++)
  {
    rx_crc = CRC8LUT[rx_data[i] ^ rx_crc];
  }
  if(rx_data[7] != rx_crc)
  {
    return 0;
  } 

  for(i = 0; i <= 3; i++)
  {
    command[i] = rx_data[i + 1];
  }
  
  return 1;
}

int inits(void)
{
  // 16MHz clock setup: MCLK = 16MHz, SMCLK = 4MHz
  BCSCTL1 = XT2OFF | XTS;
  BCSCTL2 = SELM1 | SELM0 | SELS | DIVS1;
  BCSCTL3 = LFXT1S1;
  
  // pin setup:
  // 1.4-1.7: direction outputs
  P1DIR |= (BIT4 | BIT5 | BIT6 | BIT7);
  P1OUT &= ~(BIT4 | BIT5 | BIT6 | BIT7);
  // 1.2-1.3, 4.1-4.2: PWM outputs, controlled by timers
  P1DIR |= (BIT2 | BIT3);
  P1SEL |= (BIT2 | BIT3);
  P4DIR |= (BIT1 | BIT2);
  P4SEL |= (BIT1 | BIT2);
  // 4.3-4.6, 3.6-3.7: analog inputs
  P4DIR &= ~(BIT3 | BIT4 | BIT5 | BIT6);
  P3DIR &= ~(BIT6 | BIT7);
  // 2.0-2.1, 4.0, 1.0: configuration inputs, pull-ups enabled
  P2DIR &= ~(BIT0 | BIT1);
  P2OUT |= (BIT0 | BIT1);
  P2REN |= (BIT0 | BIT1);
  P4DIR &= ~(BIT0);
  P4OUT |= (BIT0);
  P4REN |= (BIT0);
  P1DIR &= ~(BIT0);
  P1OUT |= (BIT0);
  P1REN |= (BIT0);
  // 3.4-3.5: UART TX and RX
  P3DIR |= (BIT4); P3DIR &= ~(BIT5);
  P3SEL |= (BIT4 | BIT5);
  // 4.7: status LED output
  P4DIR |= (BIT7);
  P4OUT &= ~(BIT7);
  
  // Timer A setup: 0 (SET) ... TACCRx (CLEAR) ... TACCR0 @ 16MHz
  TACTL = TASSEL0 | MC0;
  TACCR0 = 0x03FF;
  TACCTL1 = OUTMOD2 | OUTMOD1 | OUTMOD0;
  TACCTL2 = OUTMOD2 | OUTMOD1 | OUTMOD0;
	
  // Timer B setup: 0 (SET) ... TBCCRx (CLEAR) ... TBCCR0 @ 16MHz
  TBCTL = TBSSEL0 | MC0;
  TBCCR0 = 0x03FF;
  TBCCTL1 = OUTMOD2 | OUTMOD1 | OUTMOD0;
  TBCCTL2 = OUTMOD2 | OUTMOD1 | OUTMOD0;
  
  // ADC setup: 2.5V reference, A6-A7 and A12-15 active, use 16MHz clock
  ADC10CTL0 = SREF0 | REFOUT | REF2_5V | REFON | ADC10ON;
  ADC10CTL1 = ADC10SSEL0;
  ADC10AE0 = BIT6 | BIT7;
  ADC10AE1 = 0xF0;
  
  // UART setup: 8-E-1, 9600kbps, TX and RX interrupts enabled
  UCA0CTL0 = UCPEN | UCPAR;
  UCA0CTL1 = UCSSEL0;
  UCA0BR0 = 1666 & 0xFF; UCA0BR1 = 1666 >> 8; UCA0MCTL = UCBRF_0 | UCBRS_6;
  IE2 |= UCA0TXIE | UCA0RXIE;
  
  return 0;
}
