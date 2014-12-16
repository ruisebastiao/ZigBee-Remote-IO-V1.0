
_DeleteChar:

;ZigbeeRemoteIOV1.0.c,58 :: 		char *DeleteChar (char *str, char oldChar) {
;ZigbeeRemoteIOV1.0.c,59 :: 		char *strPtr = str;
	MOVF        FARG_DeleteChar_str+0, 0 
	MOVWF       DeleteChar_strPtr_L0+0 
	MOVF        FARG_DeleteChar_str+1, 0 
	MOVWF       DeleteChar_strPtr_L0+1 
;ZigbeeRemoteIOV1.0.c,60 :: 		while ((strPtr = strchr (strPtr, oldChar)) != 0)
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
	GOTO        L__DeleteChar328
	MOVLW       0
	XORWF       R0, 0 
L__DeleteChar328:
	BTFSC       STATUS+0, 2 
	GOTO        L_DeleteChar1
;ZigbeeRemoteIOV1.0.c,61 :: 		*strPtr++ = '\0';
	MOVFF       DeleteChar_strPtr_L0+0, FSR1
	MOVFF       DeleteChar_strPtr_L0+1, FSR1H
	CLRF        POSTINC1+0 
	INFSNZ      DeleteChar_strPtr_L0+0, 1 
	INCF        DeleteChar_strPtr_L0+1, 1 
	GOTO        L_DeleteChar0
L_DeleteChar1:
;ZigbeeRemoteIOV1.0.c,62 :: 		return str;
	MOVF        FARG_DeleteChar_str+0, 0 
	MOVWF       R0 
	MOVF        FARG_DeleteChar_str+1, 0 
	MOVWF       R1 
;ZigbeeRemoteIOV1.0.c,63 :: 		}
L_end_DeleteChar:
	RETURN      0
; end of _DeleteChar

_SendRawPacket:

;ZigbeeRemoteIOV1.0.c,67 :: 		void SendRawPacket(char* RawPacket,int len)
;ZigbeeRemoteIOV1.0.c,71 :: 		for( i=0; i<len; i++ )
	CLRF        SendRawPacket_i_L0+0 
	CLRF        SendRawPacket_i_L0+1 
L_SendRawPacket2:
	MOVLW       128
	XORWF       SendRawPacket_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_SendRawPacket_len+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendRawPacket330
	MOVF        FARG_SendRawPacket_len+0, 0 
	SUBWF       SendRawPacket_i_L0+0, 0 
L__SendRawPacket330:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendRawPacket3
;ZigbeeRemoteIOV1.0.c,73 :: 		UART1_Write( RawPacket[i]);
	MOVF        SendRawPacket_i_L0+0, 0 
	ADDWF       FARG_SendRawPacket_RawPacket+0, 0 
	MOVWF       FSR0 
	MOVF        SendRawPacket_i_L0+1, 0 
	ADDWFC      FARG_SendRawPacket_RawPacket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ZigbeeRemoteIOV1.0.c,71 :: 		for( i=0; i<len; i++ )
	INFSNZ      SendRawPacket_i_L0+0, 1 
	INCF        SendRawPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,74 :: 		}
	GOTO        L_SendRawPacket2
L_SendRawPacket3:
;ZigbeeRemoteIOV1.0.c,76 :: 		}
L_end_SendRawPacket:
	RETURN      0
; end of _SendRawPacket

_SendDataPacket:

;ZigbeeRemoteIOV1.0.c,78 :: 		void SendDataPacket(short brodcast,char* DataPacket,int len,char Ack)
;ZigbeeRemoteIOV1.0.c,80 :: 		int k=0,i, framesize2=14+len;
	CLRF        SendDataPacket_k_L0+0 
	CLRF        SendDataPacket_k_L0+1 
	MOVLW       14
	ADDWF       FARG_SendDataPacket_len+0, 0 
	MOVWF       SendDataPacket_framesize2_L0+0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_len+1, 0 
	MOVWF       SendDataPacket_framesize2_L0+1 
;ZigbeeRemoteIOV1.0.c,82 :: 		unsigned short checkSum=0;
	CLRF        SendDataPacket_checkSum_L0+0 
;ZigbeeRemoteIOV1.0.c,85 :: 		do{
L_SendDataPacket5:
;ZigbeeRemoteIOV1.0.c,87 :: 		ZigbeeSendDevice=ZigbeeSendDevices[k];
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        SendDataPacket_k_L0+0, 0 
	MOVWF       R4 
	MOVF        SendDataPacket_k_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       3
	MOVWF       R0 
	MOVLW       SendDataPacket_ZigbeeSendDevice_L0+0
	MOVWF       FSR1 
	MOVLW       hi_addr(SendDataPacket_ZigbeeSendDevice_L0+0)
	MOVWF       FSR1H 
L_SendDataPacket8:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket8
;ZigbeeRemoteIOV1.0.c,89 :: 		if(ZigbeeSendDevice.enabled==1 || brodcast==1){
	MOVF        SendDataPacket_ZigbeeSendDevice_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__SendDataPacket295
	MOVF        FARG_SendDataPacket_brodcast+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__SendDataPacket295
	GOTO        L_SendDataPacket11
L__SendDataPacket295:
;ZigbeeRemoteIOV1.0.c,90 :: 		DataToSend[0]=0x7E;
	MOVLW       126
	MOVWF       SendDataPacket_DataToSend_L0+0 
;ZigbeeRemoteIOV1.0.c,91 :: 		DataToSend[1]=0x00;
	CLRF        SendDataPacket_DataToSend_L0+1 
;ZigbeeRemoteIOV1.0.c,93 :: 		DataToSend[2]=framesize2;
	MOVF        SendDataPacket_framesize2_L0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+2 
;ZigbeeRemoteIOV1.0.c,94 :: 		DataToSend[3]=0x10;
	MOVLW       16
	MOVWF       SendDataPacket_DataToSend_L0+3 
;ZigbeeRemoteIOV1.0.c,95 :: 		DataToSend[4]=0x01;
	MOVLW       1
	MOVWF       SendDataPacket_DataToSend_L0+4 
;ZigbeeRemoteIOV1.0.c,98 :: 		if( brodcast==1 )
	MOVF        FARG_SendDataPacket_brodcast+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket12
;ZigbeeRemoteIOV1.0.c,101 :: 		DataToSend[5]=0;
	CLRF        SendDataPacket_DataToSend_L0+5 
;ZigbeeRemoteIOV1.0.c,102 :: 		DataToSend[6]=0;
	CLRF        SendDataPacket_DataToSend_L0+6 
;ZigbeeRemoteIOV1.0.c,103 :: 		DataToSend[7]=0;
	CLRF        SendDataPacket_DataToSend_L0+7 
;ZigbeeRemoteIOV1.0.c,104 :: 		DataToSend[8]=0;
	CLRF        SendDataPacket_DataToSend_L0+8 
;ZigbeeRemoteIOV1.0.c,105 :: 		DataToSend[9]=0;
	CLRF        SendDataPacket_DataToSend_L0+9 
;ZigbeeRemoteIOV1.0.c,106 :: 		DataToSend[10]=0;
	CLRF        SendDataPacket_DataToSend_L0+10 
;ZigbeeRemoteIOV1.0.c,107 :: 		DataToSend[11]=0;
	CLRF        SendDataPacket_DataToSend_L0+11 
;ZigbeeRemoteIOV1.0.c,108 :: 		DataToSend[12]=0;
	CLRF        SendDataPacket_DataToSend_L0+12 
;ZigbeeRemoteIOV1.0.c,109 :: 		}
	GOTO        L_SendDataPacket13
L_SendDataPacket12:
;ZigbeeRemoteIOV1.0.c,114 :: 		DataToSend[5]=ZigbeeSendDevice.Address[0];
	MOVFF       SendDataPacket_ZigbeeSendDevice_L0+1, FSR0
	MOVFF       SendDataPacket_ZigbeeSendDevice_L0+2, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+5 
;ZigbeeRemoteIOV1.0.c,115 :: 		DataToSend[6]=ZigbeeSendDevice.Address[1];
	MOVLW       1
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+1, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+6 
;ZigbeeRemoteIOV1.0.c,116 :: 		DataToSend[7]=ZigbeeSendDevice.Address[2];
	MOVLW       2
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+1, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+7 
;ZigbeeRemoteIOV1.0.c,117 :: 		DataToSend[8]=ZigbeeSendDevice.Address[3];
	MOVLW       3
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+1, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+8 
;ZigbeeRemoteIOV1.0.c,118 :: 		DataToSend[9]=ZigbeeSendDevice.Address[4];
	MOVLW       4
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+1, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+9 
;ZigbeeRemoteIOV1.0.c,119 :: 		DataToSend[10]=ZigbeeSendDevice.Address[5];
	MOVLW       5
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+1, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+10 
;ZigbeeRemoteIOV1.0.c,120 :: 		DataToSend[11]=ZigbeeSendDevice.Address[6];
	MOVLW       6
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+1, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+11 
;ZigbeeRemoteIOV1.0.c,121 :: 		DataToSend[12]=ZigbeeSendDevice.Address[7];
	MOVLW       7
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+1, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+12 
;ZigbeeRemoteIOV1.0.c,122 :: 		}
L_SendDataPacket13:
;ZigbeeRemoteIOV1.0.c,124 :: 		DataToSend[13]=0xFF;
	MOVLW       255
	MOVWF       SendDataPacket_DataToSend_L0+13 
;ZigbeeRemoteIOV1.0.c,125 :: 		DataToSend[14]=0xFE;
	MOVLW       254
	MOVWF       SendDataPacket_DataToSend_L0+14 
;ZigbeeRemoteIOV1.0.c,127 :: 		DataToSend[15]=0x00;
	CLRF        SendDataPacket_DataToSend_L0+15 
;ZigbeeRemoteIOV1.0.c,129 :: 		DataToSend[16]=0x01;
	MOVLW       1
	MOVWF       SendDataPacket_DataToSend_L0+16 
;ZigbeeRemoteIOV1.0.c,132 :: 		for( i=17; i<17+len; i++ )
	MOVLW       17
	MOVWF       SendDataPacket_i_L0+0 
	MOVLW       0
	MOVWF       SendDataPacket_i_L0+1 
