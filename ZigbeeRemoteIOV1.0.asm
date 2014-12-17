
_DeleteChar:

;ZigbeeRemoteIOV1.0.c,5 :: 		char *DeleteChar (char *str, char oldChar) {
;ZigbeeRemoteIOV1.0.c,6 :: 		char *strPtr = str;
	MOVF        FARG_DeleteChar_str+0, 0 
	MOVWF       DeleteChar_strPtr_L0+0 
	MOVF        FARG_DeleteChar_str+1, 0 
	MOVWF       DeleteChar_strPtr_L0+1 
;ZigbeeRemoteIOV1.0.c,7 :: 		while ((strPtr = strchr (strPtr, oldChar)) != 0)
L_DeleteChar0:
	MOVF        DeleteChar_strPtr_L0+0, 0 
	MOVWF       FARG_strchr_ptr+0 
	MOVF        DeleteChar_strPtr_L0+1, 0 
	MOVWF       FARG_strchr_ptr+1 
	MOVF        FARG_DeleteChar_oldChar+0, 0 
	MOVWF       FARG_strchr_chr+0 
	CALL        _strchr+0, 0
	MOVF        R0, 0 
	MOVWF       DeleteChar_strPtr_L0+0 
	MOVF        R1, 0 
	MOVWF       DeleteChar_strPtr_L0+1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DeleteChar290
	MOVLW       0
	XORWF       R0, 0 
L__DeleteChar290:
	BTFSC       STATUS+0, 2 
	GOTO        L_DeleteChar1
;ZigbeeRemoteIOV1.0.c,8 :: 		*strPtr++ = '\0';
	MOVFF       DeleteChar_strPtr_L0+0, FSR1
	MOVFF       DeleteChar_strPtr_L0+1, FSR1H
	CLRF        POSTINC1+0 
	INFSNZ      DeleteChar_strPtr_L0+0, 1 
	INCF        DeleteChar_strPtr_L0+1, 1 
	GOTO        L_DeleteChar0
L_DeleteChar1:
;ZigbeeRemoteIOV1.0.c,9 :: 		return str;
	MOVF        FARG_DeleteChar_str+0, 0 
	MOVWF       R0 
	MOVF        FARG_DeleteChar_str+1, 0 
	MOVWF       R1 
;ZigbeeRemoteIOV1.0.c,10 :: 		}
L_end_DeleteChar:
	RETURN      0
; end of _DeleteChar

_getZigbeeIndex:

;ZigbeeRemoteIOV1.0.c,12 :: 		short getZigbeeIndex(char *Address64,char *Address16){
;ZigbeeRemoteIOV1.0.c,13 :: 		int i=0;
	CLRF        getZigbeeIndex_i_L0+0 
	CLRF        getZigbeeIndex_i_L0+1 
;ZigbeeRemoteIOV1.0.c,14 :: 		if(Address64!=0){
	MOVLW       0
	XORWF       FARG_getZigbeeIndex_Address64+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getZigbeeIndex292
	MOVLW       0
	XORWF       FARG_getZigbeeIndex_Address64+0, 0 
L__getZigbeeIndex292:
	BTFSC       STATUS+0, 2 
	GOTO        L_getZigbeeIndex2
;ZigbeeRemoteIOV1.0.c,15 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	CLRF        getZigbeeIndex_i_L0+0 
	CLRF        getZigbeeIndex_i_L0+1 
L_getZigbeeIndex3:
	MOVLW       128
	XORWF       getZigbeeIndex_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getZigbeeIndex293
	MOVLW       2
	SUBWF       getZigbeeIndex_i_L0+0, 0 
L__getZigbeeIndex293:
	BTFSC       STATUS+0, 0 
	GOTO        L_getZigbeeIndex4
;ZigbeeRemoteIOV1.0.c,16 :: 		if(strcmp(Address64,ZigbeeSendDevices[i].Address64)==0){
	MOVF        FARG_getZigbeeIndex_Address64+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        FARG_getZigbeeIndex_Address64+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       3
	MOVWF       R2 
	MOVF        getZigbeeIndex_i_L0+0, 0 
	MOVWF       R0 
	MOVF        getZigbeeIndex_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__getZigbeeIndex294:
	BZ          L__getZigbeeIndex295
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__getZigbeeIndex294
L__getZigbeeIndex295:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcmp_s2+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getZigbeeIndex296
	MOVLW       0
	XORWF       R0, 0 
L__getZigbeeIndex296:
	BTFSS       STATUS+0, 2 
	GOTO        L_getZigbeeIndex6
;ZigbeeRemoteIOV1.0.c,17 :: 		return i;
	MOVF        getZigbeeIndex_i_L0+0, 0 
	MOVWF       R0 
	GOTO        L_end_getZigbeeIndex
;ZigbeeRemoteIOV1.0.c,18 :: 		}
L_getZigbeeIndex6:
;ZigbeeRemoteIOV1.0.c,15 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	INFSNZ      getZigbeeIndex_i_L0+0, 1 
	INCF        getZigbeeIndex_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,19 :: 		}
	GOTO        L_getZigbeeIndex3
L_getZigbeeIndex4:
;ZigbeeRemoteIOV1.0.c,20 :: 		}
L_getZigbeeIndex2:
;ZigbeeRemoteIOV1.0.c,22 :: 		if(Address16!=0){
	MOVLW       0
	XORWF       FARG_getZigbeeIndex_Address16+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getZigbeeIndex297
	MOVLW       0
	XORWF       FARG_getZigbeeIndex_Address16+0, 0 
L__getZigbeeIndex297:
	BTFSC       STATUS+0, 2 
	GOTO        L_getZigbeeIndex7
;ZigbeeRemoteIOV1.0.c,23 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	CLRF        getZigbeeIndex_i_L0+0 
	CLRF        getZigbeeIndex_i_L0+1 
L_getZigbeeIndex8:
	MOVLW       128
	XORWF       getZigbeeIndex_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getZigbeeIndex298
	MOVLW       2
	SUBWF       getZigbeeIndex_i_L0+0, 0 
L__getZigbeeIndex298:
	BTFSC       STATUS+0, 0 
	GOTO        L_getZigbeeIndex9
;ZigbeeRemoteIOV1.0.c,24 :: 		if(strcmp(Address16,ZigbeeSendDevices[i].Address16)==0){
	MOVF        FARG_getZigbeeIndex_Address16+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        FARG_getZigbeeIndex_Address16+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       3
	MOVWF       R2 
	MOVF        getZigbeeIndex_i_L0+0, 0 
	MOVWF       R0 
	MOVF        getZigbeeIndex_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__getZigbeeIndex299:
	BZ          L__getZigbeeIndex300
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__getZigbeeIndex299
L__getZigbeeIndex300:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcmp_s2+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__getZigbeeIndex301
	MOVLW       0
	XORWF       R0, 0 
L__getZigbeeIndex301:
	BTFSS       STATUS+0, 2 
	GOTO        L_getZigbeeIndex11
;ZigbeeRemoteIOV1.0.c,25 :: 		return i;
	MOVF        getZigbeeIndex_i_L0+0, 0 
	MOVWF       R0 
	GOTO        L_end_getZigbeeIndex
;ZigbeeRemoteIOV1.0.c,26 :: 		}
L_getZigbeeIndex11:
;ZigbeeRemoteIOV1.0.c,23 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	INFSNZ      getZigbeeIndex_i_L0+0, 1 
	INCF        getZigbeeIndex_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,27 :: 		}
	GOTO        L_getZigbeeIndex8
L_getZigbeeIndex9:
;ZigbeeRemoteIOV1.0.c,28 :: 		}
L_getZigbeeIndex7:
;ZigbeeRemoteIOV1.0.c,30 :: 		return -1;
	MOVLW       255
	MOVWF       R0 
;ZigbeeRemoteIOV1.0.c,31 :: 		}
L_end_getZigbeeIndex:
	RETURN      0
; end of _getZigbeeIndex

_SendRawPacket:

;ZigbeeRemoteIOV1.0.c,33 :: 		void SendRawPacket(char* RawPacket,int len)
;ZigbeeRemoteIOV1.0.c,37 :: 		for( i=0; i<len; i++ )
	CLRF        SendRawPacket_i_L0+0 
	CLRF        SendRawPacket_i_L0+1 
L_SendRawPacket12:
	MOVLW       128
	XORWF       SendRawPacket_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SendRawPacket_len+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendRawPacket303
	MOVF        FARG_SendRawPacket_len+0, 0 
	SUBWF       SendRawPacket_i_L0+0, 0 
L__SendRawPacket303:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendRawPacket13
;ZigbeeRemoteIOV1.0.c,39 :: 		UART1_Write( RawPacket[i]);
	MOVF        SendRawPacket_i_L0+0, 0 
	ADDWF       FARG_SendRawPacket_RawPacket+0, 0 
	MOVWF       FSR0 
	MOVF        SendRawPacket_i_L0+1, 0 
	ADDWFC      FARG_SendRawPacket_RawPacket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ZigbeeRemoteIOV1.0.c,37 :: 		for( i=0; i<len; i++ )
	INFSNZ      SendRawPacket_i_L0+0, 1 
	INCF        SendRawPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,40 :: 		}
	GOTO        L_SendRawPacket12
L_SendRawPacket13:
;ZigbeeRemoteIOV1.0.c,42 :: 		}
L_end_SendRawPacket:
	RETURN      0
; end of _SendRawPacket

_SendDataPacket2All:

;ZigbeeRemoteIOV1.0.c,45 :: 		void SendDataPacket2All(char* DataPacket,int len,char Ack){
;ZigbeeRemoteIOV1.0.c,46 :: 		int i=0;
	CLRF        SendDataPacket2All_i_L0+0 
	CLRF        SendDataPacket2All_i_L0+1 
;ZigbeeRemoteIOV1.0.c,47 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	CLRF        SendDataPacket2All_i_L0+0 
	CLRF        SendDataPacket2All_i_L0+1 
L_SendDataPacket2All15:
	MOVLW       128
	XORWF       SendDataPacket2All_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket2All305
	MOVLW       2
	SUBWF       SendDataPacket2All_i_L0+0, 0 
L__SendDataPacket2All305:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket2All16
;ZigbeeRemoteIOV1.0.c,48 :: 		if(ZigbeeSendDevices[i].Enabled==1){
	MOVLW       3
	MOVWF       R2 
	MOVF        SendDataPacket2All_i_L0+0, 0 
	MOVWF       R0 
	MOVF        SendDataPacket2All_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__SendDataPacket2All306:
	BZ          L__SendDataPacket2All307
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__SendDataPacket2All306
L__SendDataPacket2All307:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket2All308
	MOVLW       1
	XORWF       R1, 0 
L__SendDataPacket2All308:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket2All18
;ZigbeeRemoteIOV1.0.c,49 :: 		SendDataPacket(ZigbeeSendDevices[i].Address64,DataPacket,len,Ack);
	MOVLW       3
	MOVWF       R2 
	MOVF        SendDataPacket2All_i_L0+0, 0 
	MOVWF       R0 
	MOVF        SendDataPacket2All_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__SendDataPacket2All309:
	BZ          L__SendDataPacket2All310
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__SendDataPacket2All309
L__SendDataPacket2All310:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SendDataPacket_sendto+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SendDataPacket_sendto+1 
	MOVF        FARG_SendDataPacket2All_DataPacket+0, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVF        FARG_SendDataPacket2All_DataPacket+1, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVF        FARG_SendDataPacket2All_len+0, 0 
	MOVWF       FARG_SendDataPacket_len+0 
	MOVF        FARG_SendDataPacket2All_len+1, 0 
	MOVWF       FARG_SendDataPacket_len+1 
	MOVF        FARG_SendDataPacket2All_Ack+0, 0 
	MOVWF       FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,50 :: 		}
L_SendDataPacket2All18:
;ZigbeeRemoteIOV1.0.c,47 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	INFSNZ      SendDataPacket2All_i_L0+0, 1 
	INCF        SendDataPacket2All_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,51 :: 		}
	GOTO        L_SendDataPacket2All15
L_SendDataPacket2All16:
;ZigbeeRemoteIOV1.0.c,52 :: 		}
L_end_SendDataPacket2All:
	RETURN      0
; end of _SendDataPacket2All

_SendDataPacket:

;ZigbeeRemoteIOV1.0.c,54 :: 		void SendDataPacket(char *sendto,char* DataPacket,int len,char Ack)
;ZigbeeRemoteIOV1.0.c,56 :: 		int k=0;
;ZigbeeRemoteIOV1.0.c,58 :: 		int i=0, framesize2=14+len;
	CLRF        SendDataPacket_i_L0+0 
	CLRF        SendDataPacket_i_L0+1 
	MOVLW       14
	ADDWF       FARG_SendDataPacket_len+0, 0 
	MOVWF       SendDataPacket_framesize2_L0+0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_len+1, 0 
	MOVWF       SendDataPacket_framesize2_L0+1 
;ZigbeeRemoteIOV1.0.c,60 :: 		unsigned short checkSum=0;
	CLRF        SendDataPacket_checkSum_L0+0 
;ZigbeeRemoteIOV1.0.c,65 :: 		DataToSend[0]=0x7E;
	MOVLW       126
	MOVWF       SendDataPacket_DataToSend_L0+0 
;ZigbeeRemoteIOV1.0.c,66 :: 		DataToSend[1]=0x00;
	CLRF        SendDataPacket_DataToSend_L0+1 
;ZigbeeRemoteIOV1.0.c,68 :: 		DataToSend[2]=framesize2;
	MOVF        SendDataPacket_framesize2_L0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+2 
;ZigbeeRemoteIOV1.0.c,69 :: 		DataToSend[3]=0x10;
	MOVLW       16
	MOVWF       SendDataPacket_DataToSend_L0+3 
