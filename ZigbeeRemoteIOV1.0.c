  #include <ZigbeeRemoteIO.h>
  #define ZIGBEEDEVICES 2
  char MY1[8]={0x7E,0x00,0x04,0x08,0x01,0x4D,0x59,0x50};
  unsigned char readbuff[64] absolute 0x600;   // Buffers should be in USB RAM, please consult datasheet
  unsigned char writebuff[64] absolute 0x640;
  //---------------------------------------------------------------------------------------------------
  
  typedef struct {
         unsigned short enabled;
         char *Address;
  }ZigbeeSendDeviceInfo;
  
  ZigbeeSendDeviceInfo ZigbeeSendDevices[ZIGBEEDEVICES];
  
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


  int debug=0;
  int   JoinedToNet=-1;

  char Rx_char;

  int frameindex=0,framesize=MAXZIGBEEFRAME-1;
  char ZigbeeFrame[MAXZIGBEEFRAME];
  char GotFrame=0;

  char *DeleteChar (char *str, char oldChar) {
    char *strPtr = str;
    while ((strPtr = strchr (strPtr, oldChar)) != 0)
        *strPtr++ = '\0';
    return str;
}



void SendRawPacket(char* RawPacket,int len)
{
   int i;

   for( i=0; i<len; i++ )
   {
      UART1_Write( RawPacket[i]);
   }

}

void SendDataPacket(short brodcast,char* DataPacket,int len,char Ack)
{
   int k=0,i, framesize2=14+len;
   char DataToSend[50];
   unsigned short checkSum=0;
   ZigbeeSendDeviceInfo  ZigbeeSendDevice;
   
   do{
   
    ZigbeeSendDevice=ZigbeeSendDevices[k];
    
    if(ZigbeeSendDevice.enabled==1 || brodcast==1){
       DataToSend[0]=0x7E;
       DataToSend[1]=0x00;

       DataToSend[2]=framesize2;
       DataToSend[3]=0x10;
       DataToSend[4]=0x01;


       if( brodcast==1 )
       {
          //Broadcast
          DataToSend[5]=0;
          DataToSend[6]=0;
          DataToSend[7]=0;
          DataToSend[8]=0;
          DataToSend[9]=0;
          DataToSend[10]=0;
          DataToSend[11]=0;
          DataToSend[12]=0;
       }
       else
       {

           //Specific adress
           DataToSend[5]=ZigbeeSendDevice.Address[0];
           DataToSend[6]=ZigbeeSendDevice.Address[1];
           DataToSend[7]=ZigbeeSendDevice.Address[2];
           DataToSend[8]=ZigbeeSendDevice.Address[3];
           DataToSend[9]=ZigbeeSendDevice.Address[4];
           DataToSend[10]=ZigbeeSendDevice.Address[5];
           DataToSend[11]=ZigbeeSendDevice.Address[6];
           DataToSend[12]=ZigbeeSendDevice.Address[7];
       }
           //
       DataToSend[13]=0xFF;
       DataToSend[14]=0xFE;
       //
       DataToSend[15]=0x00;
       //
       DataToSend[16]=0x01;

       //Data
       for( i=17; i<17+len; i++ )
       {
        DataToSend[i]=DataPacket[i-17];
        }


        for( i=3; i<framesize2+3; i++ )
        {
         checkSum=checkSum+DataToSend[i];
        }

        checkSum=0xFF-checkSum;

        //checksum
        DataToSend[i]=checkSum;
        if(debug==1 && USBON){
          sprinti(writebuff,"Packet: ");
          while(!hid_write(writebuff,64));
        }
   
        for( i=0; i<framesize2+4; i++ )
        {
          UART1_Write( DataToSend[i]);
          if(debug==1 && USBON){
            sprinti(writebuff,"%X",DataToSend[i]);
            while(!hid_write(writebuff,64));
          }
        }
        if(debug==1 && USBON){
          sprinti(writebuff,"\n");
          while(!hid_write(writebuff,64));
        }
        if(brodcast==1) break;
       }
       }
       while(k<ZIGBEEDEVICES);
}