L_SendDataPacket14:
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
	GOTO        L__SendDataPacket332
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket332:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket15
;ZigbeeRemoteIOV1.0.c,134 :: 		DataToSend[i]=DataPacket[i-17];
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
;ZigbeeRemoteIOV1.0.c,132 :: 		for( i=17; i<17+len; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,135 :: 		}
	GOTO        L_SendDataPacket14
L_SendDataPacket15:
;ZigbeeRemoteIOV1.0.c,138 :: 		for( i=3; i<framesize2+3; i++ )
	MOVLW       3
	MOVWF       SendDataPacket_i_L0+0 
	MOVLW       0
	MOVWF       SendDataPacket_i_L0+1 
L_SendDataPacket17:
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
	GOTO        L__SendDataPacket333
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket333:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket18
;ZigbeeRemoteIOV1.0.c,140 :: 		checkSum=checkSum+DataToSend[i];
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       SendDataPacket_checkSum_L0+0, 1 
;ZigbeeRemoteIOV1.0.c,138 :: 		for( i=3; i<framesize2+3; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,141 :: 		}
	GOTO        L_SendDataPacket17
L_SendDataPacket18:
;ZigbeeRemoteIOV1.0.c,143 :: 		checkSum=0xFF-checkSum;
	MOVF        SendDataPacket_checkSum_L0+0, 0 
	SUBLW       255
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       SendDataPacket_checkSum_L0+0 
;ZigbeeRemoteIOV1.0.c,146 :: 		DataToSend[i]=checkSum;
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,147 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket334
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket334:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket22
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket22
L__SendDataPacket294:
;ZigbeeRemoteIOV1.0.c,148 :: 		sprinti(writebuff,"Packet: ");
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
;ZigbeeRemoteIOV1.0.c,149 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket23:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket24
	GOTO        L_SendDataPacket23
L_SendDataPacket24:
;ZigbeeRemoteIOV1.0.c,150 :: 		}
L_SendDataPacket22:
;ZigbeeRemoteIOV1.0.c,152 :: 		for( i=0; i<framesize2+4; i++ )
	CLRF        SendDataPacket_i_L0+0 
	CLRF        SendDataPacket_i_L0+1 
L_SendDataPacket25:
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
	GOTO        L__SendDataPacket335
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket335:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket26
;ZigbeeRemoteIOV1.0.c,154 :: 		UART1_Write( DataToSend[i]);
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ZigbeeRemoteIOV1.0.c,155 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket336
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket336:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket30
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket30
L__SendDataPacket293:
;ZigbeeRemoteIOV1.0.c,156 :: 		sprinti(writebuff,"%X",DataToSend[i]);
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
;ZigbeeRemoteIOV1.0.c,157 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket31:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket32
	GOTO        L_SendDataPacket31
L_SendDataPacket32:
;ZigbeeRemoteIOV1.0.c,158 :: 		}
L_SendDataPacket30:
;ZigbeeRemoteIOV1.0.c,152 :: 		for( i=0; i<framesize2+4; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,159 :: 		}
	GOTO        L_SendDataPacket25
L_SendDataPacket26:
;ZigbeeRemoteIOV1.0.c,160 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket337
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket337:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket35
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket35
L__SendDataPacket292:
;ZigbeeRemoteIOV1.0.c,161 :: 		sprinti(writebuff,"\n");
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
;ZigbeeRemoteIOV1.0.c,162 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket36:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket37
	GOTO        L_SendDataPacket36
L_SendDataPacket37:
;ZigbeeRemoteIOV1.0.c,163 :: 		}
L_SendDataPacket35:
;ZigbeeRemoteIOV1.0.c,164 :: 		if(brodcast==1) break;
	MOVF        FARG_SendDataPacket_brodcast+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket38
	GOTO        L_SendDataPacket6
L_SendDataPacket38:
;ZigbeeRemoteIOV1.0.c,165 :: 		}
L_SendDataPacket11:
;ZigbeeRemoteIOV1.0.c,167 :: 		while(k<ZIGBEEDEVICES);
	MOVLW       128
	XORWF       SendDataPacket_k_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket338
	MOVLW       2
	SUBWF       SendDataPacket_k_L0+0, 0 
L__SendDataPacket338:
	BTFSS       STATUS+0, 0 
	GOTO        L_SendDataPacket5
L_SendDataPacket6:
;ZigbeeRemoteIOV1.0.c,168 :: 		}
L_end_SendDataPacket:
	RETURN      0
; end of _SendDataPacket

_ProcessZigBeeDataPacket:

;ZigbeeRemoteIOV1.0.c,170 :: 		void ProcessZigBeeDataPacket(char* DataPacket,char *DevIP)
;ZigbeeRemoteIOV1.0.c,174 :: 		char del[2] = "|";
	MOVLW       124
	MOVWF       ProcessZigBeeDataPacket_del_L0+0 
	CLRF        ProcessZigBeeDataPacket_del_L0+1 
	CLRF        ProcessZigBeeDataPacket_i_L0+0 
	CLRF        ProcessZigBeeDataPacket_i_L0+1 
;ZigbeeRemoteIOV1.0.c,178 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket340
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeDataPacket340:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket297
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket341
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeDataPacket341:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket297
	GOTO        L_ProcessZigBeeDataPacket43
L__ProcessZigBeeDataPacket297:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeDataPacket43
L__ProcessZigBeeDataPacket296:
;ZigbeeRemoteIOV1.0.c,179 :: 		sprinti(writebuff, "ZIGBEE|%s\n",DataPacket);
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
;ZigbeeRemoteIOV1.0.c,180 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeDataPacket44:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket45
	GOTO        L_ProcessZigBeeDataPacket44
L_ProcessZigBeeDataPacket45:
;ZigbeeRemoteIOV1.0.c,181 :: 		}
L_ProcessZigBeeDataPacket43:
;ZigbeeRemoteIOV1.0.c,184 :: 		CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(DataPacket,'\r'),'\n'), del);
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
;ZigbeeRemoteIOV1.0.c,187 :: 		do
L_ProcessZigBeeDataPacket46:
;ZigbeeRemoteIOV1.0.c,190 :: 		i++;
	INFSNZ      ProcessZigBeeDataPacket_i_L0+0, 1 
	INCF        ProcessZigBeeDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,191 :: 		CommandTrimmed[i] = strtok(0, del);
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
;ZigbeeRemoteIOV1.0.c,194 :: 		while( CommandTrimmed[i] != 0 );
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
	GOTO        L__ProcessZigBeeDataPacket342
	MOVLW       0
	XORWF       R1, 0 
L__ProcessZigBeeDataPacket342:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket46
;ZigbeeRemoteIOV1.0.c,200 :: 		if(strcmp(CommandTrimmed[0],"OUT")==0){
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
	GOTO        L__ProcessZigBeeDataPacket343
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket343:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket49
;ZigbeeRemoteIOV1.0.c,201 :: 		if(strcmp(CommandTrimmed[1],"1")==0){
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
	GOTO        L__ProcessZigBeeDataPacket344
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket344:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket50
;ZigbeeRemoteIOV1.0.c,202 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr7_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr7_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket345
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket345:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket51
;ZigbeeRemoteIOV1.0.c,203 :: 		PICOUT1=1;
	BSF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,204 :: 		}
	GOTO        L_ProcessZigBeeDataPacket52
L_ProcessZigBeeDataPacket51:
;ZigbeeRemoteIOV1.0.c,205 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr8_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr8_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket346
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket346:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket53
;ZigbeeRemoteIOV1.0.c,206 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,207 :: 		}
L_ProcessZigBeeDataPacket53:
L_ProcessZigBeeDataPacket52:
;ZigbeeRemoteIOV1.0.c,208 :: 		}
	GOTO        L_ProcessZigBeeDataPacket54
L_ProcessZigBeeDataPacket50:
;ZigbeeRemoteIOV1.0.c,209 :: 		else  if(strcmp(CommandTrimmed[1],"2")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr9_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr9_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket347
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket347:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket55
;ZigbeeRemoteIOV1.0.c,210 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket348
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket348:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket56
;ZigbeeRemoteIOV1.0.c,211 :: 		PICOUT2=1;
	BSF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,212 :: 		}
	GOTO        L_ProcessZigBeeDataPacket57
L_ProcessZigBeeDataPacket56:
;ZigbeeRemoteIOV1.0.c,213 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr11_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr11_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket349
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket349:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket58
;ZigbeeRemoteIOV1.0.c,214 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,215 :: 		}
L_ProcessZigBeeDataPacket58:
L_ProcessZigBeeDataPacket57:
;ZigbeeRemoteIOV1.0.c,216 :: 		}
	GOTO        L_ProcessZigBeeDataPacket59
L_ProcessZigBeeDataPacket55:
;ZigbeeRemoteIOV1.0.c,217 :: 		else if(strcmp(CommandTrimmed[1],"3")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr12_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr12_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket350
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket350:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket60
;ZigbeeRemoteIOV1.0.c,218 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket351
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket351:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket61
;ZigbeeRemoteIOV1.0.c,219 :: 		PICOUT3=1;
	BSF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,220 :: 		}
	GOTO        L_ProcessZigBeeDataPacket62
L_ProcessZigBeeDataPacket61:
;ZigbeeRemoteIOV1.0.c,221 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr14_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr14_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket352
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket352:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket63
;ZigbeeRemoteIOV1.0.c,222 :: 		PICOUT3=0;
	BCF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,223 :: 		}
L_ProcessZigBeeDataPacket63:
L_ProcessZigBeeDataPacket62:
;ZigbeeRemoteIOV1.0.c,224 :: 		}
	GOTO        L_ProcessZigBeeDataPacket64
L_ProcessZigBeeDataPacket60:
;ZigbeeRemoteIOV1.0.c,225 :: 		else if(strcmp(CommandTrimmed[1],"4")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr15_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr15_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket353
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket353:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket65
;ZigbeeRemoteIOV1.0.c,226 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket354
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket354:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket66
;ZigbeeRemoteIOV1.0.c,227 :: 		PICOUT4=1;
	BSF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,228 :: 		}
	GOTO        L_ProcessZigBeeDataPacket67