;ZigbeeRemoteIOV1.0.c,70 :: 		DataToSend[4]=0x01;
	MOVLW       1
	MOVWF       SendDataPacket_DataToSend_L0+4 
;ZigbeeRemoteIOV1.0.c,73 :: 		if( sendto==0 )
	MOVLW       0
	XORWF       FARG_SendDataPacket_sendto+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket312
	MOVLW       0
	XORWF       FARG_SendDataPacket_sendto+0, 0 
L__SendDataPacket312:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket19
;ZigbeeRemoteIOV1.0.c,76 :: 		DataToSend[5]=0;
	CLRF        SendDataPacket_DataToSend_L0+5 
;ZigbeeRemoteIOV1.0.c,77 :: 		DataToSend[6]=0;
	CLRF        SendDataPacket_DataToSend_L0+6 
;ZigbeeRemoteIOV1.0.c,78 :: 		DataToSend[7]=0;
	CLRF        SendDataPacket_DataToSend_L0+7 
;ZigbeeRemoteIOV1.0.c,79 :: 		DataToSend[8]=0;
	CLRF        SendDataPacket_DataToSend_L0+8 
;ZigbeeRemoteIOV1.0.c,80 :: 		DataToSend[9]=0;
	CLRF        SendDataPacket_DataToSend_L0+9 
;ZigbeeRemoteIOV1.0.c,81 :: 		DataToSend[10]=0;
	CLRF        SendDataPacket_DataToSend_L0+10 
;ZigbeeRemoteIOV1.0.c,82 :: 		DataToSend[11]=0;
	CLRF        SendDataPacket_DataToSend_L0+11 
;ZigbeeRemoteIOV1.0.c,83 :: 		DataToSend[12]=0;
	CLRF        SendDataPacket_DataToSend_L0+12 
;ZigbeeRemoteIOV1.0.c,84 :: 		}
	GOTO        L_SendDataPacket20
L_SendDataPacket19:
;ZigbeeRemoteIOV1.0.c,89 :: 		DataToSend[5]=sendto[0];
	MOVFF       FARG_SendDataPacket_sendto+0, FSR0
	MOVFF       FARG_SendDataPacket_sendto+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+5 
;ZigbeeRemoteIOV1.0.c,90 :: 		DataToSend[6]=sendto[1];
	MOVLW       1
	ADDWF       FARG_SendDataPacket_sendto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_sendto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+6 
;ZigbeeRemoteIOV1.0.c,91 :: 		DataToSend[7]=sendto[2];
	MOVLW       2
	ADDWF       FARG_SendDataPacket_sendto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_sendto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+7 
;ZigbeeRemoteIOV1.0.c,92 :: 		DataToSend[8]=sendto[3];
	MOVLW       3
	ADDWF       FARG_SendDataPacket_sendto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_sendto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+8 
;ZigbeeRemoteIOV1.0.c,93 :: 		DataToSend[9]=sendto[4];
	MOVLW       4
	ADDWF       FARG_SendDataPacket_sendto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_sendto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+9 
;ZigbeeRemoteIOV1.0.c,94 :: 		DataToSend[10]=sendto[5];
	MOVLW       5
	ADDWF       FARG_SendDataPacket_sendto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_sendto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+10 
;ZigbeeRemoteIOV1.0.c,95 :: 		DataToSend[11]=sendto[6];
	MOVLW       6
	ADDWF       FARG_SendDataPacket_sendto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_sendto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+11 
;ZigbeeRemoteIOV1.0.c,96 :: 		DataToSend[12]=sendto[7];
	MOVLW       7
	ADDWF       FARG_SendDataPacket_sendto+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_sendto+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+12 
;ZigbeeRemoteIOV1.0.c,97 :: 		}
L_SendDataPacket20:
;ZigbeeRemoteIOV1.0.c,99 :: 		DataToSend[13]=0xFF;
	MOVLW       255
	MOVWF       SendDataPacket_DataToSend_L0+13 
;ZigbeeRemoteIOV1.0.c,100 :: 		DataToSend[14]=0xFE;
	MOVLW       254
	MOVWF       SendDataPacket_DataToSend_L0+14 
;ZigbeeRemoteIOV1.0.c,102 :: 		DataToSend[15]=0x00;
	CLRF        SendDataPacket_DataToSend_L0+15 
;ZigbeeRemoteIOV1.0.c,104 :: 		DataToSend[16]=0x01;
	MOVLW       1
	MOVWF       SendDataPacket_DataToSend_L0+16 
;ZigbeeRemoteIOV1.0.c,107 :: 		for( i=17; i<17+len; i++ )
	MOVLW       17
	MOVWF       SendDataPacket_i_L0+0 
	MOVLW       0
	MOVWF       SendDataPacket_i_L0+1 
L_SendDataPacket21:
	MOVLW       17
	ADDWF       FARG_SendDataPacket_len+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_len+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       SendDataPacket_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket313
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket313:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket22
;ZigbeeRemoteIOV1.0.c,109 :: 		DataToSend[i]=DataPacket[i-17];
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       17
	SUBWF       SendDataPacket_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      SendDataPacket_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_SendDataPacket_DataPacket+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_SendDataPacket_DataPacket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,107 :: 		for( i=17; i<17+len; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,110 :: 		}
	GOTO        L_SendDataPacket21
L_SendDataPacket22:
;ZigbeeRemoteIOV1.0.c,113 :: 		for( i=3; i<framesize2+3; i++ )
	MOVLW       3
	MOVWF       SendDataPacket_i_L0+0 
	MOVLW       0
	MOVWF       SendDataPacket_i_L0+1 
L_SendDataPacket24:
	MOVLW       3
	ADDWF       SendDataPacket_framesize2_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      SendDataPacket_framesize2_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       SendDataPacket_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket314
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket314:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket25
;ZigbeeRemoteIOV1.0.c,115 :: 		checkSum=checkSum+DataToSend[i];
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       SendDataPacket_checkSum_L0+0, 1 
;ZigbeeRemoteIOV1.0.c,113 :: 		for( i=3; i<framesize2+3; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,116 :: 		}
	GOTO        L_SendDataPacket24
L_SendDataPacket25:
;ZigbeeRemoteIOV1.0.c,118 :: 		checkSum=0xFF-checkSum;
	MOVF        SendDataPacket_checkSum_L0+0, 0 
	SUBLW       255
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       SendDataPacket_checkSum_L0+0 
;ZigbeeRemoteIOV1.0.c,121 :: 		DataToSend[i]=checkSum;
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,122 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket315
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket315:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket29
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket29
L__SendDataPacket269:
;ZigbeeRemoteIOV1.0.c,123 :: 		sprinti(writebuff,"\nPacket: ");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_1_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_1_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_1_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,124 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket30:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket31
	GOTO        L_SendDataPacket30
L_SendDataPacket31:
;ZigbeeRemoteIOV1.0.c,126 :: 		}
L_SendDataPacket29:
;ZigbeeRemoteIOV1.0.c,128 :: 		for( i=0; i<framesize2+4; i++ )
	CLRF        SendDataPacket_i_L0+0 
	CLRF        SendDataPacket_i_L0+1 
L_SendDataPacket32:
	MOVLW       4
	ADDWF       SendDataPacket_framesize2_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      SendDataPacket_framesize2_L0+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       SendDataPacket_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket316
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket316:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket33
;ZigbeeRemoteIOV1.0.c,130 :: 		UART1_Write( DataToSend[i]);
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ZigbeeRemoteIOV1.0.c,131 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket317
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket317:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket37
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket37
L__SendDataPacket268:
;ZigbeeRemoteIOV1.0.c,132 :: 		sprinti(writebuff,"%X",DataToSend[i]);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_2_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_2_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_2_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,133 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket38:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket39
	GOTO        L_SendDataPacket38
L_SendDataPacket39:
;ZigbeeRemoteIOV1.0.c,135 :: 		}
L_SendDataPacket37:
;ZigbeeRemoteIOV1.0.c,128 :: 		for( i=0; i<framesize2+4; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,136 :: 		}
	GOTO        L_SendDataPacket32
L_SendDataPacket33:
;ZigbeeRemoteIOV1.0.c,137 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket318
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket318:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket42
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket42
L__SendDataPacket267:
;ZigbeeRemoteIOV1.0.c,138 :: 		sprinti(writebuff,"\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_3_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_3_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_3_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,139 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket43:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket44
	GOTO        L_SendDataPacket43
L_SendDataPacket44:
;ZigbeeRemoteIOV1.0.c,141 :: 		}
L_SendDataPacket42:
;ZigbeeRemoteIOV1.0.c,143 :: 		}
L_end_SendDataPacket:
	RETURN      0
; end of _SendDataPacket

_ProcessZigBeeDataPacket:

;ZigbeeRemoteIOV1.0.c,147 :: 		void ProcessZigBeeDataPacket(char* DataPacket,char *DevMAC)
;ZigbeeRemoteIOV1.0.c,151 :: 		char del[2] = "|";
	MOVLW       124
	MOVWF       ProcessZigBeeDataPacket_del_L0+0 
	CLRF        ProcessZigBeeDataPacket_del_L0+1 
	CLRF        ProcessZigBeeDataPacket_i_L0+0 
	CLRF        ProcessZigBeeDataPacket_i_L0+1 
;ZigbeeRemoteIOV1.0.c,155 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket320
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeDataPacket320:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket271
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket321
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeDataPacket321:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket271
	GOTO        L_ProcessZigBeeDataPacket49
L__ProcessZigBeeDataPacket271:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeDataPacket49
L__ProcessZigBeeDataPacket270:
;ZigbeeRemoteIOV1.0.c,156 :: 		sprinti(writebuff, "ZIGBEE|%s\n",DataPacket);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_4_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_4_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_4_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        FARG_ProcessZigBeeDataPacket_DataPacket+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVF        FARG_ProcessZigBeeDataPacket_DataPacket+1, 0 
	MOVWF       FARG_sprinti_wh+6 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,157 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeDataPacket50:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket51
	GOTO        L_ProcessZigBeeDataPacket50