void ProcessZigBeeDataPacket(char* DataPacket,char *DevIP)
{

 char *CommandTrimmed[10];
   char del[2] = "|";

   int i=0;

   if((debug==2 || debug==1) && USBON){
       sprinti(writebuff, "ZIGBEE|%s\n",DataPacket);
       while(!hid_write(writebuff,64));
     }
     
/* get the first token */
       CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(DataPacket,'\r'),'\n'), del);

     /* walk through other tokens */
     do
     {

        i++;
        CommandTrimmed[i] = strtok(0, del);

     }
     while( CommandTrimmed[i] != 0 );




     
     if(strcmp(CommandTrimmed[0],"OUT")==0){
          if(strcmp(CommandTrimmed[1],"1")==0){
               if(strcmp(CommandTrimmed[2],"ON")==0){
                   PICOUT1=1;
               }
               else if(strcmp(CommandTrimmed[2],"OFF")==0){
                  PICOUT1=0;
               }
          }
          else  if(strcmp(CommandTrimmed[1],"2")==0){
               if(strcmp(CommandTrimmed[2],"ON")==0){
                   PICOUT2=1;
               }
               else if(strcmp(CommandTrimmed[2],"OFF")==0){
                  PICOUT2=0;
               }
          }
          else if(strcmp(CommandTrimmed[1],"3")==0){
               if(strcmp(CommandTrimmed[2],"ON")==0){
                   PICOUT3=1;
               }
               else if(strcmp(CommandTrimmed[2],"OFF")==0){
                  PICOUT3=0;
               }
          }
          else if(strcmp(CommandTrimmed[1],"4")==0){
               if(strcmp(CommandTrimmed[2],"ON")==0){
                   PICOUT4=1;
               }
               else if(strcmp(CommandTrimmed[2],"OFF")==0){
                  PICOUT4=0;
               }
          }
     }


//   PICOUT1=!PICOUT1;
}