L_ProcessZigBeeDataPacket66:
;ZigbeeRemoteIOV1.0.c,229 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        ProcessZigBeeDataPacket_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr17_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr17_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket355
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket355:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket68
;ZigbeeRemoteIOV1.0.c,230 :: 		PICOUT4=0;
	BCF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,231 :: 		}
L_ProcessZigBeeDataPacket68:
L_ProcessZigBeeDataPacket67:
;ZigbeeRemoteIOV1.0.c,232 :: 		}
L_ProcessZigBeeDataPacket65:
L_ProcessZigBeeDataPacket64:
L_ProcessZigBeeDataPacket59:
L_ProcessZigBeeDataPacket54:
;ZigbeeRemoteIOV1.0.c,233 :: 		}
L_ProcessZigBeeDataPacket49:
;ZigbeeRemoteIOV1.0.c,237 :: 		}
L_end_ProcessZigBeeDataPacket:
	RETURN      0
; end of _ProcessZigBeeDataPacket

_ProcessZigBeeFrame:

;ZigbeeRemoteIOV1.0.c,241 :: 		void ProcessZigBeeFrame()
;ZigbeeRemoteIOV1.0.c,244 :: 		int FrameType=0;
	CLRF        ProcessZigBeeFrame_FrameType_L0+0 
	CLRF        ProcessZigBeeFrame_FrameType_L0+1 
	CLRF        ProcessZigBeeFrame_ATCommand_L0+0 
	CLRF        ProcessZigBeeFrame_ATCommand_L0+1 
;ZigbeeRemoteIOV1.0.c,259 :: 		FrameType=ZigbeeFrame[3];
	MOVF        _ZigbeeFrame+3, 0 
	MOVWF       ProcessZigBeeFrame_FrameType_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_FrameType_L0+1 
;ZigbeeRemoteIOV1.0.c,262 :: 		if( FrameType==0x90 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame357
	MOVLW       144
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame357:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame69
;ZigbeeRemoteIOV1.0.c,265 :: 		for( i=4; i<=11; i++ )
	MOVLW       4
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame70:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame358
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBLW       11
L__ProcessZigBeeFrame358:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame71
;ZigbeeRemoteIOV1.0.c,268 :: 		SenderMac[i-4]=ZigbeeFrame [ i ];
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
;ZigbeeRemoteIOV1.0.c,265 :: 		for( i=4; i<=11; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,269 :: 		}
	GOTO        L_ProcessZigBeeFrame70
L_ProcessZigBeeFrame71:
;ZigbeeRemoteIOV1.0.c,272 :: 		for( i=12; i<=13; i++ )
	MOVLW       12
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame73:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame359
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBLW       13
L__ProcessZigBeeFrame359:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame74
;ZigbeeRemoteIOV1.0.c,275 :: 		SenderAddress[i-12]=ZigbeeFrame[ i ];
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
;ZigbeeRemoteIOV1.0.c,272 :: 		for( i=12; i<=13; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,276 :: 		}
	GOTO        L_ProcessZigBeeFrame73
L_ProcessZigBeeFrame74:
;ZigbeeRemoteIOV1.0.c,278 :: 		SenderAddress[i-12]='\0';
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
;ZigbeeRemoteIOV1.0.c,279 :: 		for( i=15; i<=framesize+2; i++ )
	MOVLW       15
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame76:
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
	GOTO        L__ProcessZigBeeFrame360
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBWF       R1, 0 
L__ProcessZigBeeFrame360:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame77
;ZigbeeRemoteIOV1.0.c,282 :: 		ZigbeeDataPacket[i-15]=ZigbeeFrame[ i ];
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
;ZigbeeRemoteIOV1.0.c,279 :: 		for( i=15; i<=framesize+2; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,283 :: 		}
	GOTO        L_ProcessZigBeeFrame76
L_ProcessZigBeeFrame77:
;ZigbeeRemoteIOV1.0.c,285 :: 		ZigbeeDataPacket[i-15]='\0';
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
;ZigbeeRemoteIOV1.0.c,287 :: 		ProcessZigBeeDataPacket( ZigbeeDataPacket, SenderAddress );
	MOVLW       ProcessZigBeeFrame_ZigbeeDataPacket_L0+0
	MOVWF       FARG_ProcessZigBeeDataPacket_DataPacket+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_ZigbeeDataPacket_L0+0)
	MOVWF       FARG_ProcessZigBeeDataPacket_DataPacket+1 
	MOVLW       ProcessZigBeeFrame_SenderAddress_L0+0
	MOVWF       FARG_ProcessZigBeeDataPacket_DevIP+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_SenderAddress_L0+0)
	MOVWF       FARG_ProcessZigBeeDataPacket_DevIP+1 
	CALL        _ProcessZigBeeDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,288 :: 		}
	GOTO        L_ProcessZigBeeFrame79
L_ProcessZigBeeFrame69:
;ZigbeeRemoteIOV1.0.c,291 :: 		else if( FrameType==0x95 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame361
	MOVLW       149
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame361:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame80
;ZigbeeRemoteIOV1.0.c,294 :: 		DeviceAdress[0]=ZigbeeFrame [12];
	MOVF        _ZigbeeFrame+12, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+0 
;ZigbeeRemoteIOV1.0.c,295 :: 		DeviceAdress[1]=ZigbeeFrame [13];
	MOVF        _ZigbeeFrame+13, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+1 
;ZigbeeRemoteIOV1.0.c,297 :: 		for( i=4; i<12; i++ )
	MOVLW       4
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame81:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame362
	MOVLW       12
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame362:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame82
;ZigbeeRemoteIOV1.0.c,299 :: 		DeviceMAC[i-4]=ZigbeeFrame[i];
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
;ZigbeeRemoteIOV1.0.c,297 :: 		for( i=4; i<12; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,300 :: 		}
	GOTO        L_ProcessZigBeeFrame81
L_ProcessZigBeeFrame82:
;ZigbeeRemoteIOV1.0.c,303 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	CLRF        ProcessZigBeeFrame_i_L0+0 
	CLRF        ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame84:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame363
	MOVLW       16
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame363:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame85
;ZigbeeRemoteIOV1.0.c,305 :: 		DeviceID[i]=ZigbeeFrame[i+26];
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
;ZigbeeRemoteIOV1.0.c,306 :: 		if( DeviceID[i]==0x00 )break;
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame87
	GOTO        L_ProcessZigBeeFrame85
L_ProcessZigBeeFrame87:
;ZigbeeRemoteIOV1.0.c,303 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,307 :: 		}
	GOTO        L_ProcessZigBeeFrame84
L_ProcessZigBeeFrame85:
;ZigbeeRemoteIOV1.0.c,309 :: 		}
	GOTO        L_ProcessZigBeeFrame88
L_ProcessZigBeeFrame80:
;ZigbeeRemoteIOV1.0.c,312 :: 		else if( FrameType==0x88 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame364
	MOVLW       136
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame364:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame89
;ZigbeeRemoteIOV1.0.c,320 :: 		ATCommand[0]=ZigbeeFrame [ 5 ];
	MOVF        _ZigbeeFrame+5, 0 
	MOVWF       ProcessZigBeeFrame_ATCommand_L0+0 
;ZigbeeRemoteIOV1.0.c,321 :: 		ATCommand[1]=ZigbeeFrame [ 6 ];
	MOVF        _ZigbeeFrame+6, 0 
	MOVWF       ProcessZigBeeFrame_ATCommand_L0+1 
;ZigbeeRemoteIOV1.0.c,324 :: 		if( ZigbeeFrame [7]==0x00 )
	MOVF        _ZigbeeFrame+7, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame90
;ZigbeeRemoteIOV1.0.c,327 :: 		if( ATCommand[0]=='N'&&ATCommand[1]=='D' )
	MOVF        ProcessZigBeeFrame_ATCommand_L0+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame93
	MOVF        ProcessZigBeeFrame_ATCommand_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame93
L__ProcessZigBeeFrame314:
;ZigbeeRemoteIOV1.0.c,329 :: 		DeviceAdress[0]=ZigbeeFrame [8];
	MOVF        _ZigbeeFrame+8, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+0 
;ZigbeeRemoteIOV1.0.c,330 :: 		DeviceAdress[1]=ZigbeeFrame [9];
	MOVF        _ZigbeeFrame+9, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+1 
;ZigbeeRemoteIOV1.0.c,332 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame365
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame365:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame94
;ZigbeeRemoteIOV1.0.c,333 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,334 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame366
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame366:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame313
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame367
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame367:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame313
	GOTO        L_ProcessZigBeeFrame99
L__ProcessZigBeeFrame313:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame99
L__ProcessZigBeeFrame312:
;ZigbeeRemoteIOV1.0.c,335 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr18_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr18_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,336 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame100:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame101
	GOTO        L_ProcessZigBeeFrame100
L_ProcessZigBeeFrame101:
;ZigbeeRemoteIOV1.0.c,337 :: 		}
L_ProcessZigBeeFrame99:
;ZigbeeRemoteIOV1.0.c,338 :: 		}
L_ProcessZigBeeFrame94:
;ZigbeeRemoteIOV1.0.c,340 :: 		for( i=10; i<18; i++ )
	MOVLW       10
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame102:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame368
	MOVLW       18
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame368:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame103
;ZigbeeRemoteIOV1.0.c,342 :: 		DeviceMAC[i-10]=ZigbeeFrame[i];
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
;ZigbeeRemoteIOV1.0.c,340 :: 		for( i=10; i<18; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,343 :: 		}
	GOTO        L_ProcessZigBeeFrame102
L_ProcessZigBeeFrame103:
;ZigbeeRemoteIOV1.0.c,348 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	CLRF        ProcessZigBeeFrame_i_L0+0 
	CLRF        ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame105:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame369
	MOVLW       16
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame369:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame106
;ZigbeeRemoteIOV1.0.c,350 :: 		DeviceID[i]=ZigbeeFrame[i+19];
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
;ZigbeeRemoteIOV1.0.c,351 :: 		if( DeviceID[i]==0x00 )break;
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame108
	GOTO        L_ProcessZigBeeFrame106
L_ProcessZigBeeFrame108:
;ZigbeeRemoteIOV1.0.c,348 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,352 :: 		}
	GOTO        L_ProcessZigBeeFrame105