L_ProcessZigBeeDataPacket51:
;ZigbeeRemoteIOV1.0.c,158 :: 		}
L_ProcessZigBeeDataPacket49:
;ZigbeeRemoteIOV1.0.c,161 :: 		CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(DataPacket,'\r'),'\n'), del);
	MOVF        FARG_ProcessZigBeeDataPacket_DataPacket+0, 0 
	MOVWF       FARG_DeleteChar_str+0 
	MOVF        FARG_ProcessZigBeeDataPacket_DataPacket+1, 0 
	MOVWF       FARG_DeleteChar_str+1 
	MOVLW       13
	MOVWF       FARG_DeleteChar_oldChar+0 
	CALL        _DeleteChar+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_DeleteChar_str+0 
	MOVF        R1, 0 
	MOVWF       FARG_DeleteChar_str+1 
	MOVLW       10
	MOVWF       FARG_DeleteChar_oldChar+0 
	CALL        _DeleteChar+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_strtok_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_strtok_s1+1 
	MOVLW       ProcessZigBeeDataPacket_del_L0+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(ProcessZigBeeDataPacket_del_L0+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVF        R0, 0 
	MOVWF       ProcessZigBeeDataPacket_CommandTrimmed_L0+0 
	MOVF        R1, 0 
	MOVWF       ProcessZigBeeDataPacket_CommandTrimmed_L0+1 
;ZigbeeRemoteIOV1.0.c,164 :: 		do
L_ProcessZigBeeDataPacket52:
;ZigbeeRemoteIOV1.0.c,167 :: 		i++;
	INFSNZ      ProcessZigBeeDataPacket_i_L0+0, 1 
	INCF        ProcessZigBeeDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,168 :: 		CommandTrimmed[i] = strtok(0, del);
	MOVF        ProcessZigBeeDataPacket_i_L0+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeDataPacket_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       ProcessZigBeeDataPacket_CommandTrimmed_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__ProcessZigBeeDataPacket+0 
	MOVLW       hi_addr(ProcessZigBeeDataPacket_CommandTrimmed_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__ProcessZigBeeDataPacket+1 
	CLRF        FARG_strtok_s1+0 
	CLRF        FARG_strtok_s1+1 
	MOVLW       ProcessZigBeeDataPacket_del_L0+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(ProcessZigBeeDataPacket_del_L0+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVFF       FLOC__ProcessZigBeeDataPacket+0, FSR1
	MOVFF       FLOC__ProcessZigBeeDataPacket+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,171 :: 		while( CommandTrimmed[i] != 0 );
	MOVF        ProcessZigBeeDataPacket_i_L0+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeDataPacket_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       ProcessZigBeeDataPacket_CommandTrimmed_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(ProcessZigBeeDataPacket_CommandTrimmed_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket322
	MOVLW       0
	XORWF       R1, 0 
L__ProcessZigBeeDataPacket322:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket52
;ZigbeeRemoteIOV1.0.c,176 :: 		if(strcmp(CommandTrimmed[0],"IO")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr5_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr5_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket323
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket323:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket55
;ZigbeeRemoteIOV1.0.c,177 :: 		if(strcmp(CommandTrimmed[1],"GETSTATE")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr6_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr6_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket324
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket324:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket56
;ZigbeeRemoteIOV1.0.c,178 :: 		SendIOsToDevice(DevMAC);
	MOVF        FARG_ProcessZigBeeDataPacket_DevMAC+0, 0 
	MOVWF       FARG_SendIOsToDevice_deviceAddress+0 
	MOVF        FARG_ProcessZigBeeDataPacket_DevMAC+1, 0 
	MOVWF       FARG_SendIOsToDevice_deviceAddress+1 
	CALL        _SendIOsToDevice+0, 0
;ZigbeeRemoteIOV1.0.c,179 :: 		}
L_ProcessZigBeeDataPacket56:
;ZigbeeRemoteIOV1.0.c,180 :: 		}
	GOTO        L_ProcessZigBeeDataPacket57
L_ProcessZigBeeDataPacket55:
;ZigbeeRemoteIOV1.0.c,181 :: 		else if(strcmp(CommandTrimmed[0],"IN")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr7_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr7_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket325
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket325:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket58
;ZigbeeRemoteIOV1.0.c,182 :: 		if(strcmp(CommandTrimmed[1],"1")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr8_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr8_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket326
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket326:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket59
;ZigbeeRemoteIOV1.0.c,183 :: 		if(strcmp(CommandTrimmed[2],"1")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr9_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr9_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket327
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket327:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket60
;ZigbeeRemoteIOV1.0.c,184 :: 		PICOUT1=1;
	BSF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,185 :: 		}
	GOTO        L_ProcessZigBeeDataPacket61
L_ProcessZigBeeDataPacket60:
;ZigbeeRemoteIOV1.0.c,186 :: 		else if(strcmp(CommandTrimmed[2],"0")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr10_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr10_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket328
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket328:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket62
;ZigbeeRemoteIOV1.0.c,187 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,188 :: 		}
L_ProcessZigBeeDataPacket62:
L_ProcessZigBeeDataPacket61:
;ZigbeeRemoteIOV1.0.c,189 :: 		}
	GOTO        L_ProcessZigBeeDataPacket63
L_ProcessZigBeeDataPacket59:
;ZigbeeRemoteIOV1.0.c,190 :: 		else  if(strcmp(CommandTrimmed[1],"2")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr11_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr11_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket329
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket329:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket64
;ZigbeeRemoteIOV1.0.c,191 :: 		if(strcmp(CommandTrimmed[2],"1")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr12_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr12_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket330
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket330:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket65
;ZigbeeRemoteIOV1.0.c,192 :: 		PICOUT2=1;
	BSF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,193 :: 		}
	GOTO        L_ProcessZigBeeDataPacket66
L_ProcessZigBeeDataPacket65:
;ZigbeeRemoteIOV1.0.c,194 :: 		else if(strcmp(CommandTrimmed[2],"0")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr13_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr13_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket331
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket331:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket67
;ZigbeeRemoteIOV1.0.c,195 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,196 :: 		}
L_ProcessZigBeeDataPacket67:
L_ProcessZigBeeDataPacket66:
;ZigbeeRemoteIOV1.0.c,197 :: 		}
	GOTO        L_ProcessZigBeeDataPacket68
L_ProcessZigBeeDataPacket64:
;ZigbeeRemoteIOV1.0.c,198 :: 		else if(strcmp(CommandTrimmed[1],"3")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr14_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr14_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket332
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket332:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket69
;ZigbeeRemoteIOV1.0.c,199 :: 		if(strcmp(CommandTrimmed[2],"1")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr15_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr15_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket333
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket333:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket70
;ZigbeeRemoteIOV1.0.c,200 :: 		PICOUT3=1;
	BSF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,201 :: 		}
	GOTO        L_ProcessZigBeeDataPacket71
L_ProcessZigBeeDataPacket70:
;ZigbeeRemoteIOV1.0.c,202 :: 		else if(strcmp(CommandTrimmed[2],"0")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr16_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr16_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket334
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket334:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket72
;ZigbeeRemoteIOV1.0.c,203 :: 		PICOUT3=0;
	BCF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,204 :: 		}
L_ProcessZigBeeDataPacket72:
L_ProcessZigBeeDataPacket71:
;ZigbeeRemoteIOV1.0.c,205 :: 		}
	GOTO        L_ProcessZigBeeDataPacket73
L_ProcessZigBeeDataPacket69:
;ZigbeeRemoteIOV1.0.c,206 :: 		else if(strcmp(CommandTrimmed[1],"4")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr17_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr17_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket335
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket335:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket74
;ZigbeeRemoteIOV1.0.c,207 :: 		if(strcmp(CommandTrimmed[2],"1")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr18_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr18_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket336
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket336:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket75
;ZigbeeRemoteIOV1.0.c,208 :: 		PICOUT4=1;
	BSF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,209 :: 		}
	GOTO        L_ProcessZigBeeDataPacket76
L_ProcessZigBeeDataPacket75:
;ZigbeeRemoteIOV1.0.c,210 :: 		else if(strcmp(CommandTrimmed[2],"0")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr19_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr19_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket337
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket337:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket77
;ZigbeeRemoteIOV1.0.c,211 :: 		PICOUT4=0;
	BCF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,212 :: 		}
L_ProcessZigBeeDataPacket77:
L_ProcessZigBeeDataPacket76:
;ZigbeeRemoteIOV1.0.c,213 :: 		}
L_ProcessZigBeeDataPacket74:
L_ProcessZigBeeDataPacket73:
L_ProcessZigBeeDataPacket68:
L_ProcessZigBeeDataPacket63:
;ZigbeeRemoteIOV1.0.c,214 :: 		}
L_ProcessZigBeeDataPacket58:
L_ProcessZigBeeDataPacket57:
;ZigbeeRemoteIOV1.0.c,216 :: 		}
L_end_ProcessZigBeeDataPacket:
	RETURN      0
; end of _ProcessZigBeeDataPacket

_ProcessZigBeeFrame:

;ZigbeeRemoteIOV1.0.c,220 :: 		void ProcessZigBeeFrame()
;ZigbeeRemoteIOV1.0.c,223 :: 		int FrameType=0;
	CLRF        ProcessZigBeeFrame_FrameType_L0+0 
	CLRF        ProcessZigBeeFrame_FrameType_L0+1 
	CLRF        ProcessZigBeeFrame_ATCommand_L0+0 
	CLRF        ProcessZigBeeFrame_ATCommand_L0+1 
;ZigbeeRemoteIOV1.0.c,238 :: 		FrameType=ZigbeeFrame[3];
	MOVF        _ZigbeeFrame+3, 0 
	MOVWF       ProcessZigBeeFrame_FrameType_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_FrameType_L0+1 
;ZigbeeRemoteIOV1.0.c,241 :: 		if( FrameType==0x90 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame339
	MOVLW       144
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame339:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame78
;ZigbeeRemoteIOV1.0.c,244 :: 		for( i=4; i<=11; i++ )
	MOVLW       4
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame79:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame340
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBLW       11
L__ProcessZigBeeFrame340:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame80
;ZigbeeRemoteIOV1.0.c,247 :: 		SenderMac[i-4]=ZigbeeFrame [ i ];
	MOVLW       4
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       ProcessZigBeeFrame_SenderMac_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_SenderMac_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _ZigbeeFrame+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,244 :: 		for( i=4; i<=11; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,248 :: 		}
	GOTO        L_ProcessZigBeeFrame79
L_ProcessZigBeeFrame80:
;ZigbeeRemoteIOV1.0.c,251 :: 		for( i=12; i<=13; i++ )
	MOVLW       12
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame82:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame341
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBLW       13
L__ProcessZigBeeFrame341:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame83
;ZigbeeRemoteIOV1.0.c,254 :: 		SenderAddress[i-12]=ZigbeeFrame[ i ];
	MOVLW       12
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       ProcessZigBeeFrame_SenderAddress_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_SenderAddress_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _ZigbeeFrame+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,251 :: 		for( i=12; i<=13; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,255 :: 		}
	GOTO        L_ProcessZigBeeFrame82
L_ProcessZigBeeFrame83:
;ZigbeeRemoteIOV1.0.c,257 :: 		SenderAddress[i-12]='\0';
	MOVLW       12
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       ProcessZigBeeFrame_SenderAddress_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_SenderAddress_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,258 :: 		for( i=15; i<=framesize+2; i++ )
	MOVLW       15
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame85:
	MOVLW       2
	ADDWF       _framesize+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _framesize+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame342
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBWF       R1, 0 
L__ProcessZigBeeFrame342:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame86
;ZigbeeRemoteIOV1.0.c,261 :: 		ZigbeeDataPacket[i-15]=ZigbeeFrame[ i ];
	MOVLW       15
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       ProcessZigBeeFrame_ZigbeeDataPacket_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_ZigbeeDataPacket_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _ZigbeeFrame+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,258 :: 		for( i=15; i<=framesize+2; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,262 :: 		}
	GOTO        L_ProcessZigBeeFrame85
L_ProcessZigBeeFrame86:
;ZigbeeRemoteIOV1.0.c,264 :: 		ZigbeeDataPacket[i-15]='\0';
	MOVLW       15
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       ProcessZigBeeFrame_ZigbeeDataPacket_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_ZigbeeDataPacket_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,266 :: 		ProcessZigBeeDataPacket( ZigbeeDataPacket, SenderMac );
	MOVLW       ProcessZigBeeFrame_ZigbeeDataPacket_L0+0
	MOVWF       FARG_ProcessZigBeeDataPacket_DataPacket+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_ZigbeeDataPacket_L0+0)
	MOVWF       FARG_ProcessZigBeeDataPacket_DataPacket+1 
	MOVLW       ProcessZigBeeFrame_SenderMac_L0+0
	MOVWF       FARG_ProcessZigBeeDataPacket_DevMAC+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_SenderMac_L0+0)
	MOVWF       FARG_ProcessZigBeeDataPacket_DevMAC+1 
	CALL        _ProcessZigBeeDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,267 :: 		}
	GOTO        L_ProcessZigBeeFrame88
L_ProcessZigBeeFrame78:
;ZigbeeRemoteIOV1.0.c,270 :: 		else if( FrameType==0x95 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame343
	MOVLW       149
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame343:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame89
;ZigbeeRemoteIOV1.0.c,272 :: 		int deviceidx=-1;
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L1+0 
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L1+1 
;ZigbeeRemoteIOV1.0.c,273 :: 		DeviceAddress[0]=ZigbeeFrame [12];
	MOVF        _ZigbeeFrame+12, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAddress_L0+0 
;ZigbeeRemoteIOV1.0.c,274 :: 		DeviceAddress[1]=ZigbeeFrame [13];
	MOVF        _ZigbeeFrame+13, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAddress_L0+1 
;ZigbeeRemoteIOV1.0.c,275 :: 		DeviceAddress[2]='\0';
	CLRF        ProcessZigBeeFrame_DeviceAddress_L0+2 
;ZigbeeRemoteIOV1.0.c,277 :: 		for( i=4; i<12; i++ )
	MOVLW       4
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame90:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame344
	MOVLW       12
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame344:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame91
;ZigbeeRemoteIOV1.0.c,279 :: 		DeviceMAC[i-4]=ZigbeeFrame[i];
	MOVLW       4
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       ProcessZigBeeFrame_DeviceMAC_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceMAC_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _ZigbeeFrame+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,277 :: 		for( i=4; i<12; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,280 :: 		}
	GOTO        L_ProcessZigBeeFrame90
L_ProcessZigBeeFrame91:
;ZigbeeRemoteIOV1.0.c,284 :: 		deviceidx=getZigbeeIndex(DeviceMAC,0);
	MOVLW       ProcessZigBeeFrame_DeviceMAC_L0+0
	MOVWF       FARG_getZigbeeIndex_Address64+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceMAC_L0+0)
	MOVWF       FARG_getZigbeeIndex_Address64+1 
	CLRF        FARG_getZigbeeIndex_Address16+0 
	CLRF        FARG_getZigbeeIndex_Address16+1 
	CALL        _getZigbeeIndex+0, 0
	MOVF        R0, 0 
	MOVWF       ProcessZigBeeFrame_deviceidx_L1+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L1+1 
;ZigbeeRemoteIOV1.0.c,286 :: 		if(deviceidx>=0){
	MOVLW       128
	XORWF       ProcessZigBeeFrame_deviceidx_L1+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame345
	MOVLW       0
	SUBWF       ProcessZigBeeFrame_deviceidx_L1+0, 0 
L__ProcessZigBeeFrame345:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame93
;ZigbeeRemoteIOV1.0.c,288 :: 		strcpy(ZigbeeSendDevices[deviceidx].Address16,DeviceAddress);
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessZigBeeFrame_deviceidx_L1+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeFrame_deviceidx_L1+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessZigBeeFrame346:
	BZ          L__ProcessZigBeeFrame347
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessZigBeeFrame346
L__ProcessZigBeeFrame347:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_to+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ProcessZigBeeFrame_DeviceAddress_L0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceAddress_L0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,289 :: 		ZigbeeSendDevices[deviceidx].LastConnected=0;
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessZigBeeFrame_deviceidx_L1+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeFrame_deviceidx_L1+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessZigBeeFrame348:
	BZ          L__ProcessZigBeeFrame349
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessZigBeeFrame348
L__ProcessZigBeeFrame349:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,290 :: 		ZigbeeSendDevices[deviceidx].Connected=1;
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessZigBeeFrame_deviceidx_L1+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeFrame_deviceidx_L1+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessZigBeeFrame350:
	BZ          L__ProcessZigBeeFrame351
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessZigBeeFrame350
L__ProcessZigBeeFrame351:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,291 :: 		}
L_ProcessZigBeeFrame93:
;ZigbeeRemoteIOV1.0.c,293 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	CLRF        ProcessZigBeeFrame_i_L0+0 
	CLRF        ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame94:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame352
	MOVLW       16
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame352:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame95
;ZigbeeRemoteIOV1.0.c,295 :: 		DeviceID[i]=ZigbeeFrame[i+26];
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       26
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       _ZigbeeFrame+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,296 :: 		if( DeviceID[i]==0x00 )break;
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame97
	GOTO        L_ProcessZigBeeFrame95
L_ProcessZigBeeFrame97:
;ZigbeeRemoteIOV1.0.c,293 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,297 :: 		}
	GOTO        L_ProcessZigBeeFrame94
