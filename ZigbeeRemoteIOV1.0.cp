#line 1 "F:/MEOCloud/KPP/Electronica/PIC Progs/MikroC/ZigBee Remote IO V1.0/ZigbeeRemoteIOV1.0.c"
#line 1 "f:/meocloud/kpp/electronica/pic progs/mikroc/zigbee remote io v1.0/zigbeeremoteio.h"







 unsigned short LocalIP[2];

 sbit PICOUT1 at LATA0_bit;
 sbit PICOUT1_Direction at TRISA0_bit;

 sbit PICOUT2 at LATA1_bit;
 sbit PICOUT2_Direction at TRISA1_bit;

 sbit PICOUT3 at LATA2_bit;
 sbit PICOUT3_Direction at TRISA2_bit;

 sbit PICOUT4 at LATA3_bit;
 sbit PICOUT4_Direction at TRISA3_bit;


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
 unsigned char readbuff[64] absolute 0x600;
 unsigned char writebuff[64] absolute 0x640;


 typedef struct {
 unsigned Enabled;
 short Connected;
 short LastConnected;
 unsigned short *Address64;
 unsigned short *Address16;
 }ZigbeeSendDeviceInfo;



 ZigbeeSendDeviceInfo ZigbeeSendDevices[ 2 ];



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

 int frameindex=0,framesize= 100 -1;
 char ZigbeeFrame[ 100 ];
 char GotFrame=0;


 void SendIOsToDevice(char *deviceAddress);
#line 5 "F:/MEOCloud/KPP/Electronica/PIC Progs/MikroC/ZigBee Remote IO V1.0/ZigbeeRemoteIOV1.0.c"
 char *DeleteChar (char *str, char oldChar) {
 char *strPtr = str;
 while ((strPtr = strchr (strPtr, oldChar)) != 0)
 *strPtr++ = '\0';
 return str;
}

short getZigbeeIndex(char *Address64,char *Address16){
 int i=0;
 if(Address64!=0){
 for(i=0;i< 2 ;i++){
 if(strncmp(Address64,ZigbeeSendDevices[i].Address64,8)==0){
 return i;
 }
 }
 }

 if(Address16!=0){
 for(i=0;i< 2 ;i++){
 if(strcmp(Address16,ZigbeeSendDevices[i].Address16)==0){
 return i;
 }
 }
 }

 return -1;
}

void SendRawPacket(char* RawPacket,int len)
{
 int i;

 for( i=0; i<len; i++ )
 {
 UART1_Write( RawPacket[i]);
 }

}
void SendDataPacket(char *sendto,char* DataPacket,int len,char Ack);

void SendDataPacket2All(char* DataPacket,int len,char Ack){
 int i=0;
 for(i=0;i< 2 ;i++){
 if(ZigbeeSendDevices[i].Enabled==1 && ZigbeeSendDevices[i].Connected==1){
 SendDataPacket(ZigbeeSendDevices[i].Address64,DataPacket,len,Ack);
 }
 }
}

void SendDataPacket(char *sendto,char* DataPacket,int len,char Ack)
{
 int k=0;

 int i=0, framesize2=14+len;
 char DataToSend[50];
 unsigned short checkSum=0;




 DataToSend[0]=0x7E;
 DataToSend[1]=0x00;

 DataToSend[2]=framesize2;
 DataToSend[3]=0x10;
 DataToSend[4]=0x01;


 if( sendto==0 )
 {

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


 DataToSend[5]=sendto[0];
 DataToSend[6]=sendto[1];
 DataToSend[7]=sendto[2];
 DataToSend[8]=sendto[3];
 DataToSend[9]=sendto[4];
 DataToSend[10]=sendto[5];
 DataToSend[11]=sendto[6];
 DataToSend[12]=sendto[7];
 }

 DataToSend[13]=0xFF;
 DataToSend[14]=0xFE;

 DataToSend[15]=0x00;

 DataToSend[16]=0x01;


 for( i=17; i<17+len; i++ )
 {
 DataToSend[i]=DataPacket[i-17];
 }


 for( i=3; i<framesize2+3; i++ )
 {
 checkSum=checkSum+DataToSend[i];
 }

 checkSum=0xFF-checkSum;


 DataToSend[i]=checkSum;
 if(debug==1 && USBON){
 sprinti(writebuff,"\nPacket: ");
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

}



void ProcessZigBeeDataPacket(char* DataPacket,char *DevMAC)
{

 char *CommandTrimmed[10];
 char del[2] = "|";

 int i=0;

 if((debug==2 || debug==1) && USBON){
 sprinti(writebuff, "ZIGBEE|%s\n",DataPacket);
 while(!hid_write(writebuff,64));
 }


 CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(DataPacket,'\r'),'\n'), del);


 do
 {

 i++;
 CommandTrimmed[i] = strtok(0, del);

 }
 while( CommandTrimmed[i] != 0 );




 if(strcmp(CommandTrimmed[0],"IO")==0){
 if(strcmp(CommandTrimmed[1],"GETSTATE")==0){
 SendIOsToDevice(DevMAC);
 }
 }
 else if(strcmp(CommandTrimmed[0],"IN")==0){
 if(strcmp(CommandTrimmed[1],"1")==0){
 if(strcmp(CommandTrimmed[2],"1")==0){
 PICOUT1=1;
 }
 else if(strcmp(CommandTrimmed[2],"0")==0){
 PICOUT1=0;
 }
 }
 else if(strcmp(CommandTrimmed[1],"2")==0){
 if(strcmp(CommandTrimmed[2],"1")==0){
 PICOUT2=1;
 }
 else if(strcmp(CommandTrimmed[2],"0")==0){
 PICOUT2=0;
 }
 }
 else if(strcmp(CommandTrimmed[1],"3")==0){
 if(strcmp(CommandTrimmed[2],"1")==0){
 PICOUT3=1;
 }
 else if(strcmp(CommandTrimmed[2],"0")==0){
 PICOUT3=0;
 }
 }
 else if(strcmp(CommandTrimmed[1],"4")==0){
 if(strcmp(CommandTrimmed[2],"1")==0){
 PICOUT4=1;
 }
 else if(strcmp(CommandTrimmed[2],"0")==0){
 PICOUT4=0;
 }
 }
 }

}