L_ProcessZigBeeFrame106:
;ZigbeeRemoteIOV1.0.c,356 :: 		}else if( ATCommand[0]=='M'&&ATCommand[1]=='Y' ){
	GOTO        L_ProcessZigBeeFrame109
L_ProcessZigBeeFrame93:
	MOVF        ProcessZigBeeFrame_ATCommand_L0+0, 0 
	XORLW       77
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame112
	MOVF        ProcessZigBeeFrame_ATCommand_L0+1, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame112
L__ProcessZigBeeFrame311:
;ZigbeeRemoteIOV1.0.c,357 :: 		LocalIP[0]=ZigbeeFrame [8];
	MOVF        _ZigbeeFrame+8, 0 
	MOVWF       _LocalIP+0 
;ZigbeeRemoteIOV1.0.c,358 :: 		LocalIP[1]=ZigbeeFrame [9];
	MOVF        _ZigbeeFrame+9, 0 
	MOVWF       _LocalIP+1 
;ZigbeeRemoteIOV1.0.c,360 :: 		if( LocalIP[0]!=0xFF&&LocalIP[1]!=0xFE )
	MOVF        _LocalIP+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame115
	MOVF        _LocalIP+1, 0 
	XORLW       254
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame115
L__ProcessZigBeeFrame310:
;ZigbeeRemoteIOV1.0.c,363 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,364 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame370
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame370:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame309
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame371
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame371:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame309
	GOTO        L_ProcessZigBeeFrame120
L__ProcessZigBeeFrame309:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame120
L__ProcessZigBeeFrame308:
;ZigbeeRemoteIOV1.0.c,365 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr19_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr19_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,366 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame121:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame122
	GOTO        L_ProcessZigBeeFrame121
L_ProcessZigBeeFrame122:
;ZigbeeRemoteIOV1.0.c,367 :: 		}
L_ProcessZigBeeFrame120:
;ZigbeeRemoteIOV1.0.c,369 :: 		}
	GOTO        L_ProcessZigBeeFrame123
L_ProcessZigBeeFrame115:
;ZigbeeRemoteIOV1.0.c,373 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,375 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame372
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame372:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame307
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame373
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame373:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame307
	GOTO        L_ProcessZigBeeFrame128
L__ProcessZigBeeFrame307:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame128
L__ProcessZigBeeFrame306:
;ZigbeeRemoteIOV1.0.c,376 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_20_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_20_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_20_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,377 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame129:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame130
	GOTO        L_ProcessZigBeeFrame129
L_ProcessZigBeeFrame130:
;ZigbeeRemoteIOV1.0.c,378 :: 		}
L_ProcessZigBeeFrame128:
;ZigbeeRemoteIOV1.0.c,380 :: 		}
L_ProcessZigBeeFrame123:
;ZigbeeRemoteIOV1.0.c,381 :: 		}
L_ProcessZigBeeFrame112:
L_ProcessZigBeeFrame109:
;ZigbeeRemoteIOV1.0.c,382 :: 		}
L_ProcessZigBeeFrame90:
;ZigbeeRemoteIOV1.0.c,383 :: 		}
	GOTO        L_ProcessZigBeeFrame131
L_ProcessZigBeeFrame89:
;ZigbeeRemoteIOV1.0.c,385 :: 		else if( FrameType==0x8A )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame374
	MOVLW       138
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame374:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame132
;ZigbeeRemoteIOV1.0.c,389 :: 		if( ZigbeeFrame[4]==0x03 )
	MOVF        _ZigbeeFrame+4, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame133
;ZigbeeRemoteIOV1.0.c,392 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame375
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame375:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame305
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame376
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame376:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame305
	GOTO        L_ProcessZigBeeFrame138
L__ProcessZigBeeFrame305:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame138
L__ProcessZigBeeFrame304:
;ZigbeeRemoteIOV1.0.c,393 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK\n");
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
;ZigbeeRemoteIOV1.0.c,394 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame139:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame140
	GOTO        L_ProcessZigBeeFrame139
L_ProcessZigBeeFrame140:
;ZigbeeRemoteIOV1.0.c,395 :: 		}
L_ProcessZigBeeFrame138:
;ZigbeeRemoteIOV1.0.c,396 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,397 :: 		}
	GOTO        L_ProcessZigBeeFrame141
L_ProcessZigBeeFrame133:
;ZigbeeRemoteIOV1.0.c,400 :: 		else if( ZigbeeFrame[4]==0x02 )
	MOVF        _ZigbeeFrame+4, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame142
;ZigbeeRemoteIOV1.0.c,404 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame377
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame377:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame143
;ZigbeeRemoteIOV1.0.c,405 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,407 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame378
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame378:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame303
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame379
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame379:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame303
	GOTO        L_ProcessZigBeeFrame148
L__ProcessZigBeeFrame303:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame148
L__ProcessZigBeeFrame302:
;ZigbeeRemoteIOV1.0.c,408 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr22_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr22_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,409 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame149:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame150
	GOTO        L_ProcessZigBeeFrame149
L_ProcessZigBeeFrame150:
;ZigbeeRemoteIOV1.0.c,410 :: 		}
L_ProcessZigBeeFrame148:
;ZigbeeRemoteIOV1.0.c,411 :: 		}
L_ProcessZigBeeFrame143:
;ZigbeeRemoteIOV1.0.c,414 :: 		}
L_ProcessZigBeeFrame142:
L_ProcessZigBeeFrame141:
;ZigbeeRemoteIOV1.0.c,417 :: 		}
	GOTO        L_ProcessZigBeeFrame151
L_ProcessZigBeeFrame132:
;ZigbeeRemoteIOV1.0.c,421 :: 		else if( FrameType==0x8B )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame380
	MOVLW       139
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame380:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame152
;ZigbeeRemoteIOV1.0.c,424 :: 		if( ZigbeeFrame[8]==0x00 )
	MOVF        _ZigbeeFrame+8, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame153
;ZigbeeRemoteIOV1.0.c,426 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame381
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame381:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame154
;ZigbeeRemoteIOV1.0.c,427 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,429 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame382
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame382:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame301
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame383
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame383:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame301
	GOTO        L_ProcessZigBeeFrame159
L__ProcessZigBeeFrame301:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame159
L__ProcessZigBeeFrame300:
;ZigbeeRemoteIOV1.0.c,430 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr23_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr23_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,431 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame160:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame161
	GOTO        L_ProcessZigBeeFrame160
L_ProcessZigBeeFrame161:
;ZigbeeRemoteIOV1.0.c,432 :: 		}
L_ProcessZigBeeFrame159:
;ZigbeeRemoteIOV1.0.c,433 :: 		}
L_ProcessZigBeeFrame154:
;ZigbeeRemoteIOV1.0.c,434 :: 		}
	GOTO        L_ProcessZigBeeFrame162
L_ProcessZigBeeFrame153:
;ZigbeeRemoteIOV1.0.c,437 :: 		else if( ZigbeeFrame[8]==0x21 )
	MOVF        _ZigbeeFrame+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame163
;ZigbeeRemoteIOV1.0.c,440 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,442 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame384
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame384:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame299
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame385
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame385:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame299
	GOTO        L_ProcessZigBeeFrame168
L__ProcessZigBeeFrame299:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame168
L__ProcessZigBeeFrame298:
;ZigbeeRemoteIOV1.0.c,443 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK|ACK FAILED\n");
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
;ZigbeeRemoteIOV1.0.c,444 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame169:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame170
	GOTO        L_ProcessZigBeeFrame169
L_ProcessZigBeeFrame170:
;ZigbeeRemoteIOV1.0.c,445 :: 		}
L_ProcessZigBeeFrame168:
;ZigbeeRemoteIOV1.0.c,447 :: 		}
L_ProcessZigBeeFrame163:
L_ProcessZigBeeFrame162:
;ZigbeeRemoteIOV1.0.c,448 :: 		}
L_ProcessZigBeeFrame152:
L_ProcessZigBeeFrame151:
L_ProcessZigBeeFrame131:
L_ProcessZigBeeFrame88:
L_ProcessZigBeeFrame79:
;ZigbeeRemoteIOV1.0.c,464 :: 		}
L_end_ProcessZigBeeFrame:
	RETURN      0
; end of _ProcessZigBeeFrame

_interrupt:

;ZigbeeRemoteIOV1.0.c,468 :: 		void interrupt()
;ZigbeeRemoteIOV1.0.c,473 :: 		if(USBIF_Bit && USBON){
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt173
	BTFSS       PORTB+0, 4 
	GOTO        L_interrupt173
L__interrupt315:
;ZigbeeRemoteIOV1.0.c,474 :: 		USB_Interrupt_Proc();                   // USB servicing is done inside the interrupt
	CALL        _USB_Interrupt_Proc+0, 0
;ZigbeeRemoteIOV1.0.c,475 :: 		}
L_interrupt173:
;ZigbeeRemoteIOV1.0.c,477 :: 		if (PIR1.RCIF) {          // test the interrupt for uart rx
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt174
;ZigbeeRemoteIOV1.0.c,478 :: 		if (UART1_Data_Ready() == 1) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt175
;ZigbeeRemoteIOV1.0.c,479 :: 		Rx_char = UART1_Read();  //
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Rx_char+0 
;ZigbeeRemoteIOV1.0.c,480 :: 		if(Rx_char==0x7E){
	MOVF        R0, 0 
	XORLW       126
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt176
;ZigbeeRemoteIOV1.0.c,481 :: 		frameindex=0;
	CLRF        _frameindex+0 
	CLRF        _frameindex+1 
;ZigbeeRemoteIOV1.0.c,482 :: 		frame_started=1;
	MOVLW       1
	MOVWF       _frame_started+0 
;ZigbeeRemoteIOV1.0.c,484 :: 		}
L_interrupt176:
;ZigbeeRemoteIOV1.0.c,486 :: 		if(frame_started==1){
	MOVF        _frame_started+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt177
;ZigbeeRemoteIOV1.0.c,487 :: 		ZigbeeFrame[frameindex]=Rx_char;
	MOVLW       _ZigbeeFrame+0
	ADDWF       _frameindex+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      _frameindex+1, 0 
	MOVWF       FSR1H 
	MOVF        _Rx_char+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,489 :: 		if( frameindex==2 )
	MOVLW       0
	XORWF       _frameindex+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt388
	MOVLW       2
	XORWF       _frameindex+0, 0 
L__interrupt388:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt178
;ZigbeeRemoteIOV1.0.c,491 :: 		framesize=ZigbeeFrame[1]+ZigbeeFrame[2];
	MOVF        _ZigbeeFrame+2, 0 
	ADDWF       _ZigbeeFrame+1, 0 
	MOVWF       _framesize+0 
	CLRF        _framesize+1 
	MOVLW       0
	ADDWFC      _framesize+1, 1 
;ZigbeeRemoteIOV1.0.c,492 :: 		}
L_interrupt178:
;ZigbeeRemoteIOV1.0.c,494 :: 		frameindex++;
	INFSNZ      _frameindex+0, 1 
	INCF        _frameindex+1, 1 
;ZigbeeRemoteIOV1.0.c,495 :: 		if( frameindex>=framesize+4 )
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
	GOTO        L__interrupt389
	MOVF        R1, 0 
	SUBWF       _frameindex+0, 0 
L__interrupt389:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt179
;ZigbeeRemoteIOV1.0.c,498 :: 		frameindex=0;
	CLRF        _frameindex+0 
	CLRF        _frameindex+1 
;ZigbeeRemoteIOV1.0.c,499 :: 		frame_started=0;
	CLRF        _frame_started+0 
;ZigbeeRemoteIOV1.0.c,500 :: 		GotFrame=1;
	MOVLW       1
	MOVWF       _GotFrame+0 
;ZigbeeRemoteIOV1.0.c,502 :: 		}
L_interrupt179:
;ZigbeeRemoteIOV1.0.c,503 :: 		}
L_interrupt177:
;ZigbeeRemoteIOV1.0.c,504 :: 		}
L_interrupt175:
;ZigbeeRemoteIOV1.0.c,505 :: 		}
L_interrupt174:
;ZigbeeRemoteIOV1.0.c,507 :: 		}
L_end_interrupt:
L__interrupt387:
	RETFIE      1