void ProcessZigBeeFrame()
{
   int i;
   int FrameType=0;

   char ZigbeeDataPacket[50];
   char ATCommand[2]={0x00, 0x00};
   char CoordinatorAdress[8];
   char DeviceAdress[2];
   char DeviceMAC[8];
   char DeviceID[MAXZIGBEEID];
   char SenderMac[8];
   char SenderAddress[3];




   //Frame type
   FrameType=ZigbeeFrame[3];

   //Data Frame
   if( FrameType==0x90 )
   {

      for( i=4; i<=11; i++ )
      {
         //Sender MAC
         SenderMac[i-4]=ZigbeeFrame [ i ];
      }


      for( i=12; i<=13; i++ )
      {

         SenderAddress[i-12]=ZigbeeFrame[ i ];
      }

      SenderAddress[i-12]='\0';
      for( i=15; i<=framesize+2; i++ )
      {
         //Data Packet
         ZigbeeDataPacket[i-15]=ZigbeeFrame[ i ];
      }

      ZigbeeDataPacket[i-15]='\0';

      ProcessZigBeeDataPacket( ZigbeeDataPacket, SenderAddress );
   }

   //Node indentification Response
   else if( FrameType==0x95 )
   {

      DeviceAdress[0]=ZigbeeFrame [12];
      DeviceAdress[1]=ZigbeeFrame [13];

      for( i=4; i<12; i++ )
      {
         DeviceMAC[i-4]=ZigbeeFrame[i];
      }


      for( i=0; i<MAXZIGBEEID; i++ )
      {
         DeviceID[i]=ZigbeeFrame[i+26];
         if( DeviceID[i]==0x00 )break;
      }

   }

   //Node Discovery Response
   else if( FrameType==0x88 )
   {

      //if( JoinedToNet<2 ){
//        JoinedToNet=2;
  //
    //    }

      ATCommand[0]=ZigbeeFrame [ 5 ];
      ATCommand[1]=ZigbeeFrame [ 6 ];

      //Command Status-0x00=OK
      if( ZigbeeFrame [7]==0x00 )
      {

         if( ATCommand[0]=='N'&&ATCommand[1]=='D' )
         {
            DeviceAdress[0]=ZigbeeFrame [8];
            DeviceAdress[1]=ZigbeeFrame [9];

            if( JoinedToNet<2 ){
                JoinedToNet=2;
                if((debug==2 || debug==1) && USBON){
                  strcpy(writebuff, "ZIGBEE|JOINED\n");
                  while(!hid_write(writebuff,64));
                }
              }

            for( i=10; i<18; i++ )
            {
               DeviceMAC[i-10]=ZigbeeFrame[i];
            }




            for( i=0; i<MAXZIGBEEID; i++ )
            {
               DeviceID[i]=ZigbeeFrame[i+19];
               if( DeviceID[i]==0x00 )break;
            }



            }else if( ATCommand[0]=='M'&&ATCommand[1]=='Y' ){
              LocalIP[0]=ZigbeeFrame [8];
              LocalIP[1]=ZigbeeFrame [9];

            if( LocalIP[0]!=0xFF&&LocalIP[1]!=0xFE )
            {

               JoinedToNet=2;
               if((debug==2 || debug==1) && USBON){
                  strcpy(writebuff, "ZIGBEE|JOINED\n");
                  while(!hid_write(writebuff,64));
               }

            }

            else
            {
               JoinedToNet=0;

                if((debug==2 || debug==1) && USBON){
                 sprinti(writebuff, "ZIGBEE|NONETWORK\n");
                 while(!hid_write(writebuff,64));
               }

            }
         }
      }
   }

   else if( FrameType==0x8A )
   {

      //No NetWork
      if( ZigbeeFrame[4]==0x03 )
      {

      if((debug==2 || debug==1) && USBON){
          sprinti(writebuff, "ZIGBEE|NONETWORK\n");
          while(!hid_write(writebuff,64));
        }
         JoinedToNet=0;
      }

      //Joined a Network
      else if( ZigbeeFrame[4]==0x02 )
      {


         if( JoinedToNet<2 ){
           JoinedToNet=2;

           if((debug==2 || debug==1) && USBON){
            strcpy(writebuff, "ZIGBEE|JOINED\n");
            while(!hid_write(writebuff,64));
          }
         }


      }


   }


   //Node Data Response
   else if( FrameType==0x8B )
   {

      if( ZigbeeFrame[8]==0x00 )
      {
         if( JoinedToNet<2 ){
           JoinedToNet=2;

          if((debug==2 || debug==1) && USBON){
          strcpy(writebuff, "ZIGBEE|JOINED\n");
          while(!hid_write(writebuff,64));
        }
        }
      }

      //ack failure
      else if( ZigbeeFrame[8]==0x21 )
      {

         JoinedToNet=0;

          if((debug==2 || debug==1) && USBON){
          sprinti(writebuff, "ZIGBEE|NONETWORK|ACK FAILED\n");
          while(!hid_write(writebuff,64));
        }

      }
   }
/*if( usbConnected )
   {
      if( Debug )
      {
         printf( usb_cdc_putc, ">ZIGBEE|RECDATA|" );
         for( i=0; i<framesize+4; i++ )
         {
            printf( usb_cdc_putc, "%LX", ZigbeeFrame[i] );
         }

         printf( usb_cdc_putc, "\n" );
      }
   }*/


}

  char frame_started=0;

  void interrupt()
  {



      if(USBIF_Bit && USBON){
       USB_Interrupt_Proc();                   // USB servicing is done inside the interrupt
       }

        if (PIR1.RCIF) {          // test the interrupt for uart rx
           if (UART1_Data_Ready() == 1) {
             Rx_char = UART1_Read();  //
             if(Rx_char==0x7E){
                frameindex=0;
                frame_started=1;

             }

             if(frame_started==1){
               ZigbeeFrame[frameindex]=Rx_char;
  
               if( frameindex==2 )
               {
                  framesize=ZigbeeFrame[1]+ZigbeeFrame[2];
               }
      
               frameindex++;
               if( frameindex>=framesize+4 )
               {

                 frameindex=0;
                 frame_started=0;
                 GotFrame=1;

               }
              }
            }
        }

  }

  unsigned short  PICIN1LastState,PICIN2LastState,PICIN3LastState,PICIN4LastState;
  int debounc_in1=0,debounc_in2=0,debounc_in3=0,debounc_in4=0;
  int JoinedLastState=0;
  
  void ProcessInputs(){

       if(JoinedLastState!=JoinedToNet){
          JoinedLastState=JoinedToNet;
          PICIN1LastState=!PICIN1;
          PICIN2LastState=!PICIN2;
          PICIN3LastState=!PICIN3;
          PICIN4LastState=!PICIN4;


       }
   //   if(JoinedToNet==2){
       if(PICIN1LastState!=PICIN1){
              if(debounc_in1>5){
                debounc_in1=0;
                PICIN1LastState= PICIN1;
                if((debug==1 || debug==2) && USBON){
                  sprinti(writebuff,"IN 1|%u \n",PICIN1LastState);
                  while(!hid_write(writebuff,64));
                }
                if(PICIN1LastState)
                 SendDataPacket(0,"OUT|1|OFF",9,0);
                else
                  SendDataPacket(0,"OUT|1|ON",8,0);
              }
              else
               debounc_in1++;

       }
       if(PICIN2LastState!=PICIN2){

              if(debounc_in2>5){
                debounc_in2=0;
                PICIN2LastState= PICIN2;
                if((debug==1 || debug==2) && USBON){
                  sprinti(writebuff,"IN 2|%u\n",PICIN2LastState);
                  while(!hid_write(writebuff,64));
                }
                if(PICIN2LastState){
                 SendDataPacket(0,"OUT|2|OFF",9,0);
                }
                else{
                  SendDataPacket(0,"OUT|2|ON",8,0);
                }
              }
              else
               debounc_in2++;
       }
       if(PICIN3LastState!=PICIN3){
              if(debounc_in3>5){
                debounc_in3=0;
                PICIN3LastState= PICIN3;
                if((debug==1 || debug==2) && USBON){
                  sprinti(writebuff,"IN 3|%u\n",PICIN3LastState);
                  while(!hid_write(writebuff,64));
                }
                if(PICIN3LastState)
                 SendDataPacket(0,"OUT|3|OFF",9,0);
                else
                  SendDataPacket(0,"OUT|3|ON",8,0);
              }
              else
               debounc_in3++;
       }
       if(PICIN4LastState!=PICIN4){
              if(debounc_in4>5){
                debounc_in4=0;
                PICIN4LastState= PICIN4;
                if((debug==1 || debug==2) && USBON){
                  sprinti(writebuff,"IN 4|%u\n",PICIN4LastState);
                  while(!hid_write(writebuff,64));
                }
                if(PICIN4LastState)
                 SendDataPacket(0,"OUT|4|OFF",9,0);
                else
                  SendDataPacket(0,"OUT|4|ON",8,0);
              }
              else
               debounc_in4++;
       }
   //  }

  }
  

  
  void write_eeprom_from(short startaddress,char *str){
       char hexstr[2];
       short hexval;
       int i=0,j=0;
       for(i=0;i<strlen(str)*2;i=i+2){
         hexstr[0]=str[i];
         hexstr[1]=str[i+1];
         hexval=xtoi(hexstr);
         EEPROM_Write(startaddress+j,hexval);
         j++;
      }
  }
  
  void read_eeprom_to(short startadress,char *dest){
    int i;

   for(i=0;i<8;i++){
     dest[i]=EEPROM_Read(startadress+i);

     // ByteToHex(HostZigbeeShort[k],str+i);
//      ByteToHex(EEPROM_Read(0x01+k),str+i+1);
//      k++;
      }
//     str[17]='\0';
  }
  void main() {

   int i, MY_retry=0;

   char DataCharReceived;
   char *CommandTrimmed[10];
   char del[2] = "|";
   char eeprom_readed;
   short readaddress=0x01;
   
   delay_ms(1000);
   
   UART1_Init(9600);
   
   MM_Init();

   for(i=0;i<ZIGBEEDEVICES;i++){

         ZigbeeSendDevices[i].enabled=EEPROM_Read(readaddress++);
         ZigbeeSendDevices[i].Address=(unsigned short*)malloc(sizeof(char) *8);
         
         read_eeprom_to(readaddress,ZigbeeSendDevices[i].Address);

        readaddress+=8;
   }

//   HostZigbee=;
   
   
    // Init Outputs

   PICOUT1_Direction=0;
   PICOUT1=0;
   PICOUT2_Direction=0;
   PICOUT2=0;
   PICOUT3_Direction=0;
   PICOUT3=0;
   PICOUT4_Direction=0;
   PICOUT4=0;


    // Init Inputs

   PICIN1_Direction=1;
   PICIN2_Direction=1;
   PICIN3_Direction=1;
   PICIN4_Direction=1;
   USBON_Direction=1;
   PROG_Direction=1;

   ADCON0 |= 0x0F;                         // Configure all ports with analog function as digital
   ADCON1 |= 0x0F;                         // Configure all ports with analog function as digital
   ADCON2 |= 0x0F;                         // Configure all ports with analog function as digital
   CMCON  |= 7;
     

     
 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 PIE1.RCIE = 1; //enable interrupt.
 

    if(USBON)
     HID_Enable(readbuff,writebuff);      // Enable HID communication


   
   debug=0;


   SendRawPacket(MY1, 8);
   while(1)
   {

   
   if(GotFrame==1){
      GotFrame=0;
     ProcessZigBeeFrame();

   }
    
    
     ProcessInputs();
/*if(PROG==0){
          delay_ms(100);
          strcpy(writebuff,"PROG\n");
         while(!hid_write(writebuff,64));
     }*/
    
    if(JoinedToNet==0){
      PICOUT1=1;
      PICOUT2=0;
    }
    
    if(JoinedToNet==2){
      PICOUT2=1;
      PICOUT1=0;
    }
     if(USBON){
      if(!(hid_read()==0)) {
       i=0;
       


     /* get the first token */
       CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(readbuff,'\r'),'\n'), del);

     /* walk through other tokens */
     do
     {

        i++;
        CommandTrimmed[i] = strtok(0, del);

     }
     while( CommandTrimmed[i] != 0 );
     

     
     if(strcmp(CommandTrimmed[0],"UPGRADE")==0){
         sprinti(writebuff,"UPGRADING\n");
         while(!hid_write(writebuff,64));
         EEPROM_Write(0x00,0x01);
         HID_Disable();
         Delay_ms(1000);
         asm { reset; }
     } else if(strcmp(CommandTrimmed[0],"SET")==0){
       if(strcmp(CommandTrimmed[1],"DEBUG")==0){
         int debug_val=0;
         debug_val=atoi(CommandTrimmed[2]);
         debug=debug_val;
         sprinti(writebuff,"DEBUG|%d\n",debug_val);
         while(!hid_write(writebuff,64));
        }
     }
      else if(strcmp(CommandTrimmed[0],"SEND")==0){
        SendDataPacket(0,CommandTrimmed[1],strlen(CommandTrimmed[1]),0);
        //UART1_Write(0x7E);
     }
     else if(strcmp(CommandTrimmed[0],"?")==0){

        sprinti(writebuff,"KPP ZIGBEE BOARD V1.1\n");
        while(!hid_write(writebuff,64));
     }

     else if(strcmp(CommandTrimmed[0],"ZIGBEE")==0){
     
          if(strcmp(CommandTrimmed[1],"SET")==0){
             if(strcmp(CommandTrimmed[2],"DEVICE")==0){
               int devnum=0;
               devnum=atoi(CommandTrimmed[3]);
               if(devnum>0 && devnum-1<ZIGBEEDEVICES){
                 int enabledval;
                 enabledval=atoi(CommandTrimmed[4]);
                 if(enabledval==0 || enabledval==1){
                   write_eeprom_from(0x01+(devnum-1)*8,CommandTrimmed[5]);
                   delay_ms(100);
                   write_eeprom_from(0x02+(devnum-1)*8,CommandTrimmed[4]);
                   delay_ms(100);
                   read_eeprom_to(0x01+(devnum-1)*8,ZigbeeSendDevices[i].enabled);
                   delay_ms(100);
                   read_eeprom_to(0x02+(devnum-1)*8,ZigbeeSendDevices[i].Address);
                 }
               }
             }
          }

          else if(strcmp(CommandTrimmed[1],"GET")==0){
               if(strcmp(CommandTrimmed[2],"DEVICE")==0){
               int devnum=0;
               devnum=atoi(CommandTrimmed[3]);
               if(devnum>0 && devnum-1<ZIGBEEDEVICES){
                 int i,k=0;
                 char hexval[3];
                 char HostZigbeeStr[16];
                 for(i=0;i<8;i++){
                   ShortToHex(ZigbeeSendDevices[devnum-1].Address,HostZigbeeStr+k);
                   k=k+2;
                 }
                 sprinti(writebuff,"ZIGBEE|DEVICE|%d|%s|%u\n",devnum,HostZigbeeStr,ZigbeeSendDevices[devnum-1].enabled);
                 while(!hid_write(writebuff,64));
                }
               }
          }
           else if(strcmp(CommandTrimmed[1],"MY")==0){
             SendRawPacket(MY1, 8);
          }
     }
     
  }
          
  }

 }

 Delay_ms(1);

}