L_ProcessZigBeeFrame95:
;ZigbeeRemoteIOV1.0.c,299 :: 		}
	GOTO        L_ProcessZigBeeFrame98
L_ProcessZigBeeFrame89:
;ZigbeeRemoteIOV1.0.c,302 :: 		else if( FrameType==0x88 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame353
	MOVLW       136
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame353:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame99
;ZigbeeRemoteIOV1.0.c,306 :: 		ATCommand[0]=ZigbeeFrame [ 5 ];
	MOVF        _ZigbeeFrame+5, 0 
	MOVWF       ProcessZigBeeFrame_ATCommand_L0+0 
;ZigbeeRemoteIOV1.0.c,307 :: 		ATCommand[1]=ZigbeeFrame [ 6 ];
	MOVF        _ZigbeeFrame+6, 0 
	MOVWF       ProcessZigBeeFrame_ATCommand_L0+1 
;ZigbeeRemoteIOV1.0.c,310 :: 		if( ZigbeeFrame [7]==0x00 )
	MOVF        _ZigbeeFrame+7, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame100
;ZigbeeRemoteIOV1.0.c,313 :: 		if( ATCommand[0]=='N'&&ATCommand[1]=='D' )
	MOVF        ProcessZigBeeFrame_ATCommand_L0+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame103
	MOVF        ProcessZigBeeFrame_ATCommand_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame103
L__ProcessZigBeeFrame284:
;ZigbeeRemoteIOV1.0.c,315 :: 		int deviceidx=-1;
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L3+0 
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L3+1 
;ZigbeeRemoteIOV1.0.c,316 :: 		DeviceAddress[0]=ZigbeeFrame [8];
	MOVF        _ZigbeeFrame+8, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAddress_L0+0 
;ZigbeeRemoteIOV1.0.c,317 :: 		DeviceAddress[1]=ZigbeeFrame [9];
	MOVF        _ZigbeeFrame+9, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAddress_L0+1 
;ZigbeeRemoteIOV1.0.c,318 :: 		DeviceAddress[2]='\0';
	CLRF        ProcessZigBeeFrame_DeviceAddress_L0+2 
;ZigbeeRemoteIOV1.0.c,321 :: 		for( i=10; i<18; i++ )
	MOVLW       10
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame104:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame354
	MOVLW       18
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame354:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame105
;ZigbeeRemoteIOV1.0.c,323 :: 		DeviceMAC[i-10]=ZigbeeFrame[i];
	MOVLW       10
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       ProcessZigBeeFrame_DeviceMAC_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceMAC_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       _ZigbeeFrame+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,321 :: 		for( i=10; i<18; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,324 :: 		}
	GOTO        L_ProcessZigBeeFrame104
L_ProcessZigBeeFrame105:
;ZigbeeRemoteIOV1.0.c,326 :: 		deviceidx=getZigbeeIndex(DeviceMAC,0);
	MOVLW       ProcessZigBeeFrame_DeviceMAC_L0+0
	MOVWF       FARG_getZigbeeIndex_Address64+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceMAC_L0+0)
	MOVWF       FARG_getZigbeeIndex_Address64+1 
	CLRF        FARG_getZigbeeIndex_Address16+0 
	CLRF        FARG_getZigbeeIndex_Address16+1 
	CALL        _getZigbeeIndex+0, 0
	MOVF        R0, 0 
	MOVWF       ProcessZigBeeFrame_deviceidx_L3+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L3+1 
;ZigbeeRemoteIOV1.0.c,327 :: 		if (deviceidx>=0){
	MOVLW       128
	XORWF       ProcessZigBeeFrame_deviceidx_L3+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame355
	MOVLW       0
	SUBWF       ProcessZigBeeFrame_deviceidx_L3+0, 0 
L__ProcessZigBeeFrame355:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame107
;ZigbeeRemoteIOV1.0.c,329 :: 		strcpy(ZigbeeSendDevices[deviceidx].Address16,DeviceAddress);
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessZigBeeFrame_deviceidx_L3+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeFrame_deviceidx_L3+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessZigBeeFrame356:
	BZ          L__ProcessZigBeeFrame357
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessZigBeeFrame356
L__ProcessZigBeeFrame357:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_to+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ProcessZigBeeFrame_DeviceAddress_L0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceAddress_L0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,330 :: 		ZigbeeSendDevices[deviceidx].LastConnected=0;
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessZigBeeFrame_deviceidx_L3+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeFrame_deviceidx_L3+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessZigBeeFrame358:
	BZ          L__ProcessZigBeeFrame359
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessZigBeeFrame358
L__ProcessZigBeeFrame359:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,331 :: 		ZigbeeSendDevices[deviceidx].Connected=1;
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessZigBeeFrame_deviceidx_L3+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeFrame_deviceidx_L3+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessZigBeeFrame360:
	BZ          L__ProcessZigBeeFrame361
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessZigBeeFrame360
L__ProcessZigBeeFrame361:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,332 :: 		}
L_ProcessZigBeeFrame107:
;ZigbeeRemoteIOV1.0.c,335 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	CLRF        ProcessZigBeeFrame_i_L0+0 
	CLRF        ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame108:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame362
	MOVLW       16
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame362:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame109
;ZigbeeRemoteIOV1.0.c,337 :: 		DeviceID[i]=ZigbeeFrame[i+19];
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       19
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       _ZigbeeFrame+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,338 :: 		if( DeviceID[i]==0x00 )break;
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame111
	GOTO        L_ProcessZigBeeFrame109
L_ProcessZigBeeFrame111:
;ZigbeeRemoteIOV1.0.c,335 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,339 :: 		}
	GOTO        L_ProcessZigBeeFrame108
L_ProcessZigBeeFrame109:
;ZigbeeRemoteIOV1.0.c,343 :: 		}else if( ATCommand[0]=='M'&&ATCommand[1]=='Y' ){
	GOTO        L_ProcessZigBeeFrame112
L_ProcessZigBeeFrame103:
	MOVF        ProcessZigBeeFrame_ATCommand_L0+0, 0 
	XORLW       77
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame115
	MOVF        ProcessZigBeeFrame_ATCommand_L0+1, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame115
L__ProcessZigBeeFrame283:
;ZigbeeRemoteIOV1.0.c,344 :: 		LocalIP[0]=ZigbeeFrame [8];
	MOVF        _ZigbeeFrame+8, 0 
	MOVWF       _LocalIP+0 
;ZigbeeRemoteIOV1.0.c,345 :: 		LocalIP[1]=ZigbeeFrame [9];
	MOVF        _ZigbeeFrame+9, 0 
	MOVWF       _LocalIP+1 
;ZigbeeRemoteIOV1.0.c,347 :: 		if( LocalIP[0]!=0xFF&&LocalIP[1]!=0xFE )
	MOVF        _LocalIP+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame118
	MOVF        _LocalIP+1, 0 
	XORLW       254
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame118
L__ProcessZigBeeFrame282:
;ZigbeeRemoteIOV1.0.c,350 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,351 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame363
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame363:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame281
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame364
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame364:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame281
	GOTO        L_ProcessZigBeeFrame123
L__ProcessZigBeeFrame281:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame123
L__ProcessZigBeeFrame280:
;ZigbeeRemoteIOV1.0.c,352 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr20_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr20_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,353 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame124:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame125
	GOTO        L_ProcessZigBeeFrame124
L_ProcessZigBeeFrame125:
;ZigbeeRemoteIOV1.0.c,354 :: 		}
L_ProcessZigBeeFrame123:
;ZigbeeRemoteIOV1.0.c,356 :: 		}
	GOTO        L_ProcessZigBeeFrame126
L_ProcessZigBeeFrame118:
;ZigbeeRemoteIOV1.0.c,360 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,362 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame365
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame365:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame279
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame366
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame366:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame279
	GOTO        L_ProcessZigBeeFrame131
L__ProcessZigBeeFrame279:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame131
L__ProcessZigBeeFrame278:
;ZigbeeRemoteIOV1.0.c,363 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_21_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_21_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_21_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,364 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame132:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame133
	GOTO        L_ProcessZigBeeFrame132
L_ProcessZigBeeFrame133:
;ZigbeeRemoteIOV1.0.c,365 :: 		}
L_ProcessZigBeeFrame131:
;ZigbeeRemoteIOV1.0.c,367 :: 		}
L_ProcessZigBeeFrame126:
;ZigbeeRemoteIOV1.0.c,368 :: 		}
L_ProcessZigBeeFrame115:
L_ProcessZigBeeFrame112:
;ZigbeeRemoteIOV1.0.c,369 :: 		}
L_ProcessZigBeeFrame100:
;ZigbeeRemoteIOV1.0.c,370 :: 		}
	GOTO        L_ProcessZigBeeFrame134
L_ProcessZigBeeFrame99:
;ZigbeeRemoteIOV1.0.c,372 :: 		else if( FrameType==0x8A )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame367
	MOVLW       138
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame367:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame135
;ZigbeeRemoteIOV1.0.c,376 :: 		if( ZigbeeFrame[4]==0x03 )
	MOVF        _ZigbeeFrame+4, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame136
;ZigbeeRemoteIOV1.0.c,379 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame368
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame368:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame277
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame369
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame369:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame277
	GOTO        L_ProcessZigBeeFrame141
L__ProcessZigBeeFrame277:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame141
L__ProcessZigBeeFrame276:
;ZigbeeRemoteIOV1.0.c,380 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_22_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_22_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_22_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,381 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame142:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame143
	GOTO        L_ProcessZigBeeFrame142
L_ProcessZigBeeFrame143:
;ZigbeeRemoteIOV1.0.c,382 :: 		}
L_ProcessZigBeeFrame141:
;ZigbeeRemoteIOV1.0.c,383 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,384 :: 		}
	GOTO        L_ProcessZigBeeFrame144
L_ProcessZigBeeFrame136:
;ZigbeeRemoteIOV1.0.c,387 :: 		else if( ZigbeeFrame[4]==0x02 )
	MOVF        _ZigbeeFrame+4, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame145
;ZigbeeRemoteIOV1.0.c,391 :: 		if( JoinedToNet!=2 ){
	MOVLW       0
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame370
	MOVLW       2
	XORWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame370:
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame146
;ZigbeeRemoteIOV1.0.c,392 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,394 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame371
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame371:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame275
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame372
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame372:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame275
	GOTO        L_ProcessZigBeeFrame151
L__ProcessZigBeeFrame275:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame151
L__ProcessZigBeeFrame274:
;ZigbeeRemoteIOV1.0.c,395 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr23_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr23_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,396 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame152:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame153
	GOTO        L_ProcessZigBeeFrame152
L_ProcessZigBeeFrame153:
;ZigbeeRemoteIOV1.0.c,397 :: 		}
L_ProcessZigBeeFrame151:
;ZigbeeRemoteIOV1.0.c,398 :: 		}
L_ProcessZigBeeFrame146:
;ZigbeeRemoteIOV1.0.c,401 :: 		}
L_ProcessZigBeeFrame145:
L_ProcessZigBeeFrame144:
;ZigbeeRemoteIOV1.0.c,404 :: 		}
	GOTO        L_ProcessZigBeeFrame154
L_ProcessZigBeeFrame135:
;ZigbeeRemoteIOV1.0.c,408 :: 		else if( FrameType==0x8B )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame373
	MOVLW       139
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame373:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame155
;ZigbeeRemoteIOV1.0.c,411 :: 		int deviceidx=-1;
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L1_L1+0 
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L1_L1+1 
;ZigbeeRemoteIOV1.0.c,412 :: 		DeviceAddress[0]=ZigbeeFrame [5];
	MOVF        _ZigbeeFrame+5, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAddress_L0+0 
;ZigbeeRemoteIOV1.0.c,413 :: 		DeviceAddress[1]=ZigbeeFrame [6];
	MOVF        _ZigbeeFrame+6, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAddress_L0+1 
;ZigbeeRemoteIOV1.0.c,414 :: 		DeviceAddress[2]='\0';
	CLRF        ProcessZigBeeFrame_DeviceAddress_L0+2 
;ZigbeeRemoteIOV1.0.c,422 :: 		if( ZigbeeFrame[8]==0x00 )
	MOVF        _ZigbeeFrame+8, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame156
;ZigbeeRemoteIOV1.0.c,428 :: 		}
	GOTO        L_ProcessZigBeeFrame157
L_ProcessZigBeeFrame156:
;ZigbeeRemoteIOV1.0.c,431 :: 		else if( ZigbeeFrame[8]==0x21 )
	MOVF        _ZigbeeFrame+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame158
;ZigbeeRemoteIOV1.0.c,433 :: 		deviceidx=getZigbeeIndex(0,DeviceAddress);
	CLRF        FARG_getZigbeeIndex_Address64+0 
	CLRF        FARG_getZigbeeIndex_Address64+1 
	MOVLW       ProcessZigBeeFrame_DeviceAddress_L0+0
	MOVWF       FARG_getZigbeeIndex_Address16+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceAddress_L0+0)
	MOVWF       FARG_getZigbeeIndex_Address16+1 
	CALL        _getZigbeeIndex+0, 0
	MOVF        R0, 0 
	MOVWF       ProcessZigBeeFrame_deviceidx_L1_L1+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       ProcessZigBeeFrame_deviceidx_L1_L1+1 