; end of _interrupt

_ProcessInputs:

;ZigbeeRemoteIOV1.0.c,513 :: 		void ProcessInputs(){
;ZigbeeRemoteIOV1.0.c,515 :: 		if(JoinedLastState!=JoinedToNet){
	MOVF        _JoinedLastState+1, 0 
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs391
	MOVF        _JoinedToNet+0, 0 
	XORWF       _JoinedLastState+0, 0 
L__ProcessInputs391:
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs180
;ZigbeeRemoteIOV1.0.c,516 :: 		JoinedLastState=JoinedToNet;
	MOVF        _JoinedToNet+0, 0 
	MOVWF       _JoinedLastState+0 
	MOVF        _JoinedToNet+1, 0 
	MOVWF       _JoinedLastState+1 
;ZigbeeRemoteIOV1.0.c,517 :: 		PICIN1LastState=!PICIN1;
	BTFSC       PORTB+0, 0 
	GOTO        L__ProcessInputs392
	BSF         4056, 0 
	GOTO        L__ProcessInputs393
L__ProcessInputs392:
	BCF         4056, 0 
L__ProcessInputs393:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN1LastState+0 
;ZigbeeRemoteIOV1.0.c,518 :: 		PICIN2LastState=!PICIN2;
	BTFSC       PORTB+0, 1 
	GOTO        L__ProcessInputs394
	BSF         4056, 0 
	GOTO        L__ProcessInputs395
L__ProcessInputs394:
	BCF         4056, 0 
L__ProcessInputs395:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN2LastState+0 
;ZigbeeRemoteIOV1.0.c,519 :: 		PICIN3LastState=!PICIN3;
	BTFSC       PORTB+0, 2 
	GOTO        L__ProcessInputs396
	BSF         4056, 0 
	GOTO        L__ProcessInputs397
L__ProcessInputs396:
	BCF         4056, 0 
L__ProcessInputs397:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN3LastState+0 
;ZigbeeRemoteIOV1.0.c,520 :: 		PICIN4LastState=!PICIN4;
	BTFSC       PORTB+0, 3 
	GOTO        L__ProcessInputs398
	BSF         4056, 0 
	GOTO        L__ProcessInputs399
L__ProcessInputs398:
	BCF         4056, 0 
L__ProcessInputs399:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN4LastState+0 
;ZigbeeRemoteIOV1.0.c,523 :: 		}
L_ProcessInputs180:
;ZigbeeRemoteIOV1.0.c,525 :: 		if(PICIN1LastState!=PICIN1){
	CLRF        R1 
	BTFSC       PORTB+0, 0 
	INCF        R1, 1 
	MOVF        _PICIN1LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs181
;ZigbeeRemoteIOV1.0.c,526 :: 		if(debounc_in1>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs400
	MOVF        _debounc_in1+0, 0 
	SUBLW       5
L__ProcessInputs400:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs182
;ZigbeeRemoteIOV1.0.c,527 :: 		debounc_in1=0;
	CLRF        _debounc_in1+0 
	CLRF        _debounc_in1+1 
;ZigbeeRemoteIOV1.0.c,528 :: 		PICIN1LastState= PICIN1;
	MOVLW       0
	BTFSC       PORTB+0, 0 
	MOVLW       1
	MOVWF       _PICIN1LastState+0 
;ZigbeeRemoteIOV1.0.c,529 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs401
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs401:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs323
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs402
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs402:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs323
	GOTO        L_ProcessInputs187
L__ProcessInputs323:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs187
L__ProcessInputs322:
;ZigbeeRemoteIOV1.0.c,530 :: 		sprinti(writebuff,"IN 1|%u \n",PICIN1LastState);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_25_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_25_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_25_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        _PICIN1LastState+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,531 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs188:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs189
	GOTO        L_ProcessInputs188
L_ProcessInputs189:
;ZigbeeRemoteIOV1.0.c,532 :: 		}
L_ProcessInputs187:
;ZigbeeRemoteIOV1.0.c,533 :: 		if(PICIN1LastState)
	MOVF        _PICIN1LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs190
;ZigbeeRemoteIOV1.0.c,534 :: 		SendDataPacket(0,"OUT|1|OFF",9,0);
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVLW       ?lstr26_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr26_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       9
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
	GOTO        L_ProcessInputs191
L_ProcessInputs190:
;ZigbeeRemoteIOV1.0.c,536 :: 		SendDataPacket(0,"OUT|1|ON",8,0);
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVLW       ?lstr27_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr27_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       8
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
L_ProcessInputs191:
;ZigbeeRemoteIOV1.0.c,537 :: 		}
	GOTO        L_ProcessInputs192
L_ProcessInputs182:
;ZigbeeRemoteIOV1.0.c,539 :: 		debounc_in1++;
	INFSNZ      _debounc_in1+0, 1 
	INCF        _debounc_in1+1, 1 
L_ProcessInputs192:
;ZigbeeRemoteIOV1.0.c,541 :: 		}
L_ProcessInputs181:
;ZigbeeRemoteIOV1.0.c,542 :: 		if(PICIN2LastState!=PICIN2){
	CLRF        R1 
	BTFSC       PORTB+0, 1 
	INCF        R1, 1 
	MOVF        _PICIN2LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs193
;ZigbeeRemoteIOV1.0.c,544 :: 		if(debounc_in2>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs403
	MOVF        _debounc_in2+0, 0 
	SUBLW       5
L__ProcessInputs403:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs194
;ZigbeeRemoteIOV1.0.c,545 :: 		debounc_in2=0;
	CLRF        _debounc_in2+0 
	CLRF        _debounc_in2+1 
;ZigbeeRemoteIOV1.0.c,546 :: 		PICIN2LastState= PICIN2;
	MOVLW       0
	BTFSC       PORTB+0, 1 
	MOVLW       1
	MOVWF       _PICIN2LastState+0 
;ZigbeeRemoteIOV1.0.c,547 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs404
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs404:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs321
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs405
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs405:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs321
	GOTO        L_ProcessInputs199
L__ProcessInputs321:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs199
L__ProcessInputs320:
;ZigbeeRemoteIOV1.0.c,548 :: 		sprinti(writebuff,"IN 2|%u\n",PICIN2LastState);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_28_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_28_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_28_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        _PICIN2LastState+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,549 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs200:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs201
	GOTO        L_ProcessInputs200
L_ProcessInputs201:
;ZigbeeRemoteIOV1.0.c,550 :: 		}
L_ProcessInputs199:
;ZigbeeRemoteIOV1.0.c,551 :: 		if(PICIN2LastState){
	MOVF        _PICIN2LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs202
;ZigbeeRemoteIOV1.0.c,552 :: 		SendDataPacket(0,"OUT|2|OFF",9,0);
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVLW       ?lstr29_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr29_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       9
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,553 :: 		}
	GOTO        L_ProcessInputs203
L_ProcessInputs202:
;ZigbeeRemoteIOV1.0.c,555 :: 		SendDataPacket(0,"OUT|2|ON",8,0);
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVLW       ?lstr30_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr30_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       8
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,556 :: 		}
L_ProcessInputs203:
;ZigbeeRemoteIOV1.0.c,557 :: 		}
	GOTO        L_ProcessInputs204
L_ProcessInputs194:
;ZigbeeRemoteIOV1.0.c,559 :: 		debounc_in2++;
	INFSNZ      _debounc_in2+0, 1 
	INCF        _debounc_in2+1, 1 
