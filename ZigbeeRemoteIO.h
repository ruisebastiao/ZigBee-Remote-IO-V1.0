#ifndef __ZIGBEEREMOTEIO
#define __ZIGBEEREMOTEIO
  #define MAXZIGBEEID 16
  #define MAXZIGBEEFRAME 100
  #define ZIGBEEDEVICES 2


  unsigned short  LocalIP[2];
  // setup outputs
  sbit PICOUT1 at LATA0_bit;
  sbit PICOUT1_Direction at TRISA0_bit;

  sbit PICOUT2 at LATA1_bit;
  sbit PICOUT2_Direction at TRISA1_bit;

  sbit PICOUT3 at LATA2_bit;
  sbit PICOUT3_Direction at TRISA2_bit;

  sbit PICOUT4 at LATA3_bit;
  sbit PICOUT4_Direction at TRISA3_bit;

  // setup inputs
  sbit PICIN1 at PORTB.B0;
  sbit PICIN1_Direction at TRISB0_bit;

  sbit PICIN2 at PORTB.B1;
  sbit PICIN2_Direction at TRISB1_bit;

  sbit PICIN3 at PORTB.B2;
  sbit PICIN3_Direction at TRISB2_bit;

  sbit PICIN4 at PORTB.B3;
  sbit PICIN4_Direction at TRISB3_bit;

  sbit USBON at PORTB.B4;
  sbit USBON_Direction at TRISB3_bit;

   sbit PROG at RB5_bit;
  sbit PROG_Direction at TRISB5_bit;


  int DebounceVal=0;

  
  char MY1[8]={0x7E,0x00,0x04,0x08,0x01,0x4D,0x59,0x50};
  char ND[8]= {0x7E,0x00,0x04,0x08,0x01,0x4E,0x44,0x64};
  unsigned char readbuff[64] absolute 0x600;   // Buffers should be in USB RAM, please consult datasheet
  unsigned char writebuff[64] absolute 0x640;
  //---------------------------------------------------------------------------------------------------

  typedef struct {
         unsigned Enabled;
         short Connected;
         short LastConnected;
         unsigned short *Address64;
         unsigned short *Address16;
  }ZigbeeSendDeviceInfo;



  ZigbeeSendDeviceInfo ZigbeeSendDevices[ZIGBEEDEVICES];



  typedef struct {
         short IONum;
         int LastState;
         int Debounce;
         short WaitDebounce;
         char Name[6];
  }IOInfo;



  IOINFO Inputs[4];
  IOINFO Outputs[4];

  int debug=0;
  int JoinedToNet=0;
  int JoinedLastState=0;
  
  char Rx_char;

  int frameindex=0,framesize=MAXZIGBEEFRAME-1;
  char ZigbeeFrame[MAXZIGBEEFRAME];
  char GotFrame=0;


 void SendIOsToDevice(char *deviceAddress);

#endif