;ZigbeeRemoteIOV1.0.c,434 :: 		if (deviceidx>=0){
	MOVLW       128
	XORWF       ProcessZigBeeFrame_deviceidx_L1_L1+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame374
	MOVLW       0
	SUBWF       ProcessZigBeeFrame_deviceidx_L1_L1+0, 0 
L__ProcessZigBeeFrame374:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame159
;ZigbeeRemoteIOV1.0.c,435 :: 		ZigbeeSendDevices[deviceidx].Connected=0;
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessZigBeeFrame_deviceidx_L1_L1+0, 0 
	MOVWF       R0 
	MOVF        ProcessZigBeeFrame_deviceidx_L1_L1+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessZigBeeFrame375:
	BZ          L__ProcessZigBeeFrame376
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessZigBeeFrame375
L__ProcessZigBeeFrame376:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,436 :: 		}
L_ProcessZigBeeFrame159:
;ZigbeeRemoteIOV1.0.c,438 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame377
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame377:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame273
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame378
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame378:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame273
	GOTO        L_ProcessZigBeeFrame164
L__ProcessZigBeeFrame273:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame164
L__ProcessZigBeeFrame272:
;ZigbeeRemoteIOV1.0.c,439 :: 		sprinti(writebuff, "ZIGBEE|ACK FAILED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_24_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_24_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_24_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,440 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame165:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame166
	GOTO        L_ProcessZigBeeFrame165
L_ProcessZigBeeFrame166:
;ZigbeeRemoteIOV1.0.c,441 :: 		}
L_ProcessZigBeeFrame164:
;ZigbeeRemoteIOV1.0.c,443 :: 		}
L_ProcessZigBeeFrame158:
L_ProcessZigBeeFrame157:
;ZigbeeRemoteIOV1.0.c,444 :: 		}
L_ProcessZigBeeFrame155:
L_ProcessZigBeeFrame154:
L_ProcessZigBeeFrame134:
L_ProcessZigBeeFrame98:
L_ProcessZigBeeFrame88:
;ZigbeeRemoteIOV1.0.c,460 :: 		}
L_end_ProcessZigBeeFrame:
	RETURN      0
; end of _ProcessZigBeeFrame

_interrupt:

;ZigbeeRemoteIOV1.0.c,464 :: 		void interrupt()
;ZigbeeRemoteIOV1.0.c,469 :: 		if(USBIF_Bit && USBON){
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt169
	BTFSS       PORTB+0, 4 
	GOTO        L_interrupt169
L__interrupt285:
;ZigbeeRemoteIOV1.0.c,470 :: 		USB_Interrupt_Proc();                   // USB servicing is done inside the interrupt
	CALL        _USB_Interrupt_Proc+0, 0
;ZigbeeRemoteIOV1.0.c,471 :: 		}
L_interrupt169:
;ZigbeeRemoteIOV1.0.c,473 :: 		if (PIR1.RCIF) {          // test the interrupt for uart rx
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt170
;ZigbeeRemoteIOV1.0.c,474 :: 		if (UART1_Data_Ready() == 1) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt171
;ZigbeeRemoteIOV1.0.c,475 :: 		Rx_char = UART1_Read();  //
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Rx_char+0 
;ZigbeeRemoteIOV1.0.c,476 :: 		if(Rx_char==0x7E){
	MOVF        R0, 0 
	XORLW       126
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt172
;ZigbeeRemoteIOV1.0.c,477 :: 		frameindex=0;
	CLRF        _frameindex+0 
	CLRF        _frameindex+1 
;ZigbeeRemoteIOV1.0.c,478 :: 		frame_started=1;
	MOVLW       1
	MOVWF       _frame_started+0 
;ZigbeeRemoteIOV1.0.c,480 :: 		}
L_interrupt172:
;ZigbeeRemoteIOV1.0.c,482 :: 		if(frame_started==1){
	MOVF        _frame_started+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt173
;ZigbeeRemoteIOV1.0.c,483 :: 		ZigbeeFrame[frameindex]=Rx_char;
	MOVLW       _ZigbeeFrame+0
	ADDWF       _frameindex+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      _frameindex+1, 0 
	MOVWF       FSR1H 
	MOVF        _Rx_char+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,485 :: 		if( frameindex==2 )
	MOVLW       0
	XORWF       _frameindex+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt381
	MOVLW       2
	XORWF       _frameindex+0, 0 
L__interrupt381:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt174
;ZigbeeRemoteIOV1.0.c,487 :: 		framesize=ZigbeeFrame[1]+ZigbeeFrame[2];
	MOVF        _ZigbeeFrame+2, 0 
	ADDWF       _ZigbeeFrame+1, 0 
	MOVWF       _framesize+0 
	CLRF        _framesize+1 
	MOVLW       0
	ADDWFC      _framesize+1, 1 
;ZigbeeRemoteIOV1.0.c,488 :: 		}
L_interrupt174:
;ZigbeeRemoteIOV1.0.c,490 :: 		frameindex++;
	INFSNZ      _frameindex+0, 1 
	INCF        _frameindex+1, 1 
;ZigbeeRemoteIOV1.0.c,491 :: 		if( frameindex>=framesize+4 )
	MOVLW       4
	ADDWF       _framesize+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _framesize+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       _frameindex+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt382
	MOVF        R1, 0 
	SUBWF       _frameindex+0, 0 
L__interrupt382:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt175
;ZigbeeRemoteIOV1.0.c,494 :: 		frameindex=0;
	CLRF        _frameindex+0 
	CLRF        _frameindex+1 
;ZigbeeRemoteIOV1.0.c,495 :: 		frame_started=0;
	CLRF        _frame_started+0 
;ZigbeeRemoteIOV1.0.c,496 :: 		GotFrame=1;
	MOVLW       1
	MOVWF       _GotFrame+0 
;ZigbeeRemoteIOV1.0.c,498 :: 		}
L_interrupt175:
;ZigbeeRemoteIOV1.0.c,499 :: 		}
L_interrupt173:
;ZigbeeRemoteIOV1.0.c,500 :: 		}
L_interrupt171:
;ZigbeeRemoteIOV1.0.c,501 :: 		}
L_interrupt170:
;ZigbeeRemoteIOV1.0.c,503 :: 		}
L_end_interrupt:
L__interrupt380:
	RETFIE      1
; end of _interrupt

_SendIOsToDevice:

;ZigbeeRemoteIOV1.0.c,505 :: 		void SendIOsToDevice(char *deviceAddress){
;ZigbeeRemoteIOV1.0.c,508 :: 		for(i=0;i<4;i++){
	CLRF        SendIOsToDevice_i_L0+0 
	CLRF        SendIOsToDevice_i_L0+1 
L_SendIOsToDevice176:
	MOVLW       128
	XORWF       SendIOsToDevice_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendIOsToDevice384
	MOVLW       4
	SUBWF       SendIOsToDevice_i_L0+0, 0 
L__SendIOsToDevice384:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendIOsToDevice177
;ZigbeeRemoteIOV1.0.c,510 :: 		sprinti(SendStr,"%s|%d\0",Inputs[i].Name,!((PORTB & (1 << Inputs[i].IONum))!=0));
	MOVLW       SendIOsToDevice_SendStr_L1+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(SendIOsToDevice_SendStr_L1+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_25_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_25_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_25_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SendIOsToDevice_i_L0+0, 0 
	MOVWF       R4 
	MOVF        SendIOsToDevice_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_sprinti_wh+6 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__SendIOsToDevice385:
	BZ          L__SendIOsToDevice386
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__SendIOsToDevice385
L__SendIOsToDevice386:
	MOVF        PORTB+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendIOsToDevice387
	MOVLW       0
	XORWF       R0, 0 
L__SendIOsToDevice387:
	MOVLW       0
	BTFSS       STATUS+0, 2 
	MOVLW       1
	MOVWF       FARG_sprinti_wh+7 
	MOVF        FARG_sprinti_wh+7, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       FARG_sprinti_wh+7 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,511 :: 		if(deviceAddress==0)
	MOVLW       0
	XORWF       FARG_SendIOsToDevice_deviceAddress+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendIOsToDevice388
	MOVLW       0
	XORWF       FARG_SendIOsToDevice_deviceAddress+0, 0 
L__SendIOsToDevice388:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendIOsToDevice179
;ZigbeeRemoteIOV1.0.c,512 :: 		SendDataPacket(deviceAddress,SendStr,strlen(SendStr),0);
	MOVLW       SendIOsToDevice_SendStr_L1+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(SendIOsToDevice_SendStr_L1+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SendDataPacket_len+0 
	MOVF        R1, 0 
	MOVWF       FARG_SendDataPacket_len+1 
	MOVF        FARG_SendIOsToDevice_deviceAddress+0, 0 
	MOVWF       FARG_SendDataPacket_sendto+0 
	MOVF        FARG_SendIOsToDevice_deviceAddress+1, 0 
	MOVWF       FARG_SendDataPacket_sendto+1 
	MOVLW       SendIOsToDevice_SendStr_L1+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(SendIOsToDevice_SendStr_L1+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
	GOTO        L_SendIOsToDevice180
L_SendIOsToDevice179:
;ZigbeeRemoteIOV1.0.c,514 :: 		SendDataPacket2All(SendStr,strlen(SendStr),0);
	MOVLW       SendIOsToDevice_SendStr_L1+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(SendIOsToDevice_SendStr_L1+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SendDataPacket2All_len+0 
	MOVF        R1, 0 
	MOVWF       FARG_SendDataPacket2All_len+1 
	MOVLW       SendIOsToDevice_SendStr_L1+0
	MOVWF       FARG_SendDataPacket2All_DataPacket+0 
	MOVLW       hi_addr(SendIOsToDevice_SendStr_L1+0)
	MOVWF       FARG_SendDataPacket2All_DataPacket+1 
	CLRF        FARG_SendDataPacket2All_Ack+0 
	CALL        _SendDataPacket2All+0, 0
L_SendIOsToDevice180:
;ZigbeeRemoteIOV1.0.c,508 :: 		for(i=0;i<4;i++){
	INFSNZ      SendIOsToDevice_i_L0+0, 1 
	INCF        SendIOsToDevice_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,515 :: 		}
	GOTO        L_SendIOsToDevice176
L_SendIOsToDevice177:
;ZigbeeRemoteIOV1.0.c,517 :: 		}
L_end_SendIOsToDevice:
	RETURN      0
; end of _SendIOsToDevice

_ProcessNetworkState:

;ZigbeeRemoteIOV1.0.c,519 :: 		void ProcessNetworkState(){
;ZigbeeRemoteIOV1.0.c,522 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	CLRF        ProcessNetworkState_i_L0+0 
	CLRF        ProcessNetworkState_i_L0+1 
L_ProcessNetworkState181:
	MOVLW       128
	XORWF       ProcessNetworkState_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessNetworkState390
	MOVLW       2
	SUBWF       ProcessNetworkState_i_L0+0, 0 
L__ProcessNetworkState390:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessNetworkState182
;ZigbeeRemoteIOV1.0.c,523 :: 		if(ZigbeeSendDevices[i].Connected!=ZigbeeSendDevices[i].LastConnected){
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessNetworkState_i_L0+0, 0 
	MOVWF       R0 
	MOVF        ProcessNetworkState_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessNetworkState391:
	BZ          L__ProcessNetworkState392
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessNetworkState391
L__ProcessNetworkState392:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC0+0, 0 
	XORWF       POSTINC2+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessNetworkState184
;ZigbeeRemoteIOV1.0.c,525 :: 		ZigbeeSendDevices[i].LastConnected=ZigbeeSendDevices[i].Connected;
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessNetworkState_i_L0+0, 0 
	MOVWF       R0 
	MOVF        ProcessNetworkState_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessNetworkState393:
	BZ          L__ProcessNetworkState394
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessNetworkState393
L__ProcessNetworkState394:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,526 :: 		if(ZigbeeSendDevices[i].Connected==1){
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessNetworkState_i_L0+0, 0 
	MOVWF       R0 
	MOVF        ProcessNetworkState_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessNetworkState395:
	BZ          L__ProcessNetworkState396
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessNetworkState395
L__ProcessNetworkState396:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessNetworkState185
;ZigbeeRemoteIOV1.0.c,527 :: 		SendIOsToDevice(ZigbeeSendDevices[i].Address64);
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessNetworkState_i_L0+0, 0 
	MOVWF       R0 
	MOVF        ProcessNetworkState_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessNetworkState397:
	BZ          L__ProcessNetworkState398
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessNetworkState397
L__ProcessNetworkState398:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SendIOsToDevice_deviceAddress+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SendIOsToDevice_deviceAddress+1 
	CALL        _SendIOsToDevice+0, 0
;ZigbeeRemoteIOV1.0.c,528 :: 		SendDataPacket(ZigbeeSendDevices[i].Address64,"IO|GETSTATE",11,0);
	MOVLW       3
	MOVWF       R2 
	MOVF        ProcessNetworkState_i_L0+0, 0 
	MOVWF       R0 
	MOVF        ProcessNetworkState_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessNetworkState399:
	BZ          L__ProcessNetworkState400
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessNetworkState399
L__ProcessNetworkState400:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SendDataPacket_sendto+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_SendDataPacket_sendto+1 
	MOVLW       ?lstr26_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr26_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       11
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,529 :: 		}
L_ProcessNetworkState185:
;ZigbeeRemoteIOV1.0.c,530 :: 		}
L_ProcessNetworkState184:
;ZigbeeRemoteIOV1.0.c,522 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	INFSNZ      ProcessNetworkState_i_L0+0, 1 
	INCF        ProcessNetworkState_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,531 :: 		}
	GOTO        L_ProcessNetworkState181
L_ProcessNetworkState182:
;ZigbeeRemoteIOV1.0.c,533 :: 		if(JoinedLastState!=JoinedToNet){
	MOVF        _JoinedLastState+1, 0 
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessNetworkState401
	MOVF        _JoinedToNet+0, 0 
	XORWF       _JoinedLastState+0, 0 
L__ProcessNetworkState401:
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessNetworkState186
;ZigbeeRemoteIOV1.0.c,535 :: 		JoinedLastState=JoinedToNet;
	MOVF        _JoinedToNet+0, 0 
	MOVWF       _JoinedLastState+0 
	MOVF        _JoinedToNet+1, 0 
	MOVWF       _JoinedLastState+1 
;ZigbeeRemoteIOV1.0.c,536 :: 		if(JoinedToNet==2)
	MOVLW       0
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessNetworkState402
	MOVLW       2
	XORWF       _JoinedToNet+0, 0 
L__ProcessNetworkState402:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessNetworkState187
;ZigbeeRemoteIOV1.0.c,537 :: 		SendIOsToDevice(0);
	CLRF        FARG_SendIOsToDevice_deviceAddress+0 
	CLRF        FARG_SendIOsToDevice_deviceAddress+1 
	CALL        _SendIOsToDevice+0, 0
L_ProcessNetworkState187:
;ZigbeeRemoteIOV1.0.c,538 :: 		}
L_ProcessNetworkState186:
;ZigbeeRemoteIOV1.0.c,542 :: 		}
L_end_ProcessNetworkState:
	RETURN      0
; end of _ProcessNetworkState

_ProcessInputs:

;ZigbeeRemoteIOV1.0.c,546 :: 		void ProcessInputs(){
;ZigbeeRemoteIOV1.0.c,552 :: 		for(i=0;i<4;i++){
	CLRF        ProcessInputs_i_L0+0 
	CLRF        ProcessInputs_i_L0+1 
L_ProcessInputs188:
	MOVLW       128
	XORWF       ProcessInputs_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs404
	MOVLW       4
	SUBWF       ProcessInputs_i_L0+0, 0 
L__ProcessInputs404:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs189
;ZigbeeRemoteIOV1.0.c,553 :: 		int portval=!((PORTB & (1 << Inputs[i].IONum))!=0);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ProcessInputs_i_L0+0, 0 
	MOVWF       R4 
	MOVF        ProcessInputs_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVFF       R3, FSR0
	MOVFF       R4, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__ProcessInputs405:
	BZ          L__ProcessInputs406
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__ProcessInputs405
L__ProcessInputs406:
	MOVF        R0, 0 
	ANDWF       PORTB+0, 0 
	MOVWF       ProcessInputs_portval_L1+0 
	MOVLW       0
	ANDWF       R1, 0 
	MOVWF       ProcessInputs_portval_L1+1 
	MOVLW       0
	XORWF       ProcessInputs_portval_L1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs407
	MOVLW       0
	XORWF       ProcessInputs_portval_L1+0, 0 
L__ProcessInputs407:
	MOVLW       0
	BTFSS       STATUS+0, 2 
	MOVLW       1
	MOVWF       ProcessInputs_portval_L1+0 
	MOVF        ProcessInputs_portval_L1+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       ProcessInputs_portval_L1+0 
	MOVLW       0
	MOVWF       ProcessInputs_portval_L1+1 
;ZigbeeRemoteIOV1.0.c,555 :: 		if(portval!=Inputs[i].LastState){
	MOVLW       1
	ADDWF       R3, 0 
	MOVWF       FSR2 
	MOVLW       0
	ADDWFC      R4, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVF        ProcessInputs_portval_L1+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs408
	MOVF        R1, 0 
	XORWF       ProcessInputs_portval_L1+0, 0 
L__ProcessInputs408:
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs191
;ZigbeeRemoteIOV1.0.c,556 :: 		Inputs[i].WaitDebounce=1;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ProcessInputs_i_L0+0, 0 
	MOVWF       R4 
	MOVF        ProcessInputs_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,557 :: 		if(DebounceVal>Inputs[i].Debounce+5){
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ProcessInputs_i_L0+0, 0 
	MOVWF       R4 
	MOVF        ProcessInputs_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       5
	ADDWF       POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _DebounceVal+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs409
	MOVF        _DebounceVal+0, 0 
	SUBWF       R1, 0 
L__ProcessInputs409:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs192
;ZigbeeRemoteIOV1.0.c,559 :: 		Inputs[i].WaitDebounce=0;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ProcessInputs_i_L0+0, 0 
	MOVWF       R4 
	MOVF        ProcessInputs_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,560 :: 		Inputs[i].LastState=portval;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ProcessInputs_i_L0+0, 0 
	MOVWF       R4 
	MOVF        ProcessInputs_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        ProcessInputs_portval_L1+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        ProcessInputs_portval_L1+1, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,561 :: 		sprinti(SendStr,"%s|%d\0",Inputs[i].Name,portval);
	MOVLW       _SendStr+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_SendStr+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_27_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_27_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_27_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ProcessInputs_i_L0+0, 0 
	MOVWF       R4 
	MOVF        ProcessInputs_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       6
	ADDWF       FARG_sprinti_wh+5, 1 
	MOVLW       0
	ADDWFC      FARG_sprinti_wh+6, 1 
	MOVF        ProcessInputs_portval_L1+0, 0 
	MOVWF       FARG_sprinti_wh+7 
	MOVF        ProcessInputs_portval_L1+1, 0 
	MOVWF       FARG_sprinti_wh+8 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,562 :: 		SendDataPacket2All(SendStr,strlen(SendStr),0);
	MOVLW       _SendStr+0
	MOVWF       FARG_strlen_s+0 
	MOVLW       hi_addr(_SendStr+0)
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SendDataPacket2All_len+0 
	MOVF        R1, 0 
	MOVWF       FARG_SendDataPacket2All_len+1 
	MOVLW       _SendStr+0
	MOVWF       FARG_SendDataPacket2All_DataPacket+0 
	MOVLW       hi_addr(_SendStr+0)
	MOVWF       FARG_SendDataPacket2All_DataPacket+1 
	CLRF        FARG_SendDataPacket2All_Ack+0 
	CALL        _SendDataPacket2All+0, 0
;ZigbeeRemoteIOV1.0.c,563 :: 		}
L_ProcessInputs192:
;ZigbeeRemoteIOV1.0.c,564 :: 		}
L_ProcessInputs191:
;ZigbeeRemoteIOV1.0.c,565 :: 		if( Inputs[i].WaitDebounce==0){
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ProcessInputs_i_L0+0, 0 
	MOVWF       R4 
	MOVF        ProcessInputs_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs193
;ZigbeeRemoteIOV1.0.c,566 :: 		Inputs[i].Debounce=DebounceVal;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        ProcessInputs_i_L0+0, 0 
	MOVWF       R4 
	MOVF        ProcessInputs_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _DebounceVal+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        _DebounceVal+1, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,567 :: 		}
L_ProcessInputs193:
;ZigbeeRemoteIOV1.0.c,552 :: 		for(i=0;i<4;i++){
	INFSNZ      ProcessInputs_i_L0+0, 1 
	INCF        ProcessInputs_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,569 :: 		}
	GOTO        L_ProcessInputs188
L_ProcessInputs189:
;ZigbeeRemoteIOV1.0.c,570 :: 		DebounceVal++;
	INFSNZ      _DebounceVal+0, 1 
	INCF        _DebounceVal+1, 1 
;ZigbeeRemoteIOV1.0.c,573 :: 		}
L_end_ProcessInputs:
	RETURN      0
; end of _ProcessInputs

_write_eeprom_from:

;ZigbeeRemoteIOV1.0.c,577 :: 		void write_eeprom_from(unsigned int startaddress,char *str){
;ZigbeeRemoteIOV1.0.c,580 :: 		int i=0,j=0;
	CLRF        write_eeprom_from_i_L0+0 
	CLRF        write_eeprom_from_i_L0+1 
	CLRF        write_eeprom_from_j_L0+0 
	CLRF        write_eeprom_from_j_L0+1 
;ZigbeeRemoteIOV1.0.c,581 :: 		for(i=0;i<16;i=i+2){
	CLRF        write_eeprom_from_i_L0+0 
	CLRF        write_eeprom_from_i_L0+1 
L_write_eeprom_from194:
	MOVLW       128
	XORWF       write_eeprom_from_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_eeprom_from411
	MOVLW       16
	SUBWF       write_eeprom_from_i_L0+0, 0 
L__write_eeprom_from411:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_eeprom_from195
;ZigbeeRemoteIOV1.0.c,582 :: 		hexstr[0]=str[i];
	MOVF        write_eeprom_from_i_L0+0, 0 
	ADDWF       FARG_write_eeprom_from_str+0, 0 
	MOVWF       FSR0 
	MOVF        write_eeprom_from_i_L0+1, 0 
	ADDWFC      FARG_write_eeprom_from_str+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       write_eeprom_from_hexstr_L0+0 
;ZigbeeRemoteIOV1.0.c,583 :: 		hexstr[1]=str[i+1];
	MOVLW       1
	ADDWF       write_eeprom_from_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      write_eeprom_from_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_write_eeprom_from_str+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_write_eeprom_from_str+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       write_eeprom_from_hexstr_L0+1 
;ZigbeeRemoteIOV1.0.c,584 :: 		hexstr[2]='\0';
	CLRF        write_eeprom_from_hexstr_L0+2 
;ZigbeeRemoteIOV1.0.c,585 :: 		hexval=xtoi(hexstr);
	MOVLW       write_eeprom_from_hexstr_L0+0
	MOVWF       FARG_xtoi_s+0 
	MOVLW       hi_addr(write_eeprom_from_hexstr_L0+0)
	MOVWF       FARG_xtoi_s+1 
	CALL        _xtoi+0, 0
;ZigbeeRemoteIOV1.0.c,586 :: 		EEPROM_Write(startaddress+j,hexval);
	MOVF        write_eeprom_from_j_L0+0, 0 
	ADDWF       FARG_write_eeprom_from_startaddress+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ZigbeeRemoteIOV1.0.c,587 :: 		delay_ms(30);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       212
	MOVWF       R12, 0
	MOVLW       133
	MOVWF       R13, 0
L_write_eeprom_from197:
	DECFSZ      R13, 1, 1
	BRA         L_write_eeprom_from197
	DECFSZ      R12, 1, 1
	BRA         L_write_eeprom_from197
	DECFSZ      R11, 1, 1
	BRA         L_write_eeprom_from197
;ZigbeeRemoteIOV1.0.c,588 :: 		j++;
	INFSNZ      write_eeprom_from_j_L0+0, 1 
	INCF        write_eeprom_from_j_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,581 :: 		for(i=0;i<16;i=i+2){
	MOVLW       2
	ADDWF       write_eeprom_from_i_L0+0, 1 
	MOVLW       0
	ADDWFC      write_eeprom_from_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,589 :: 		}
	GOTO        L_write_eeprom_from194
L_write_eeprom_from195:
;ZigbeeRemoteIOV1.0.c,590 :: 		}
L_end_write_eeprom_from:
	RETURN      0
; end of _write_eeprom_from

_read_eeprom_to:

;ZigbeeRemoteIOV1.0.c,592 :: 		void read_eeprom_to(unsigned int startadress,char *dest){
;ZigbeeRemoteIOV1.0.c,595 :: 		for(i=0;i<8;i++){
	CLRF        read_eeprom_to_i_L0+0 
	CLRF        read_eeprom_to_i_L0+1 
L_read_eeprom_to198:
	MOVLW       128
	XORWF       read_eeprom_to_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_eeprom_to413
	MOVLW       8
	SUBWF       read_eeprom_to_i_L0+0, 0 
L__read_eeprom_to413:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_eeprom_to199
;ZigbeeRemoteIOV1.0.c,596 :: 		delay_ms(40);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       112
	MOVWF       R12, 0
	MOVLW       92
	MOVWF       R13, 0
L_read_eeprom_to201:
	DECFSZ      R13, 1, 1
	BRA         L_read_eeprom_to201
	DECFSZ      R12, 1, 1
	BRA         L_read_eeprom_to201
	DECFSZ      R11, 1, 1
	BRA         L_read_eeprom_to201
	NOP
;ZigbeeRemoteIOV1.0.c,597 :: 		dest[i]=EEPROM_Read(startadress+i);
	MOVF        read_eeprom_to_i_L0+0, 0 
	ADDWF       FARG_read_eeprom_to_dest+0, 0 
	MOVWF       FLOC__read_eeprom_to+0 
	MOVF        read_eeprom_to_i_L0+1, 0 
	ADDWFC      FARG_read_eeprom_to_dest+1, 0 
	MOVWF       FLOC__read_eeprom_to+1 
	MOVF        read_eeprom_to_i_L0+0, 0 
	ADDWF       FARG_read_eeprom_to_startadress+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__read_eeprom_to+0, FSR1
	MOVFF       FLOC__read_eeprom_to+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,595 :: 		for(i=0;i<8;i++){
	INFSNZ      read_eeprom_to_i_L0+0, 1 
	INCF        read_eeprom_to_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,599 :: 		}
	GOTO        L_read_eeprom_to198
L_read_eeprom_to199:
;ZigbeeRemoteIOV1.0.c,601 :: 		}
L_end_read_eeprom_to:
	RETURN      0
; end of _read_eeprom_to

_main:

;ZigbeeRemoteIOV1.0.c,602 :: 		void main() {
;ZigbeeRemoteIOV1.0.c,604 :: 		int i, MY_retry=0;
;ZigbeeRemoteIOV1.0.c,608 :: 		char del[2] = "|";
	MOVLW       124
	MOVWF       main_del_L0+0 
	CLRF        main_del_L0+1 
;ZigbeeRemoteIOV1.0.c,612 :: 		delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main202:
	DECFSZ      R13, 1, 1
	BRA         L_main202
	DECFSZ      R12, 1, 1
	BRA         L_main202
	DECFSZ      R11, 1, 1
	BRA         L_main202
	NOP
	NOP
;ZigbeeRemoteIOV1.0.c,613 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,614 :: 		JoinedLastState=0;
	CLRF        _JoinedLastState+0 
	CLRF        _JoinedLastState+1 
;ZigbeeRemoteIOV1.0.c,616 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       225
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;ZigbeeRemoteIOV1.0.c,618 :: 		MM_Init();
	CALL        _MM_Init+0, 0
;ZigbeeRemoteIOV1.0.c,620 :: 		for(i=0;i<10;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main203:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main415
	MOVLW       10
	SUBWF       main_i_L0+0, 0 
L__main415:
	BTFSC       STATUS+0, 0 
	GOTO        L_main204
;ZigbeeRemoteIOV1.0.c,621 :: 		CommandTrimmed[i]=(char *)malloc(sizeof(char)*30);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_CommandTrimmed_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(main_CommandTrimmed_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       30
	MOVWF       FARG_Malloc_Size+0 
	MOVLW       0
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,620 :: 		for(i=0;i<10;i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,623 :: 		}
	GOTO        L_main203
L_main204:
;ZigbeeRemoteIOV1.0.c,629 :: 		PICOUT1_Direction=0;
	BCF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,630 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,631 :: 		PICOUT2_Direction=0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,632 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,633 :: 		PICOUT3_Direction=0;
	BCF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,634 :: 		PICOUT3=0;
	BCF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,635 :: 		PICOUT4_Direction=0;
	BCF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,636 :: 		PICOUT4=0;
	BCF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,641 :: 		PICIN1_Direction=1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;ZigbeeRemoteIOV1.0.c,642 :: 		PICIN2_Direction=1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;ZigbeeRemoteIOV1.0.c,643 :: 		PICIN3_Direction=1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;ZigbeeRemoteIOV1.0.c,644 :: 		PICIN4_Direction=1;
	BSF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;ZigbeeRemoteIOV1.0.c,645 :: 		USBON_Direction=1;
	BSF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;ZigbeeRemoteIOV1.0.c,646 :: 		PROG_Direction=1;
	BSF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;ZigbeeRemoteIOV1.0.c,648 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main206:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main416
	MOVLW       2
	SUBWF       main_i_L0+0, 0 
L__main416:
	BTFSC       STATUS+0, 0 
	GOTO        L_main207
;ZigbeeRemoteIOV1.0.c,649 :: 		ZigbeeSendDevices[i].Connected=0;
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main417:
	BZ          L__main418
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main417
L__main418:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,650 :: 		ZigbeeSendDevices[i].LastConnected=0;
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main419:
	BZ          L__main420
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main419
L__main420:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       3
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,651 :: 		ZigbeeSendDevices[i].Enabled=EEPROM_Read(1+(i*9));
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main421:
	BZ          L__main422
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main421
L__main422:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       9
	MULWF       main_i_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,652 :: 		ZigbeeSendDevices[i].Address64=(unsigned short*)malloc(sizeof(char) *8);
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main423:
	BZ          L__main424
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main423
L__main424:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       8
	MOVWF       FARG_Malloc_Size+0 
	MOVLW       0
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,653 :: 		ZigbeeSendDevices[i].Address16=(unsigned short*)malloc(sizeof(char) *4);
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main425:
	BZ          L__main426
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main425
L__main426:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       4
	MOVWF       FARG_Malloc_Size+0 
	MOVLW       0
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,654 :: 		delay_ms(20);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main209:
	DECFSZ      R13, 1, 1
	BRA         L_main209
	DECFSZ      R12, 1, 1
	BRA         L_main209
	DECFSZ      R11, 1, 1
	BRA         L_main209
;ZigbeeRemoteIOV1.0.c,655 :: 		read_eeprom_to(2+(i*9),ZigbeeSendDevices[i].Address64);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_read_eeprom_to_startadress+1 
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main427:
	BZ          L__main428
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main427
L__main428:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+1 
	CALL        _read_eeprom_to+0, 0
;ZigbeeRemoteIOV1.0.c,656 :: 		delay_ms(20);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main210:
	DECFSZ      R13, 1, 1
	BRA         L_main210
	DECFSZ      R12, 1, 1
	BRA         L_main210
	DECFSZ      R11, 1, 1
	BRA         L_main210
;ZigbeeRemoteIOV1.0.c,648 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,657 :: 		}
	GOTO        L_main206
L_main207:
;ZigbeeRemoteIOV1.0.c,661 :: 		for(i=0;i<4;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main211:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main429
	MOVLW       4
	SUBWF       main_i_L0+0, 0 
L__main429:
	BTFSC       STATUS+0, 0 
	GOTO        L_main212
;ZigbeeRemoteIOV1.0.c,662 :: 		Inputs[i].IONum=i;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        main_i_L0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,663 :: 		Inputs[i].LastState=((PORTB & (1 << Inputs[i].IONum))!=0);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       R2 
	MOVLW       1
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        R2, 0 
L__main430:
	BZ          L__main431
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main430
L__main431:
	MOVF        R0, 0 
	ANDWF       PORTB+0, 0 
	MOVWF       R2 
	MOVLW       0
	ANDWF       R1, 0 
	MOVWF       R3 
	MOVLW       0
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main432
	MOVLW       0
	XORWF       R2, 0 
L__main432:
	MOVLW       0
	BTFSS       STATUS+0, 2 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,664 :: 		Inputs[i].LastState=!Inputs[i].LastState;
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVFF       R3, FSR0
	MOVFF       R4, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	IORWF       R2, 0 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVFF       R3, FSR1
	MOVFF       R4, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVLW       0
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,665 :: 		sprinti(Inputs[i].Name,"IN|%d",i+1);
	MOVLW       12
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Inputs+0
	ADDWF       R0, 0 
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_Inputs+0)
	ADDWFC      R1, 0 
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       6
	ADDWF       FARG_sprinti_wh+0, 1 
	MOVLW       0
	ADDWFC      FARG_sprinti_wh+1, 1 
	MOVLW       ?lstr_28_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_28_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_28_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVLW       1
	ADDWF       main_i_L0+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       0
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FARG_sprinti_wh+6 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,661 :: 		for(i=0;i<4;i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,666 :: 		}
	GOTO        L_main211
L_main212:
;ZigbeeRemoteIOV1.0.c,668 :: 		ADCON0 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON0+0, 1 
;ZigbeeRemoteIOV1.0.c,669 :: 		ADCON1 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;ZigbeeRemoteIOV1.0.c,670 :: 		ADCON2 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON2+0, 1 
;ZigbeeRemoteIOV1.0.c,671 :: 		CMCON  |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;ZigbeeRemoteIOV1.0.c,675 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;ZigbeeRemoteIOV1.0.c,676 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;ZigbeeRemoteIOV1.0.c,677 :: 		PIE1.RCIE = 1; //enable interrupt.
	BSF         PIE1+0, 5 
;ZigbeeRemoteIOV1.0.c,683 :: 		if(USBON)
	BTFSS       PORTB+0, 4 
	GOTO        L_main214
;ZigbeeRemoteIOV1.0.c,684 :: 		HID_Enable(readbuff,writebuff);      // Enable HID communication
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
L_main214:
;ZigbeeRemoteIOV1.0.c,688 :: 		debug=0;
	CLRF        _debug+0 
	CLRF        _debug+1 
;ZigbeeRemoteIOV1.0.c,691 :: 		SendRawPacket(ND, 8);
	MOVLW       _ND+0
	MOVWF       FARG_SendRawPacket_RawPacket+0 
	MOVLW       hi_addr(_ND+0)
	MOVWF       FARG_SendRawPacket_RawPacket+1 
	MOVLW       8
	MOVWF       FARG_SendRawPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendRawPacket_len+1 
	CALL        _SendRawPacket+0, 0
;ZigbeeRemoteIOV1.0.c,693 :: 		while(1)
L_main215:
;ZigbeeRemoteIOV1.0.c,697 :: 		if(GotFrame==1){
	MOVF        _GotFrame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main217
;ZigbeeRemoteIOV1.0.c,698 :: 		GotFrame=0;
	CLRF        _GotFrame+0 
;ZigbeeRemoteIOV1.0.c,699 :: 		ProcessZigBeeFrame();
	CALL        _ProcessZigBeeFrame+0, 0
;ZigbeeRemoteIOV1.0.c,701 :: 		}
	GOTO        L_main218
L_main217:
;ZigbeeRemoteIOV1.0.c,704 :: 		ProcessInputs();
	CALL        _ProcessInputs+0, 0
;ZigbeeRemoteIOV1.0.c,705 :: 		ProcessNetworkState();
	CALL        _ProcessNetworkState+0, 0
;ZigbeeRemoteIOV1.0.c,706 :: 		Delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_main219:
	DECFSZ      R13, 1, 1
	BRA         L_main219
	DECFSZ      R12, 1, 1
	BRA         L_main219
	NOP
;ZigbeeRemoteIOV1.0.c,707 :: 		}
L_main218:
;ZigbeeRemoteIOV1.0.c,709 :: 		if(USBON){
	BTFSS       PORTB+0, 4 
	GOTO        L_main220
;ZigbeeRemoteIOV1.0.c,711 :: 		if(!(hid_read()==0)) {
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main221
;ZigbeeRemoteIOV1.0.c,712 :: 		i=0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;ZigbeeRemoteIOV1.0.c,717 :: 		CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(readbuff,'\r'),'\n'), del);
	MOVLW       _readbuff+0
	MOVWF       FARG_DeleteChar_str+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_DeleteChar_str+1 
	MOVLW       13
	MOVWF       FARG_DeleteChar_oldChar+0 
	CALL        _DeleteChar+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_DeleteChar_str+0 
	MOVF        R1, 0 
	MOVWF       FARG_DeleteChar_str+1 
	MOVLW       10
	MOVWF       FARG_DeleteChar_oldChar+0 
	CALL        _DeleteChar+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_strtok_s1+0 
	MOVF        R1, 0 
	MOVWF       FARG_strtok_s1+1 
	MOVLW       main_del_L0+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(main_del_L0+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVF        R0, 0 
	MOVWF       main_CommandTrimmed_L0+0 
	MOVF        R1, 0 
	MOVWF       main_CommandTrimmed_L0+1 
;ZigbeeRemoteIOV1.0.c,720 :: 		do
L_main222:
;ZigbeeRemoteIOV1.0.c,723 :: 		i++;
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,724 :: 		CommandTrimmed[i] = strtok(0, del);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_CommandTrimmed_L0+0
	ADDWF       R0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(main_CommandTrimmed_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__main+1 
	CLRF        FARG_strtok_s1+0 
	CLRF        FARG_strtok_s1+1 
	MOVLW       main_del_L0+0
	MOVWF       FARG_strtok_s2+0 
	MOVLW       hi_addr(main_del_L0+0)
	MOVWF       FARG_strtok_s2+1 
	CALL        _strtok+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,727 :: 		while( CommandTrimmed[i] != 0 );
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       main_CommandTrimmed_L0+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(main_CommandTrimmed_L0+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main433
	MOVLW       0
	XORWF       R1, 0 
L__main433:
	BTFSS       STATUS+0, 2 
	GOTO        L_main222
;ZigbeeRemoteIOV1.0.c,731 :: 		if(strcmp(CommandTrimmed[0],"UPGRADE")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr29_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr29_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main434
	MOVLW       0
	XORWF       R0, 0 
L__main434:
	BTFSS       STATUS+0, 2 
	GOTO        L_main225
;ZigbeeRemoteIOV1.0.c,732 :: 		sprinti(writebuff,"UPGRADING\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_30_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_30_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_30_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,733 :: 		while(!hid_write(writebuff,64));
L_main226:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main227
	GOTO        L_main226
L_main227:
;ZigbeeRemoteIOV1.0.c,734 :: 		EEPROM_Write(0x00,0x01);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ZigbeeRemoteIOV1.0.c,735 :: 		HID_Disable();
	CALL        _HID_Disable+0, 0
;ZigbeeRemoteIOV1.0.c,736 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main228:
	DECFSZ      R13, 1, 1
	BRA         L_main228
	DECFSZ      R12, 1, 1
	BRA         L_main228
	DECFSZ      R11, 1, 1
	BRA         L_main228
	NOP
	NOP
;ZigbeeRemoteIOV1.0.c,737 :: 		asm { reset; }
	RESET
;ZigbeeRemoteIOV1.0.c,738 :: 		} else if(strcmp(CommandTrimmed[0],"SET")==0){
	GOTO        L_main229
L_main225:
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr31_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr31_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main435
	MOVLW       0
	XORWF       R0, 0 
L__main435:
	BTFSS       STATUS+0, 2 
	GOTO        L_main230
;ZigbeeRemoteIOV1.0.c,739 :: 		if(strcmp(CommandTrimmed[1],"DEBUG")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr32_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr32_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main436
	MOVLW       0
	XORWF       R0, 0 
L__main436:
	BTFSS       STATUS+0, 2 
	GOTO        L_main231
;ZigbeeRemoteIOV1.0.c,740 :: 		int debug_val=0;
;ZigbeeRemoteIOV1.0.c,741 :: 		debug_val=atoi(CommandTrimmed[2]);
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
;ZigbeeRemoteIOV1.0.c,742 :: 		debug=debug_val;
	MOVF        R0, 0 
	MOVWF       _debug+0 
	MOVF        R1, 0 
	MOVWF       _debug+1 
;ZigbeeRemoteIOV1.0.c,743 :: 		sprinti(writebuff,"DEBUG|%d\n",debug_val);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_33_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_33_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_33_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+6 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,744 :: 		while(!hid_write(writebuff,64));
L_main232:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main233
	GOTO        L_main232
L_main233:
;ZigbeeRemoteIOV1.0.c,745 :: 		}
L_main231:
;ZigbeeRemoteIOV1.0.c,746 :: 		}
	GOTO        L_main234
L_main230:
;ZigbeeRemoteIOV1.0.c,747 :: 		else if(strcmp(CommandTrimmed[0],"SEND")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr34_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr34_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main437
	MOVLW       0
	XORWF       R0, 0 
L__main437:
	BTFSS       STATUS+0, 2 
	GOTO        L_main235
;ZigbeeRemoteIOV1.0.c,748 :: 		SendDataPacket(0,CommandTrimmed[1],strlen(CommandTrimmed[1]),0);
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SendDataPacket_len+0 
	MOVF        R1, 0 
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_sendto+0 
	CLRF        FARG_SendDataPacket_sendto+1 
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,750 :: 		}
	GOTO        L_main236
L_main235:
;ZigbeeRemoteIOV1.0.c,751 :: 		else if(strcmp(CommandTrimmed[0],"?")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr35_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr35_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main438
	MOVLW       0
	XORWF       R0, 0 
L__main438:
	BTFSS       STATUS+0, 2 
	GOTO        L_main237
;ZigbeeRemoteIOV1.0.c,753 :: 		sprinti(writebuff,"KPP ZIGBEE BOARD V1.1\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_36_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_36_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_36_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,754 :: 		while(!hid_write(writebuff,64));
L_main238:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main239
	GOTO        L_main238
L_main239:
;ZigbeeRemoteIOV1.0.c,755 :: 		}
	GOTO        L_main240
L_main237:
;ZigbeeRemoteIOV1.0.c,756 :: 		else if(strcmp(CommandTrimmed[0],"READ")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr37_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr37_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main439
	MOVLW       0
	XORWF       R0, 0 
L__main439:
	BTFSS       STATUS+0, 2 
	GOTO        L_main241
;ZigbeeRemoteIOV1.0.c,758 :: 		}
	GOTO        L_main242
L_main241:
;ZigbeeRemoteIOV1.0.c,759 :: 		else if(strcmp(CommandTrimmed[0],"ZIGBEE")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr38_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr38_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main440
	MOVLW       0
	XORWF       R0, 0 
L__main440:
	BTFSS       STATUS+0, 2 
	GOTO        L_main243
;ZigbeeRemoteIOV1.0.c,761 :: 		if(strcmp(CommandTrimmed[1],"SET")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr39_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr39_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main441
	MOVLW       0
	XORWF       R0, 0 
L__main441:
	BTFSS       STATUS+0, 2 
	GOTO        L_main244
;ZigbeeRemoteIOV1.0.c,762 :: 		if(strcmp(CommandTrimmed[2],"DEVICE")==0){
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr40_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr40_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main442
	MOVLW       0
	XORWF       R0, 0 
L__main442:
	BTFSS       STATUS+0, 2 
	GOTO        L_main245
;ZigbeeRemoteIOV1.0.c,763 :: 		int devnum=0;
	CLRF        main_devnum_L6+0 
	CLRF        main_devnum_L6+1 
;ZigbeeRemoteIOV1.0.c,764 :: 		devnum=atoi(CommandTrimmed[3]);
	MOVF        main_CommandTrimmed_L0+6, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+7, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       main_devnum_L6+0 
	MOVF        R1, 0 
	MOVWF       main_devnum_L6+1 
;ZigbeeRemoteIOV1.0.c,765 :: 		if(devnum>0 && devnum-1<ZIGBEEDEVICES){
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main443
	MOVF        R0, 0 
	SUBLW       0
L__main443:
	BTFSC       STATUS+0, 0 
	GOTO        L_main248
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main444
	MOVLW       2
	SUBWF       R1, 0 
L__main444:
	BTFSC       STATUS+0, 0 
	GOTO        L_main248
L__main288:
;ZigbeeRemoteIOV1.0.c,767 :: 		enabledval=atoi(CommandTrimmed[4]);
	MOVF        main_CommandTrimmed_L0+8, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+9, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       main_enabledval_L7+0 
	MOVF        R1, 0 
	MOVWF       main_enabledval_L7+1 
;ZigbeeRemoteIOV1.0.c,768 :: 		if(enabledval==0 || enabledval==1){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main445
	MOVLW       0
	XORWF       R0, 0 
L__main445:
	BTFSC       STATUS+0, 2 
	GOTO        L__main287
	MOVLW       0
	XORWF       main_enabledval_L7+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main446
	MOVLW       1
	XORWF       main_enabledval_L7+0, 0 
L__main446:
	BTFSC       STATUS+0, 2 
	GOTO        L__main287
	GOTO        L_main251
L__main287:
;ZigbeeRemoteIOV1.0.c,769 :: 		write_eeprom_from(1+(devnum-1)*9,CommandTrimmed[4]);
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R1 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_write_eeprom_from_startaddress+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_write_eeprom_from_startaddress+1 
	MOVF        main_CommandTrimmed_L0+8, 0 
	MOVWF       FARG_write_eeprom_from_str+0 
	MOVF        main_CommandTrimmed_L0+9, 0 
	MOVWF       FARG_write_eeprom_from_str+1 
	CALL        _write_eeprom_from+0, 0
;ZigbeeRemoteIOV1.0.c,770 :: 		write_eeprom_from(2+(devnum-1)*9,CommandTrimmed[5]);
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R1 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FARG_write_eeprom_from_startaddress+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_write_eeprom_from_startaddress+1 
	MOVF        main_CommandTrimmed_L0+10, 0 
	MOVWF       FARG_write_eeprom_from_str+0 
	MOVF        main_CommandTrimmed_L0+11, 0 
	MOVWF       FARG_write_eeprom_from_str+1 
	CALL        _write_eeprom_from+0, 0
;ZigbeeRemoteIOV1.0.c,771 :: 		read_eeprom_to(1+(devnum-1)*9,ZigbeeSendDevices[i].Enabled);
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R1 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_read_eeprom_to_startadress+1 
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main447:
	BZ          L__main448
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main447
L__main448:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+1 
	CALL        _read_eeprom_to+0, 0
;ZigbeeRemoteIOV1.0.c,772 :: 		read_eeprom_to(2+(devnum-1)*9,ZigbeeSendDevices[i].Address64);
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R1 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_read_eeprom_to_startadress+1 
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main449:
	BZ          L__main450
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main449
L__main450:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+1 
	CALL        _read_eeprom_to+0, 0
;ZigbeeRemoteIOV1.0.c,773 :: 		}
L_main251:
;ZigbeeRemoteIOV1.0.c,774 :: 		}
L_main248:
;ZigbeeRemoteIOV1.0.c,775 :: 		}
L_main245:
;ZigbeeRemoteIOV1.0.c,776 :: 		}
	GOTO        L_main252
L_main244:
;ZigbeeRemoteIOV1.0.c,778 :: 		else if(strcmp(CommandTrimmed[1],"GET")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr41_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr41_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main451
	MOVLW       0
	XORWF       R0, 0 
L__main451:
	BTFSS       STATUS+0, 2 
	GOTO        L_main253
;ZigbeeRemoteIOV1.0.c,779 :: 		if(strcmp(CommandTrimmed[2],"DEVICE")==0){
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr42_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr42_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main452
	MOVLW       0
	XORWF       R0, 0 
L__main452:
	BTFSS       STATUS+0, 2 
	GOTO        L_main254
;ZigbeeRemoteIOV1.0.c,780 :: 		int devnum=0;
	CLRF        main_devnum_L6_L6+0 
	CLRF        main_devnum_L6_L6+1 
;ZigbeeRemoteIOV1.0.c,781 :: 		devnum=atoi(CommandTrimmed[3]);
	MOVF        main_CommandTrimmed_L0+6, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+7, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       main_devnum_L6_L6+0 
	MOVF        R1, 0 
	MOVWF       main_devnum_L6_L6+1 
;ZigbeeRemoteIOV1.0.c,782 :: 		if(devnum>0 && devnum-1<ZIGBEEDEVICES){
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main453
	MOVF        R0, 0 
	SUBLW       0
L__main453:
	BTFSC       STATUS+0, 0 
	GOTO        L_main257
	MOVLW       1
	SUBWF       main_devnum_L6_L6+0, 0 
	MOVWF       R1 
	MOVLW       0
	SUBWFB      main_devnum_L6_L6+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main454
	MOVLW       2
	SUBWF       R1, 0 
L__main454:
	BTFSC       STATUS+0, 0 
	GOTO        L_main257
L__main286:
;ZigbeeRemoteIOV1.0.c,783 :: 		int i,k=0;
	CLRF        main_k_L7+0 
	CLRF        main_k_L7+1 
;ZigbeeRemoteIOV1.0.c,786 :: 		for(i=0;i<8;i++){
	CLRF        main_i_L7+0 
	CLRF        main_i_L7+1 
L_main258:
	MOVLW       128
	XORWF       main_i_L7+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main455
	MOVLW       8
	SUBWF       main_i_L7+0, 0 
L__main455:
	BTFSC       STATUS+0, 0 
	GOTO        L_main259
;ZigbeeRemoteIOV1.0.c,787 :: 		ShortToHex(ZigbeeSendDevices[devnum-1].Address64[i],HostZigbeeStr+k);
	MOVLW       1
	SUBWF       main_devnum_L6_L6+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      main_devnum_L6_L6+1, 0 
	MOVWF       R4 
	MOVLW       3
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main456:
	BZ          L__main457
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main456
L__main457:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       4
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        main_i_L7+0, 0 
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVF        main_i_L7+1, 0 
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ShortToHex_input+0 
	MOVLW       main_HostZigbeeStr_L7+0
	ADDWF       main_k_L7+0, 0 
	MOVWF       FARG_ShortToHex_output+0 
	MOVLW       hi_addr(main_HostZigbeeStr_L7+0)
	ADDWFC      main_k_L7+1, 0 
	MOVWF       FARG_ShortToHex_output+1 
	CALL        _ShortToHex+0, 0
;ZigbeeRemoteIOV1.0.c,788 :: 		k=k+2;
	MOVLW       2
	ADDWF       main_k_L7+0, 1 
	MOVLW       0
	ADDWFC      main_k_L7+1, 1 
;ZigbeeRemoteIOV1.0.c,786 :: 		for(i=0;i<8;i++){
	INFSNZ      main_i_L7+0, 1 
	INCF        main_i_L7+1, 1 
;ZigbeeRemoteIOV1.0.c,789 :: 		}
	GOTO        L_main258
L_main259:
;ZigbeeRemoteIOV1.0.c,790 :: 		sprinti(writebuff,"ZIGBEE|DEVICE|%d|%s|%d\n",devnum,HostZigbeeStr,ZigbeeSendDevices[devnum-1].Enabled);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_43_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_43_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_43_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        main_devnum_L6_L6+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVF        main_devnum_L6_L6+1, 0 
	MOVWF       FARG_sprinti_wh+6 
	MOVLW       main_HostZigbeeStr_L7+0
	MOVWF       FARG_sprinti_wh+7 
	MOVLW       hi_addr(main_HostZigbeeStr_L7+0)
	MOVWF       FARG_sprinti_wh+8 
	MOVLW       1
	SUBWF       main_devnum_L6_L6+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      main_devnum_L6_L6+1, 0 
	MOVWF       R4 
	MOVLW       3
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main458:
	BZ          L__main459
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main458
L__main459:
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+9 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+10 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,791 :: 		while(!hid_write(writebuff,64));
L_main261:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main262
	GOTO        L_main261
L_main262:
;ZigbeeRemoteIOV1.0.c,792 :: 		}
L_main257:
;ZigbeeRemoteIOV1.0.c,793 :: 		}
L_main254:
;ZigbeeRemoteIOV1.0.c,794 :: 		}
	GOTO        L_main263
L_main253:
;ZigbeeRemoteIOV1.0.c,795 :: 		else if(strcmp(CommandTrimmed[1],"MY")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr44_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr44_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main460
	MOVLW       0
	XORWF       R0, 0 
L__main460:
	BTFSS       STATUS+0, 2 
	GOTO        L_main264
;ZigbeeRemoteIOV1.0.c,796 :: 		SendRawPacket(MY1, 8);
	MOVLW       _MY1+0
	MOVWF       FARG_SendRawPacket_RawPacket+0 
	MOVLW       hi_addr(_MY1+0)
	MOVWF       FARG_SendRawPacket_RawPacket+1 
	MOVLW       8
	MOVWF       FARG_SendRawPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendRawPacket_len+1 
	CALL        _SendRawPacket+0, 0
;ZigbeeRemoteIOV1.0.c,797 :: 		}
	GOTO        L_main265
L_main264:
;ZigbeeRemoteIOV1.0.c,798 :: 		else if(strcmp(CommandTrimmed[1],"ND")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr45_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr45_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main461
	MOVLW       0
	XORWF       R0, 0 
L__main461:
	BTFSS       STATUS+0, 2 
	GOTO        L_main266
;ZigbeeRemoteIOV1.0.c,799 :: 		SendRawPacket(ND, 8);
	MOVLW       _ND+0
	MOVWF       FARG_SendRawPacket_RawPacket+0 
	MOVLW       hi_addr(_ND+0)
	MOVWF       FARG_SendRawPacket_RawPacket+1 
	MOVLW       8
	MOVWF       FARG_SendRawPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendRawPacket_len+1 
	CALL        _SendRawPacket+0, 0
;ZigbeeRemoteIOV1.0.c,800 :: 		}
L_main266:
L_main265:
L_main263:
L_main252:
;ZigbeeRemoteIOV1.0.c,801 :: 		}
L_main243:
L_main242:
L_main240:
L_main236:
L_main234:
L_main229:
;ZigbeeRemoteIOV1.0.c,803 :: 		}
L_main221:
;ZigbeeRemoteIOV1.0.c,805 :: 		}
L_main220:
;ZigbeeRemoteIOV1.0.c,807 :: 		}
	GOTO        L_main215
;ZigbeeRemoteIOV1.0.c,811 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