L_ProcessInputs204:
;ZigbeeRemoteIOV1.0.c,560 :: 		}
L_ProcessInputs193:
;ZigbeeRemoteIOV1.0.c,561 :: 		if(PICIN3LastState!=PICIN3){
	CLRF        R1 
	BTFSC       PORTB+0, 2 
	INCF        R1, 1 
	MOVF        _PICIN3LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs205
;ZigbeeRemoteIOV1.0.c,562 :: 		if(debounc_in3>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in3+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs406
	MOVF        _debounc_in3+0, 0 
	SUBLW       5
L__ProcessInputs406:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs206
;ZigbeeRemoteIOV1.0.c,563 :: 		debounc_in3=0;
	CLRF        _debounc_in3+0 
	CLRF        _debounc_in3+1 
;ZigbeeRemoteIOV1.0.c,564 :: 		PICIN3LastState= PICIN3;
	MOVLW       0
	BTFSC       PORTB+0, 2 
	MOVLW       1
	MOVWF       _PICIN3LastState+0 
;ZigbeeRemoteIOV1.0.c,565 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs407
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs407:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs319
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs408
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs408:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs319
	GOTO        L_ProcessInputs211
L__ProcessInputs319:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs211
L__ProcessInputs318:
;ZigbeeRemoteIOV1.0.c,566 :: 		sprinti(writebuff,"IN 3|%u\n",PICIN3LastState);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_31_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_31_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_31_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        _PICIN3LastState+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,567 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs212:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs213
	GOTO        L_ProcessInputs212
L_ProcessInputs213:
;ZigbeeRemoteIOV1.0.c,568 :: 		}
L_ProcessInputs211:
;ZigbeeRemoteIOV1.0.c,569 :: 		if(PICIN3LastState)
	MOVF        _PICIN3LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs214
;ZigbeeRemoteIOV1.0.c,570 :: 		SendDataPacket(0,"OUT|3|OFF",9,0);
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVLW       ?lstr32_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr32_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       9
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
	GOTO        L_ProcessInputs215
L_ProcessInputs214:
;ZigbeeRemoteIOV1.0.c,572 :: 		SendDataPacket(0,"OUT|3|ON",8,0);
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVLW       ?lstr33_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr33_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       8
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
L_ProcessInputs215:
;ZigbeeRemoteIOV1.0.c,573 :: 		}
	GOTO        L_ProcessInputs216
L_ProcessInputs206:
;ZigbeeRemoteIOV1.0.c,575 :: 		debounc_in3++;
	INFSNZ      _debounc_in3+0, 1 
	INCF        _debounc_in3+1, 1 
L_ProcessInputs216:
;ZigbeeRemoteIOV1.0.c,576 :: 		}
L_ProcessInputs205:
;ZigbeeRemoteIOV1.0.c,577 :: 		if(PICIN4LastState!=PICIN4){
	CLRF        R1 
	BTFSC       PORTB+0, 3 
	INCF        R1, 1 
	MOVF        _PICIN4LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs217
;ZigbeeRemoteIOV1.0.c,578 :: 		if(debounc_in4>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in4+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs409
	MOVF        _debounc_in4+0, 0 
	SUBLW       5
L__ProcessInputs409:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs218
;ZigbeeRemoteIOV1.0.c,579 :: 		debounc_in4=0;
	CLRF        _debounc_in4+0 
	CLRF        _debounc_in4+1 
;ZigbeeRemoteIOV1.0.c,580 :: 		PICIN4LastState= PICIN4;
	MOVLW       0
	BTFSC       PORTB+0, 3 
	MOVLW       1
	MOVWF       _PICIN4LastState+0 
;ZigbeeRemoteIOV1.0.c,581 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs410
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs410:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs317
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs411
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs411:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs317
	GOTO        L_ProcessInputs223
L__ProcessInputs317:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs223
L__ProcessInputs316:
;ZigbeeRemoteIOV1.0.c,582 :: 		sprinti(writebuff,"IN 4|%u\n",PICIN4LastState);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_34_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_34_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_34_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        _PICIN4LastState+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,583 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs224:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs225
	GOTO        L_ProcessInputs224
L_ProcessInputs225:
;ZigbeeRemoteIOV1.0.c,584 :: 		}
L_ProcessInputs223:
;ZigbeeRemoteIOV1.0.c,585 :: 		if(PICIN4LastState)
	MOVF        _PICIN4LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs226
;ZigbeeRemoteIOV1.0.c,586 :: 		SendDataPacket(0,"OUT|4|OFF",9,0);
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVLW       ?lstr35_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr35_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       9
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
	GOTO        L_ProcessInputs227
L_ProcessInputs226:
;ZigbeeRemoteIOV1.0.c,588 :: 		SendDataPacket(0,"OUT|4|ON",8,0);
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVLW       ?lstr36_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVLW       hi_addr(?lstr36_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	MOVLW       8
	MOVWF       FARG_SendDataPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
L_ProcessInputs227:
;ZigbeeRemoteIOV1.0.c,589 :: 		}
	GOTO        L_ProcessInputs228
L_ProcessInputs218:
;ZigbeeRemoteIOV1.0.c,591 :: 		debounc_in4++;
	INFSNZ      _debounc_in4+0, 1 
	INCF        _debounc_in4+1, 1 
L_ProcessInputs228:
;ZigbeeRemoteIOV1.0.c,592 :: 		}
L_ProcessInputs217:
;ZigbeeRemoteIOV1.0.c,595 :: 		}
L_end_ProcessInputs:
	RETURN      0
; end of _ProcessInputs

_write_eeprom_from:

;ZigbeeRemoteIOV1.0.c,599 :: 		void write_eeprom_from(short startaddress,char *str){
;ZigbeeRemoteIOV1.0.c,602 :: 		int i=0,j=0;
	CLRF        write_eeprom_from_i_L0+0 
	CLRF        write_eeprom_from_i_L0+1 
	CLRF        write_eeprom_from_j_L0+0 
	CLRF        write_eeprom_from_j_L0+1 
;ZigbeeRemoteIOV1.0.c,603 :: 		for(i=0;i<strlen(str)*2;i=i+2){
	CLRF        write_eeprom_from_i_L0+0 
	CLRF        write_eeprom_from_i_L0+1 
L_write_eeprom_from229:
	MOVF        FARG_write_eeprom_from_str+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        FARG_write_eeprom_from_str+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVLW       128
	XORWF       write_eeprom_from_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_eeprom_from413
	MOVF        R2, 0 
	SUBWF       write_eeprom_from_i_L0+0, 0 
L__write_eeprom_from413:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_eeprom_from230
;ZigbeeRemoteIOV1.0.c,604 :: 		hexstr[0]=str[i];
	MOVF        write_eeprom_from_i_L0+0, 0 
	ADDWF       FARG_write_eeprom_from_str+0, 0 
	MOVWF       FSR0 
	MOVF        write_eeprom_from_i_L0+1, 0 
	ADDWFC      FARG_write_eeprom_from_str+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       write_eeprom_from_hexstr_L0+0 
;ZigbeeRemoteIOV1.0.c,605 :: 		hexstr[1]=str[i+1];
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
;ZigbeeRemoteIOV1.0.c,606 :: 		hexval=xtoi(hexstr);
	MOVLW       write_eeprom_from_hexstr_L0+0
	MOVWF       FARG_xtoi_s+0 
	MOVLW       hi_addr(write_eeprom_from_hexstr_L0+0)
	MOVWF       FARG_xtoi_s+1 
	CALL        _xtoi+0, 0
;ZigbeeRemoteIOV1.0.c,607 :: 		EEPROM_Write(startaddress+j,hexval);
	MOVF        write_eeprom_from_j_L0+0, 0 
	ADDWF       FARG_write_eeprom_from_startaddress+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ZigbeeRemoteIOV1.0.c,608 :: 		j++;
	INFSNZ      write_eeprom_from_j_L0+0, 1 
	INCF        write_eeprom_from_j_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,603 :: 		for(i=0;i<strlen(str)*2;i=i+2){
	MOVLW       2
	ADDWF       write_eeprom_from_i_L0+0, 1 
	MOVLW       0
	ADDWFC      write_eeprom_from_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,609 :: 		}
	GOTO        L_write_eeprom_from229
L_write_eeprom_from230:
;ZigbeeRemoteIOV1.0.c,610 :: 		}
L_end_write_eeprom_from:
	RETURN      0
; end of _write_eeprom_from

_read_eeprom_to:

;ZigbeeRemoteIOV1.0.c,612 :: 		void read_eeprom_to(short startadress,char *dest){
;ZigbeeRemoteIOV1.0.c,615 :: 		for(i=0;i<8;i++){
	CLRF        read_eeprom_to_i_L0+0 
	CLRF        read_eeprom_to_i_L0+1 
L_read_eeprom_to232:
	MOVLW       128
	XORWF       read_eeprom_to_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_eeprom_to415
	MOVLW       8
	SUBWF       read_eeprom_to_i_L0+0, 0 
L__read_eeprom_to415:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_eeprom_to233
;ZigbeeRemoteIOV1.0.c,616 :: 		dest[i]=EEPROM_Read(startadress+i);
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
;ZigbeeRemoteIOV1.0.c,615 :: 		for(i=0;i<8;i++){
	INFSNZ      read_eeprom_to_i_L0+0, 1 
	INCF        read_eeprom_to_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,621 :: 		}
	GOTO        L_read_eeprom_to232
L_read_eeprom_to233:
;ZigbeeRemoteIOV1.0.c,623 :: 		}
L_end_read_eeprom_to:
	RETURN      0
; end of _read_eeprom_to

_main:

;ZigbeeRemoteIOV1.0.c,624 :: 		void main() {
;ZigbeeRemoteIOV1.0.c,626 :: 		int i, MY_retry=0;
;ZigbeeRemoteIOV1.0.c,630 :: 		char del[2] = "|";
	MOVLW       124
	MOVWF       main_del_L0+0 
	CLRF        main_del_L0+1 
	MOVLW       1
	MOVWF       main_readaddress_L0+0 
;ZigbeeRemoteIOV1.0.c,634 :: 		delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main235:
	DECFSZ      R13, 1, 1
	BRA         L_main235
	DECFSZ      R12, 1, 1
	BRA         L_main235
	DECFSZ      R11, 1, 1
	BRA         L_main235
	NOP
	NOP
;ZigbeeRemoteIOV1.0.c,636 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       225
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;ZigbeeRemoteIOV1.0.c,638 :: 		MM_Init();
	CALL        _MM_Init+0, 0
;ZigbeeRemoteIOV1.0.c,640 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main236:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main417
	MOVLW       2
	SUBWF       main_i_L0+0, 0 
L__main417:
	BTFSC       STATUS+0, 0 
	GOTO        L_main237
;ZigbeeRemoteIOV1.0.c,642 :: 		ZigbeeSendDevices[i].enabled=EEPROM_Read(readaddress++);
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVF        main_readaddress_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INCF        main_readaddress_L0+0, 1 
;ZigbeeRemoteIOV1.0.c,643 :: 		ZigbeeSendDevices[i].Address=(unsigned short*)malloc(sizeof(char) *8);
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       1
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
;ZigbeeRemoteIOV1.0.c,645 :: 		read_eeprom_to(readaddress,ZigbeeSendDevices[i].Address);
	MOVF        main_readaddress_L0+0, 0 
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       1
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
;ZigbeeRemoteIOV1.0.c,647 :: 		readaddress+=8;
	MOVLW       8
	ADDWF       main_readaddress_L0+0, 1 
;ZigbeeRemoteIOV1.0.c,640 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,648 :: 		}
	GOTO        L_main236
L_main237:
;ZigbeeRemoteIOV1.0.c,655 :: 		PICOUT1_Direction=0;
	BCF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,656 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,657 :: 		PICOUT2_Direction=0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,658 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,659 :: 		PICOUT3_Direction=0;
	BCF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,660 :: 		PICOUT3=0;
	BCF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,661 :: 		PICOUT4_Direction=0;
	BCF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,662 :: 		PICOUT4=0;
	BCF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,667 :: 		PICIN1_Direction=1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;ZigbeeRemoteIOV1.0.c,668 :: 		PICIN2_Direction=1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;ZigbeeRemoteIOV1.0.c,669 :: 		PICIN3_Direction=1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;ZigbeeRemoteIOV1.0.c,670 :: 		PICIN4_Direction=1;
	BSF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;ZigbeeRemoteIOV1.0.c,671 :: 		USBON_Direction=1;
	BSF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;ZigbeeRemoteIOV1.0.c,672 :: 		PROG_Direction=1;
	BSF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;ZigbeeRemoteIOV1.0.c,674 :: 		ADCON0 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON0+0, 1 
;ZigbeeRemoteIOV1.0.c,675 :: 		ADCON1 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;ZigbeeRemoteIOV1.0.c,676 :: 		ADCON2 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON2+0, 1 
;ZigbeeRemoteIOV1.0.c,677 :: 		CMCON  |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;ZigbeeRemoteIOV1.0.c,681 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;ZigbeeRemoteIOV1.0.c,682 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;ZigbeeRemoteIOV1.0.c,683 :: 		PIE1.RCIE = 1; //enable interrupt.
	BSF         PIE1+0, 5 
;ZigbeeRemoteIOV1.0.c,686 :: 		if(USBON)
	BTFSS       PORTB+0, 4 
	GOTO        L_main239
;ZigbeeRemoteIOV1.0.c,687 :: 		HID_Enable(readbuff,writebuff);      // Enable HID communication
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
L_main239:
;ZigbeeRemoteIOV1.0.c,691 :: 		debug=0;
	CLRF        _debug+0 
	CLRF        _debug+1 
;ZigbeeRemoteIOV1.0.c,694 :: 		SendRawPacket(MY1, 8);
	MOVLW       _MY1+0
	MOVWF       FARG_SendRawPacket_RawPacket+0 
	MOVLW       hi_addr(_MY1+0)
	MOVWF       FARG_SendRawPacket_RawPacket+1 
	MOVLW       8
	MOVWF       FARG_SendRawPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendRawPacket_len+1 
	CALL        _SendRawPacket+0, 0
;ZigbeeRemoteIOV1.0.c,695 :: 		while(1)
L_main240:
;ZigbeeRemoteIOV1.0.c,699 :: 		if(GotFrame==1){
	MOVF        _GotFrame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main242
;ZigbeeRemoteIOV1.0.c,700 :: 		GotFrame=0;
	CLRF        _GotFrame+0 
;ZigbeeRemoteIOV1.0.c,701 :: 		ProcessZigBeeFrame();
	CALL        _ProcessZigBeeFrame+0, 0
;ZigbeeRemoteIOV1.0.c,703 :: 		}
L_main242:
;ZigbeeRemoteIOV1.0.c,706 :: 		ProcessInputs();
	CALL        _ProcessInputs+0, 0
;ZigbeeRemoteIOV1.0.c,713 :: 		if(JoinedToNet==0){
	MOVLW       0
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main418
	MOVLW       0
	XORWF       _JoinedToNet+0, 0 
L__main418:
	BTFSS       STATUS+0, 2 
	GOTO        L_main243
;ZigbeeRemoteIOV1.0.c,714 :: 		PICOUT1=1;
	BSF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,715 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,716 :: 		}
L_main243:
;ZigbeeRemoteIOV1.0.c,718 :: 		if(JoinedToNet==2){
	MOVLW       0
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main419
	MOVLW       2
	XORWF       _JoinedToNet+0, 0 
L__main419:
	BTFSS       STATUS+0, 2 
	GOTO        L_main244
;ZigbeeRemoteIOV1.0.c,719 :: 		PICOUT2=1;
	BSF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,720 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,721 :: 		}
L_main244:
;ZigbeeRemoteIOV1.0.c,722 :: 		if(USBON){
	BTFSS       PORTB+0, 4 
	GOTO        L_main245
;ZigbeeRemoteIOV1.0.c,723 :: 		if(!(hid_read()==0)) {
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main246
;ZigbeeRemoteIOV1.0.c,724 :: 		i=0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;ZigbeeRemoteIOV1.0.c,729 :: 		CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(readbuff,'\r'),'\n'), del);
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
;ZigbeeRemoteIOV1.0.c,732 :: 		do
L_main247:
;ZigbeeRemoteIOV1.0.c,735 :: 		i++;
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,736 :: 		CommandTrimmed[i] = strtok(0, del);
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
;ZigbeeRemoteIOV1.0.c,739 :: 		while( CommandTrimmed[i] != 0 );
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
	GOTO        L__main420
	MOVLW       0
	XORWF       R1, 0 
L__main420:
	BTFSS       STATUS+0, 2 
	GOTO        L_main247
;ZigbeeRemoteIOV1.0.c,743 :: 		if(strcmp(CommandTrimmed[0],"UPGRADE")==0){
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
	GOTO        L__main421
	MOVLW       0
	XORWF       R0, 0 
L__main421:
	BTFSS       STATUS+0, 2 
	GOTO        L_main250
;ZigbeeRemoteIOV1.0.c,744 :: 		sprinti(writebuff,"UPGRADING\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_38_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_38_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_38_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,745 :: 		while(!hid_write(writebuff,64));
L_main251:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main252
	GOTO        L_main251
L_main252:
;ZigbeeRemoteIOV1.0.c,746 :: 		EEPROM_Write(0x00,0x01);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ZigbeeRemoteIOV1.0.c,747 :: 		HID_Disable();
	CALL        _HID_Disable+0, 0
;ZigbeeRemoteIOV1.0.c,748 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main253:
	DECFSZ      R13, 1, 1
	BRA         L_main253
	DECFSZ      R12, 1, 1
	BRA         L_main253
	DECFSZ      R11, 1, 1
	BRA         L_main253
	NOP
	NOP
;ZigbeeRemoteIOV1.0.c,749 :: 		asm { reset; }
	RESET
;ZigbeeRemoteIOV1.0.c,750 :: 		} else if(strcmp(CommandTrimmed[0],"SET")==0){
	GOTO        L_main254
L_main250:
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr39_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr39_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main422
	MOVLW       0
	XORWF       R0, 0 
L__main422:
	BTFSS       STATUS+0, 2 
	GOTO        L_main255
;ZigbeeRemoteIOV1.0.c,751 :: 		if(strcmp(CommandTrimmed[1],"DEBUG")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr40_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr40_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main423
	MOVLW       0
	XORWF       R0, 0 
L__main423:
	BTFSS       STATUS+0, 2 
	GOTO        L_main256
;ZigbeeRemoteIOV1.0.c,752 :: 		int debug_val=0;
;ZigbeeRemoteIOV1.0.c,753 :: 		debug_val=atoi(CommandTrimmed[2]);
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
;ZigbeeRemoteIOV1.0.c,754 :: 		debug=debug_val;
	MOVF        R0, 0 
	MOVWF       _debug+0 
	MOVF        R1, 0 
	MOVWF       _debug+1 
;ZigbeeRemoteIOV1.0.c,755 :: 		sprinti(writebuff,"DEBUG|%d\n",debug_val);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_41_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_41_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_41_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	MOVF        R0, 0 
	MOVWF       FARG_sprinti_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprinti_wh+6 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,756 :: 		while(!hid_write(writebuff,64));
L_main257:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main258
	GOTO        L_main257
L_main258:
;ZigbeeRemoteIOV1.0.c,757 :: 		}
L_main256:
;ZigbeeRemoteIOV1.0.c,758 :: 		}
	GOTO        L_main259
L_main255:
;ZigbeeRemoteIOV1.0.c,759 :: 		else if(strcmp(CommandTrimmed[0],"SEND")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr42_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr42_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main424
	MOVLW       0
	XORWF       R0, 0 
L__main424:
	BTFSS       STATUS+0, 2 
	GOTO        L_main260
;ZigbeeRemoteIOV1.0.c,760 :: 		SendDataPacket(0,CommandTrimmed[1],strlen(CommandTrimmed[1]),0);
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SendDataPacket_len+0 
	MOVF        R1, 0 
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_brodcast+0 
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,762 :: 		}
	GOTO        L_main261
L_main260:
;ZigbeeRemoteIOV1.0.c,763 :: 		else if(strcmp(CommandTrimmed[0],"?")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr43_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr43_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main425
	MOVLW       0
	XORWF       R0, 0 
L__main425:
	BTFSS       STATUS+0, 2 
	GOTO        L_main262
;ZigbeeRemoteIOV1.0.c,765 :: 		sprinti(writebuff,"KPP ZIGBEE BOARD V1.1\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_44_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_44_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_44_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+2 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,766 :: 		while(!hid_write(writebuff,64));
L_main263:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main264
	GOTO        L_main263
L_main264:
;ZigbeeRemoteIOV1.0.c,767 :: 		}
	GOTO        L_main265
L_main262:
;ZigbeeRemoteIOV1.0.c,769 :: 		else if(strcmp(CommandTrimmed[0],"ZIGBEE")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr45_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr45_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main426
	MOVLW       0
	XORWF       R0, 0 
L__main426:
	BTFSS       STATUS+0, 2 
	GOTO        L_main266
;ZigbeeRemoteIOV1.0.c,771 :: 		if(strcmp(CommandTrimmed[1],"SET")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr46_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr46_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main427
	MOVLW       0
	XORWF       R0, 0 
L__main427:
	BTFSS       STATUS+0, 2 
	GOTO        L_main267
;ZigbeeRemoteIOV1.0.c,772 :: 		if(strcmp(CommandTrimmed[2],"DEVICE")==0){
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr47_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr47_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main428
	MOVLW       0
	XORWF       R0, 0 
L__main428:
	BTFSS       STATUS+0, 2 
	GOTO        L_main268
;ZigbeeRemoteIOV1.0.c,773 :: 		int devnum=0;
	CLRF        main_devnum_L6+0 
	CLRF        main_devnum_L6+1 
;ZigbeeRemoteIOV1.0.c,774 :: 		devnum=atoi(CommandTrimmed[3]);
	MOVF        main_CommandTrimmed_L0+6, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+7, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       main_devnum_L6+0 
	MOVF        R1, 0 
	MOVWF       main_devnum_L6+1 
;ZigbeeRemoteIOV1.0.c,775 :: 		if(devnum>0 && devnum-1<ZIGBEEDEVICES){
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main429
	MOVF        R0, 0 
	SUBLW       0
L__main429:
	BTFSC       STATUS+0, 0 
	GOTO        L_main271
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
	GOTO        L__main430
	MOVLW       2
	SUBWF       R1, 0 
L__main430:
	BTFSC       STATUS+0, 0 
	GOTO        L_main271
L__main326:
;ZigbeeRemoteIOV1.0.c,777 :: 		enabledval=atoi(CommandTrimmed[4]);
	MOVF        main_CommandTrimmed_L0+8, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+9, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       main_enabledval_L7+0 
	MOVF        R1, 0 
	MOVWF       main_enabledval_L7+1 
;ZigbeeRemoteIOV1.0.c,778 :: 		if(enabledval==0 || enabledval==1){
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main431
	MOVLW       0
	XORWF       R0, 0 
L__main431:
	BTFSC       STATUS+0, 2 
	GOTO        L__main325
	MOVLW       0
	XORWF       main_enabledval_L7+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main432
	MOVLW       1
	XORWF       main_enabledval_L7+0, 0 
L__main432:
	BTFSC       STATUS+0, 2 
	GOTO        L__main325
	GOTO        L_main274
L__main325:
;ZigbeeRemoteIOV1.0.c,779 :: 		write_eeprom_from(0x01+(devnum-1)*8,CommandTrimmed[5]);
	DECF        main_devnum_L6+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_write_eeprom_from_startaddress+0 
	MOVF        main_CommandTrimmed_L0+10, 0 
	MOVWF       FARG_write_eeprom_from_str+0 
	MOVF        main_CommandTrimmed_L0+11, 0 
	MOVWF       FARG_write_eeprom_from_str+1 
	CALL        _write_eeprom_from+0, 0
;ZigbeeRemoteIOV1.0.c,780 :: 		delay_ms(100);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main275:
	DECFSZ      R13, 1, 1
	BRA         L_main275
	DECFSZ      R12, 1, 1
	BRA         L_main275
	DECFSZ      R11, 1, 1
	BRA         L_main275
	NOP
;ZigbeeRemoteIOV1.0.c,781 :: 		write_eeprom_from(0x02+(devnum-1)*8,CommandTrimmed[4]);
	DECF        main_devnum_L6+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDLW       2
	MOVWF       FARG_write_eeprom_from_startaddress+0 
	MOVF        main_CommandTrimmed_L0+8, 0 
	MOVWF       FARG_write_eeprom_from_str+0 
	MOVF        main_CommandTrimmed_L0+9, 0 
	MOVWF       FARG_write_eeprom_from_str+1 
	CALL        _write_eeprom_from+0, 0
;ZigbeeRemoteIOV1.0.c,782 :: 		delay_ms(100);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main276:
	DECFSZ      R13, 1, 1
	BRA         L_main276
	DECFSZ      R12, 1, 1
	BRA         L_main276
	DECFSZ      R11, 1, 1
	BRA         L_main276
	NOP
;ZigbeeRemoteIOV1.0.c,783 :: 		read_eeprom_to(0x01+(devnum-1)*8,ZigbeeSendDevices[i].enabled);
	DECF        main_devnum_L6+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDLW       1
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+0 
	MOVLW       0
	MOVWF       FARG_read_eeprom_to_dest+1 
	MOVLW       0
	MOVWF       FARG_read_eeprom_to_dest+1 
	CALL        _read_eeprom_to+0, 0
;ZigbeeRemoteIOV1.0.c,784 :: 		delay_ms(100);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main277:
	DECFSZ      R13, 1, 1
	BRA         L_main277
	DECFSZ      R12, 1, 1
	BRA         L_main277
	DECFSZ      R11, 1, 1
	BRA         L_main277
	NOP
;ZigbeeRemoteIOV1.0.c,785 :: 		read_eeprom_to(0x02+(devnum-1)*8,ZigbeeSendDevices[i].Address);
	DECF        main_devnum_L6+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	ADDLW       2
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R4 
	MOVF        main_i_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       1
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
;ZigbeeRemoteIOV1.0.c,786 :: 		}
L_main274:
;ZigbeeRemoteIOV1.0.c,787 :: 		}
L_main271:
;ZigbeeRemoteIOV1.0.c,788 :: 		}
L_main268:
;ZigbeeRemoteIOV1.0.c,789 :: 		}
	GOTO        L_main278
L_main267:
;ZigbeeRemoteIOV1.0.c,791 :: 		else if(strcmp(CommandTrimmed[1],"GET")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr48_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr48_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main433
	MOVLW       0
	XORWF       R0, 0 
L__main433:
	BTFSS       STATUS+0, 2 
	GOTO        L_main279
;ZigbeeRemoteIOV1.0.c,792 :: 		if(strcmp(CommandTrimmed[2],"DEVICE")==0){
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr49_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr49_ZigbeeRemoteIOV1.0+0)
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
	GOTO        L_main280
;ZigbeeRemoteIOV1.0.c,793 :: 		int devnum=0;
	CLRF        main_devnum_L6_L6+0 
	CLRF        main_devnum_L6_L6+1 
;ZigbeeRemoteIOV1.0.c,794 :: 		devnum=atoi(CommandTrimmed[3]);
	MOVF        main_CommandTrimmed_L0+6, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+7, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       main_devnum_L6_L6+0 
	MOVF        R1, 0 
	MOVWF       main_devnum_L6_L6+1 
;ZigbeeRemoteIOV1.0.c,795 :: 		if(devnum>0 && devnum-1<ZIGBEEDEVICES){
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main435
	MOVF        R0, 0 
	SUBLW       0
L__main435:
	BTFSC       STATUS+0, 0 
	GOTO        L_main283
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
	GOTO        L__main436
	MOVLW       2
	SUBWF       R1, 0 
L__main436:
	BTFSC       STATUS+0, 0 
	GOTO        L_main283
L__main324:
;ZigbeeRemoteIOV1.0.c,796 :: 		int i,k=0;
	CLRF        main_k_L7+0 
	CLRF        main_k_L7+1 
;ZigbeeRemoteIOV1.0.c,799 :: 		for(i=0;i<8;i++){
	CLRF        main_i_L7+0 
	CLRF        main_i_L7+1 
L_main284:
	MOVLW       128
	XORWF       main_i_L7+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main437
	MOVLW       8
	SUBWF       main_i_L7+0, 0 
L__main437:
	BTFSC       STATUS+0, 0 
	GOTO        L_main285
;ZigbeeRemoteIOV1.0.c,800 :: 		ShortToHex(ZigbeeSendDevices[devnum-1].Address,HostZigbeeStr+k);
	MOVLW       1
	SUBWF       main_devnum_L6_L6+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      main_devnum_L6_L6+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
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
;ZigbeeRemoteIOV1.0.c,801 :: 		k=k+2;
	MOVLW       2
	ADDWF       main_k_L7+0, 1 
	MOVLW       0
	ADDWFC      main_k_L7+1, 1 
;ZigbeeRemoteIOV1.0.c,799 :: 		for(i=0;i<8;i++){
	INFSNZ      main_i_L7+0, 1 
	INCF        main_i_L7+1, 1 
;ZigbeeRemoteIOV1.0.c,802 :: 		}
	GOTO        L_main284
L_main285:
;ZigbeeRemoteIOV1.0.c,803 :: 		sprinti(writebuff,"ZIGBEE|DEVICE|%d|%s|%u\n",devnum,HostZigbeeStr,ZigbeeSendDevices[devnum-1].enabled);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_50_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_50_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_50_ZigbeeRemoteIOV1.0+0)
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
	MOVWF       R0 
	MOVLW       0
	SUBWFB      main_devnum_L6_L6+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+9 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,804 :: 		while(!hid_write(writebuff,64));
L_main287:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main288
	GOTO        L_main287
L_main288:
;ZigbeeRemoteIOV1.0.c,805 :: 		}
L_main283:
;ZigbeeRemoteIOV1.0.c,806 :: 		}
L_main280:
;ZigbeeRemoteIOV1.0.c,807 :: 		}
	GOTO        L_main289
L_main279:
;ZigbeeRemoteIOV1.0.c,808 :: 		else if(strcmp(CommandTrimmed[1],"MY")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr51_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr51_ZigbeeRemoteIOV1.0+0)
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
	GOTO        L_main290
;ZigbeeRemoteIOV1.0.c,809 :: 		SendRawPacket(MY1, 8);
	MOVLW       _MY1+0
	MOVWF       FARG_SendRawPacket_RawPacket+0 
	MOVLW       hi_addr(_MY1+0)
	MOVWF       FARG_SendRawPacket_RawPacket+1 
	MOVLW       8
	MOVWF       FARG_SendRawPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendRawPacket_len+1 
	CALL        _SendRawPacket+0, 0
;ZigbeeRemoteIOV1.0.c,810 :: 		}
L_main290:
L_main289:
L_main278:
;ZigbeeRemoteIOV1.0.c,811 :: 		}
L_main266:
L_main265:
L_main261:
L_main259:
L_main254:
;ZigbeeRemoteIOV1.0.c,813 :: 		}
L_main246:
;ZigbeeRemoteIOV1.0.c,815 :: 		}
L_main245:
;ZigbeeRemoteIOV1.0.c,817 :: 		}
	GOTO        L_main240
;ZigbeeRemoteIOV1.0.c,819 :: 		Delay_ms(1);
L_main291:
	DECFSZ      R13, 1, 1
	BRA         L_main291
	DECFSZ      R12, 1, 1
	BRA         L_main291
	NOP
;ZigbeeRemoteIOV1.0.c,821 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
