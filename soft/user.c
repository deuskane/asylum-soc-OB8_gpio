//-----------------------------------------------------------------------------
// Title      : kcpsm3 file for identity fonction
// Project    : Asylum
//-----------------------------------------------------------------------------
// File       : identity.c
// Author     : mrosiere
//-----------------------------------------------------------------------------
// Description:
// Read  switch
// Write led
//-----------------------------------------------------------------------------
// Copyright (c) 2021
//-----------------------------------------------------------------------------
// Revisions  :
// Date        Version  Author   Description
// 2017-03-30  1.0      mrosiere Created
// 2025-01-06  1.0      mrosiere Add comments
//-----------------------------------------------------------------------------

#include <stdint.h>
#include <intr.h>

//--------------------------------------
// Port Macro
//--------------------------------------
extern char PBLAZEPORT[];

#define PORT_WR(_ADDR_,_DATA_) PBLAZEPORT[_ADDR_] = _DATA_
#define PORT_RD(_ADDR_)        PBLAZEPORT[_ADDR_]

//--------------------------------------
// Address Map
//--------------------------------------
#define SWITCH    0x00
#define LED0      0x04
#define LED1      0x08
#define UART      0x0C

//--------------------------------------
// Global Variable
//--------------------------------------
static char cpt;

//--------------------------------------
// Null function
//--------------------------------------
void null (void)
{
  // Empty
}

//--------------------------------------
// putchar : send char into uart
// puthex  : translate byte into ascii and send into uart
//--------------------------------------
#ifdef HAVE_UART
#define putchar(c) PORT_WR(UART, c)

void puthex(uint8_t byte) {
  uint8_t msb = byte >> 4;
  uint8_t lsb = byte & 0x0F;

  if (msb>9)
    putchar('A'+msb-10);
  else
    putchar('0'+msb);

  if (lsb>9)
    putchar('A'+lsb-10);
  else
    putchar('0'+lsb);

  null();
}
#else

#define putchar(c)   do {} while (0)
#define puthex(byte) do {} while (0)

#endif

//--------------------------------------
// Interrupt Sub Routine
//--------------------------------------
void isr (void) __interrupt(1)
{
  cpt ++;
  PORT_WR(LED1,cpt);

  // Workaround in sdcc :
  // The cpt STORE is update after the context restoration
  // With null call, we force to make context restoration after the update of cpu variable
  null();
}

//--------------------------------------
// Application Setup
//--------------------------------------
// Init counter
// Send counter to led
// Enable interuption
void setup (void)
{
  cpt = 0;
  PORT_WR(LED1,cpt);

  pbcc_enable_interrupt();

  null ();
}

//--------------------------------------
// Application Run Loop
//--------------------------------------
// Read Switch and write to led
void loop (void)
{
  uint8_t sw = PORT_RD(SWITCH);

#ifdef INVERT_SWITCH
  sw = ~sw;
#endif
  
  PORT_WR(LED0, sw);
  
  putchar('H');
  putchar('e');
  putchar('l');
  putchar('l');
  putchar('o');
  putchar(' ');
  puthex (sw);
  putchar('\r');
  putchar('\n');
  
  null ();
}

//--------------------------------------
// Main
//--------------------------------------
// Arduino Style, Don't modify
void main()
{
  setup ();
  while (1)
    loop ();
}