void ProcessZigBeeFrame()
{
 int i;
 int FrameType=0;

 char ZigbeeDataPacket[50];
 char ATCommand[2]={0x00, 0x00};
 char CoordinatorAdress[8];
 char DeviceAddress[3];
 char DeviceMAC[8];
 char DeviceID[ 16 ];
 char SenderMac[8];
 char SenderAddress[3];





 FrameType=ZigbeeFrame[3];


 if( FrameType==0x90 )
 {

 for( i=4; i<=11; i++ )
 {

 SenderMac[i-4]=ZigbeeFrame [ i ];
 }


 for( i=12; i<=13; i++ )
 {

 SenderAddress[i-12]=ZigbeeFrame[ i ];
 }

 SenderAddress[i-12]='\0';
 for( i=15; i<=framesize+2; i++ )
 {

 ZigbeeDataPacket[i-15]=ZigbeeFrame[ i ];
 }

 ZigbeeDataPacket[i-15]='\0';

 ProcessZigBeeDataPacket( ZigbeeDataPacket, SenderMac );
 }


 else if( FrameType==0x95 )
 {
 int deviceidx=-1;
 DeviceAddress[0]=ZigbeeFrame [12];
 DeviceAddress[1]=ZigbeeFrame [13];
 DeviceAddress[2]='\0';

 for( i=4; i<12; i++ )
 {
 DeviceMAC[i-4]=ZigbeeFrame[i];
 }



 deviceidx=getZigbeeIndex(DeviceMAC,0);

 if(deviceidx>=0){

 strcpy(ZigbeeSendDevices[deviceidx].Address16,DeviceAddress);
 ZigbeeSendDevices[deviceidx].LastConnected=0;
 ZigbeeSendDevices[deviceidx].Connected=1;
 }

 for( i=0; i< 16 ; i++ )
 {
 DeviceID[i]=ZigbeeFrame[i+26];
 if( DeviceID[i]==0x00 )break;
 }

 }


 else if( FrameType==0x88 )
 {


 ATCommand[0]=ZigbeeFrame [ 5 ];
 ATCommand[1]=ZigbeeFrame [ 6 ];


 if( ZigbeeFrame [7]==0x00 )
 {

 if( ATCommand[0]=='N'&&ATCommand[1]=='D' )
 {
 int deviceidx=-1;
 DeviceAddress[0]=ZigbeeFrame [8];
 DeviceAddress[1]=ZigbeeFrame [9];
 DeviceAddress[2]='\0';


 for( i=10; i<18; i++ )
 {
 DeviceMAC[i-10]=ZigbeeFrame[i];
 }

 deviceidx=getZigbeeIndex(DeviceMAC,0);
 if (deviceidx>=0){

 strcpy(ZigbeeSendDevices[deviceidx].Address16,DeviceAddress);
 ZigbeeSendDevices[deviceidx].LastConnected=0;
 ZigbeeSendDevices[deviceidx].Connected=1;
 }


 for( i=0; i< 16 ; i++ )
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


 if( ZigbeeFrame[4]==0x03 )
 {

 if((debug==2 || debug==1) && USBON){
 sprinti(writebuff, "ZIGBEE|NONETWORK\n");
 while(!hid_write(writebuff,64));
 }
 JoinedToNet=0;
 }


 else if( ZigbeeFrame[4]==0x02 )
 {


 if( JoinedToNet!=2 ){
 JoinedToNet=2;

 if((debug==2 || debug==1) && USBON){
 strcpy(writebuff, "ZIGBEE|JOINED\n");
 while(!hid_write(writebuff,64));
 }
 }


 }


 }



 else if( FrameType==0x8B )
 {

 int deviceidx=-1;
 DeviceAddress[0]=ZigbeeFrame [5];
 DeviceAddress[1]=ZigbeeFrame [6];
 DeviceAddress[2]='\0';







 if( ZigbeeFrame[8]==0x00 )
 {
#line 428 "F:/MEOCloud/KPP/Electronica/PIC Progs/MikroC/ZigBee Remote IO V1.0/ZigbeeRemoteIOV1.0.c"
 }


 else if( ZigbeeFrame[8]==0x21 )
 {
 deviceidx=getZigbeeIndex(0,DeviceAddress);
 if (deviceidx>=0){
 ZigbeeSendDevices[deviceidx].Connected=0;
 }

 if((debug==2 || debug==1) && USBON){
 sprinti(writebuff, "ZIGBEE|ACK FAILED\n");
 while(!hid_write(writebuff,64));
 }

 }
 }
#line 460 "F:/MEOCloud/KPP/Electronica/PIC Progs/MikroC/ZigBee Remote IO V1.0/ZigbeeRemoteIOV1.0.c"
}

 char frame_started=0;

 void interrupt()
 {



 if(USBIF_Bit && USBON){
 USB_Interrupt_Proc();
 }

 if (PIR1.RCIF) {
 if (UART1_Data_Ready() == 1) {
 Rx_char = UART1_Read();
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

 void SendIOsToDevice(char *deviceAddress){
 int i;

 for(i=0;i<4;i++){
 char SendStr[10];
 sprinti(SendStr,"%s|%d\0",Inputs[i].Name,!((PORTB & (1 << Inputs[i].IONum))!=0));
 if(deviceAddress==0)
 SendDataPacket(deviceAddress,SendStr,strlen(SendStr),0);
 else
 SendDataPacket2All(SendStr,strlen(SendStr),0);
 }

 }


 void ProcessNetworkState(){
 int i;

 for(i=0;i< 2 ;i++){
 if(ZigbeeSendDevices[i].Connected==1){
 if(ZigbeeSendDevices[i].Connected!=ZigbeeSendDevices[i].LastConnected){
 ZigbeeSendDevices[i].LastConnected=ZigbeeSendDevices[i].Connected;
 SendIOsToDevice(ZigbeeSendDevices[i].Address64);
 SendDataPacket(ZigbeeSendDevices[i].Address64,"IO|GETSTATE",11,0);
 PICOUT4=!PICOUT4;
 }
 }
 }

 if(JoinedLastState!=JoinedToNet){

 JoinedLastState=JoinedToNet;
 if(JoinedToNet==2)
 SendIOsToDevice(0);
 }



 }


 char SendStr[10];
 void ProcessInputs(){


 int i;


 for(i=0;i<4;i++){
 int portval=!((PORTB & (1 << Inputs[i].IONum))!=0);

 if(portval!=Inputs[i].LastState){
 Inputs[i].WaitDebounce=1;
 if(DebounceVal>Inputs[i].Debounce+5){

 Inputs[i].WaitDebounce=0;
 Inputs[i].LastState=portval;
 sprinti(SendStr,"%s|%d\0",Inputs[i].Name,portval);
 SendDataPacket2All(SendStr,strlen(SendStr),0);
 }
 }
 if( Inputs[i].WaitDebounce==0){
 Inputs[i].Debounce=DebounceVal;
 }

 }
 DebounceVal++;


 }



 void write_eeprom_from(unsigned int startaddress,char *str){
 char hexstr[3];
 unsigned hexval;
 int i=0,j=0;
 for(i=0;i<16;i=i+2){
 hexstr[0]=str[i];
 hexstr[1]=str[i+1];
 hexstr[2]='\0';
 hexval=xtoi(hexstr);
 EEPROM_Write(startaddress+j,hexval);
 delay_ms(30);
 j++;
 }
 }

 void read_eeprom_to(unsigned int startadress,char *dest){
 int i;

 for(i=0;i<8;i++){
 delay_ms(40);
 dest[i]=EEPROM_Read(startadress+i);

 }

 }
 void main() {

 int i, MY_retry=0;

 char DataCharReceived;
 char *CommandTrimmed[10];
 char del[2] = "|";
 char eeprom_readed;


 delay_ms(1000);
 JoinedToNet=0;
 JoinedLastState=0;

 UART1_Init(9600);

 MM_Init();

 for(i=0;i<10;i++){
 CommandTrimmed[i]=(char *)malloc(sizeof(char)*30);

 }





 PICOUT1_Direction=0;
 PICOUT1=0;
 PICOUT2_Direction=0;
 PICOUT2=0;
 PICOUT3_Direction=0;
 PICOUT3=0;
 PICOUT4_Direction=0;
 PICOUT4=0;





 PICIN1_Direction=1;
 PICIN2_Direction=1;
 PICIN3_Direction=1;
 PICIN4_Direction=1;
 USBON_Direction=1;
 PROG_Direction=1;

 for(i=0;i< 2 ;i++){
 ZigbeeSendDevices[i].Connected=0;
 ZigbeeSendDevices[i].LastConnected=0;
 ZigbeeSendDevices[i].Enabled=EEPROM_Read(1+(i*9));
 ZigbeeSendDevices[i].Address64=(unsigned short*)malloc(sizeof(char) *8);
 ZigbeeSendDevices[i].Address16=(unsigned short*)malloc(sizeof(char) *4);
 delay_ms(20);
 read_eeprom_to(2+(i*9),ZigbeeSendDevices[i].Address64);
 delay_ms(20);
 }



 for(i=0;i<4;i++){
 Inputs[i].IONum=i;
 Inputs[i].LastState=((PORTB & (1 << Inputs[i].IONum))!=0);
 Inputs[i].LastState=!Inputs[i].LastState;
 sprinti(Inputs[i].Name,"IN|%d",i+1);
 }

 ADCON0 |= 0x0F;
 ADCON1 |= 0x0F;
 ADCON2 |= 0x0F;
 CMCON |= 7;



 INTCON.GIE = 1;
 INTCON.PEIE = 1;
 PIE1.RCIE = 1;





 if(USBON)
 HID_Enable(readbuff,writebuff);



 debug=0;


 SendRawPacket(ND, 8);

 while(1)
 {


 if(GotFrame==1){
 GotFrame=0;
 ProcessZigBeeFrame();

 }

 else{
 ProcessInputs();
 ProcessNetworkState();
 Delay_ms(1);
 }

 if(USBON){

 if(!(hid_read()==0)) {
 i=0;




 CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(readbuff,'\r'),'\n'), del);


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

 }
 else if(strcmp(CommandTrimmed[0],"?")==0){

 sprinti(writebuff,"KPP ZIGBEE BOARD V1.1\n");
 while(!hid_write(writebuff,64));
 }
 else if(strcmp(CommandTrimmed[0],"READ")==0){

 }
 else if(strcmp(CommandTrimmed[0],"ZIGBEE")==0){

 if(strcmp(CommandTrimmed[1],"SET")==0){
 if(strcmp(CommandTrimmed[2],"DEVICE")==0){
 int devnum=0;
 devnum=atoi(CommandTrimmed[3]);
 if(devnum>0 && devnum-1< 2 ){
 int enabledval;
 enabledval=atoi(CommandTrimmed[4]);
 if(enabledval==0 || enabledval==1){
 write_eeprom_from(1+(devnum-1)*9,CommandTrimmed[4]);
 write_eeprom_from(2+(devnum-1)*9,CommandTrimmed[5]);
 read_eeprom_to(1+(devnum-1)*9,ZigbeeSendDevices[i].Enabled);
 read_eeprom_to(2+(devnum-1)*9,ZigbeeSendDevices[i].Address64);
 }
 }
 }
 }

 else if(strcmp(CommandTrimmed[1],"GET")==0){
 if(strcmp(CommandTrimmed[2],"DEVICE")==0){
 int devnum=0;
 devnum=atoi(CommandTrimmed[3]);
 if(devnum>0 && devnum-1< 2 ){
 int i,k=0;
 char hexval[3];
 char HostZigbeeStr[16];
 for(i=0;i<8;i++){
 ShortToHex(ZigbeeSendDevices[devnum-1].Address64[i],HostZigbeeStr+k);
 k=k+2;
 }
 sprinti(writebuff,"ZIGBEE|DEVICE|%d|%s|%d\n",devnum,HostZigbeeStr,ZigbeeSendDevices[devnum-1].Enabled);
 while(!hid_write(writebuff,64));
 }
 }
 }
 else if(strcmp(CommandTrimmed[1],"MY")==0){
 SendRawPacket(MY1, 8);
 }
 else if(strcmp(CommandTrimmed[1],"ND")==0){
 SendRawPacket(ND, 8);
 }
 }

 }

 }

 }



}
