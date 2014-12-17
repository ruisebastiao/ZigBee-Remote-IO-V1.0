
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
	GOTO        L__DeleteChar336
	MOVLW       0
	XORWF       R0, 0 
L__DeleteChar336:
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
	GOTO        L__SendRawPacket338
	MOVF        FARG_SendRawPacket_len+0, 0 
	SUBWF       SendRawPacket_i_L0+0, 0 
L__SendRawPacket338:
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

;ZigbeeRemoteIOV1.0.c,78 :: 		void SendDataPacket(short broadcast,char* DataPacket,int len,char Ack)
;ZigbeeRemoteIOV1.0.c,82 :: 		int k=0;
	CLRF        SendDataPacket_k_L0+0 
	CLRF        SendDataPacket_k_L0+1 
;ZigbeeRemoteIOV1.0.c,83 :: 		do{
L_SendDataPacket5:
;ZigbeeRemoteIOV1.0.c,84 :: 		int i=0, framesize2=14+len;
	CLRF        SendDataPacket_i_L1+0 
	CLRF        SendDataPacket_i_L1+1 
	MOVLW       14
	ADDWF       FARG_SendDataPacket_len+0, 0 
	MOVWF       SendDataPacket_framesize2_L1+0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_len+1, 0 
	MOVWF       SendDataPacket_framesize2_L1+1 
;ZigbeeRemoteIOV1.0.c,86 :: 		unsigned short checkSum=0;
	CLRF        SendDataPacket_checkSum_L1+0 
;ZigbeeRemoteIOV1.0.c,88 :: 		ZigbeeSendDevice=ZigbeeSendDevices[k];
	MOVF        SendDataPacket_k_L0+0, 0 
	MOVWF       R0 
	MOVF        SendDataPacket_k_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVLW       4
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
;ZigbeeRemoteIOV1.0.c,90 :: 		if(ZigbeeSendDevice.enabled==1 || broadcast==1){
	MOVLW       0
	XORWF       SendDataPacket_ZigbeeSendDevice_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket340
	MOVLW       1
	XORWF       SendDataPacket_ZigbeeSendDevice_L0+0, 0 
L__SendDataPacket340:
	BTFSC       STATUS+0, 2 
	GOTO        L__SendDataPacket303
	MOVF        FARG_SendDataPacket_broadcast+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__SendDataPacket303
	GOTO        L_SendDataPacket11
L__SendDataPacket303:
;ZigbeeRemoteIOV1.0.c,91 :: 		DataToSend[0]=0x7E;
	MOVLW       126
	MOVWF       SendDataPacket_DataToSend_L1+0 
;ZigbeeRemoteIOV1.0.c,92 :: 		DataToSend[1]=0x00;
	CLRF        SendDataPacket_DataToSend_L1+1 
;ZigbeeRemoteIOV1.0.c,94 :: 		DataToSend[2]=framesize2;
	MOVF        SendDataPacket_framesize2_L1+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+2 
;ZigbeeRemoteIOV1.0.c,95 :: 		DataToSend[3]=0x10;
	MOVLW       16
	MOVWF       SendDataPacket_DataToSend_L1+3 
;ZigbeeRemoteIOV1.0.c,96 :: 		DataToSend[4]=0x01;
	MOVLW       1
	MOVWF       SendDataPacket_DataToSend_L1+4 
;ZigbeeRemoteIOV1.0.c,99 :: 		if( broadcast==1 )
	MOVF        FARG_SendDataPacket_broadcast+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket12
;ZigbeeRemoteIOV1.0.c,102 :: 		DataToSend[5]=0;
	CLRF        SendDataPacket_DataToSend_L1+5 
;ZigbeeRemoteIOV1.0.c,103 :: 		DataToSend[6]=0;
	CLRF        SendDataPacket_DataToSend_L1+6 
;ZigbeeRemoteIOV1.0.c,104 :: 		DataToSend[7]=0;
	CLRF        SendDataPacket_DataToSend_L1+7 
;ZigbeeRemoteIOV1.0.c,105 :: 		DataToSend[8]=0;
	CLRF        SendDataPacket_DataToSend_L1+8 
;ZigbeeRemoteIOV1.0.c,106 :: 		DataToSend[9]=0;
	CLRF        SendDataPacket_DataToSend_L1+9 
;ZigbeeRemoteIOV1.0.c,107 :: 		DataToSend[10]=0;
	CLRF        SendDataPacket_DataToSend_L1+10 
;ZigbeeRemoteIOV1.0.c,108 :: 		DataToSend[11]=0;
	CLRF        SendDataPacket_DataToSend_L1+11 
;ZigbeeRemoteIOV1.0.c,109 :: 		DataToSend[12]=0;
	CLRF        SendDataPacket_DataToSend_L1+12 
;ZigbeeRemoteIOV1.0.c,110 :: 		}
	GOTO        L_SendDataPacket13
L_SendDataPacket12:
;ZigbeeRemoteIOV1.0.c,115 :: 		DataToSend[5]=ZigbeeSendDevice.Address[0];
	MOVFF       SendDataPacket_ZigbeeSendDevice_L0+2, FSR0
	MOVFF       SendDataPacket_ZigbeeSendDevice_L0+3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+5 
;ZigbeeRemoteIOV1.0.c,116 :: 		DataToSend[6]=ZigbeeSendDevice.Address[1];
	MOVLW       1
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+6 
;ZigbeeRemoteIOV1.0.c,117 :: 		DataToSend[7]=ZigbeeSendDevice.Address[2];
	MOVLW       2
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+7 
;ZigbeeRemoteIOV1.0.c,118 :: 		DataToSend[8]=ZigbeeSendDevice.Address[3];
	MOVLW       3
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+8 
;ZigbeeRemoteIOV1.0.c,119 :: 		DataToSend[9]=ZigbeeSendDevice.Address[4];
	MOVLW       4
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+9 
;ZigbeeRemoteIOV1.0.c,120 :: 		DataToSend[10]=ZigbeeSendDevice.Address[5];
	MOVLW       5
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+10 
;ZigbeeRemoteIOV1.0.c,121 :: 		DataToSend[11]=ZigbeeSendDevice.Address[6];
	MOVLW       6
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+11 
;ZigbeeRemoteIOV1.0.c,122 :: 		DataToSend[12]=ZigbeeSendDevice.Address[7];
	MOVLW       7
	ADDWF       SendDataPacket_ZigbeeSendDevice_L0+2, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      SendDataPacket_ZigbeeSendDevice_L0+3, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L1+12 
;ZigbeeRemoteIOV1.0.c,123 :: 		}
L_SendDataPacket13:
;ZigbeeRemoteIOV1.0.c,125 :: 		DataToSend[13]=0xFF;
	MOVLW       255
	MOVWF       SendDataPacket_DataToSend_L1+13 
;ZigbeeRemoteIOV1.0.c,126 :: 		DataToSend[14]=0xFE;
	MOVLW       254
	MOVWF       SendDataPacket_DataToSend_L1+14 
;ZigbeeRemoteIOV1.0.c,128 :: 		DataToSend[15]=0x00;
	CLRF        SendDataPacket_DataToSend_L1+15 
;ZigbeeRemoteIOV1.0.c,130 :: 		DataToSend[16]=0x01;
	MOVLW       1
	MOVWF       SendDataPacket_DataToSend_L1+16 
;ZigbeeRemoteIOV1.0.c,133 :: 		for( i=17; i<17+len; i++ )
	MOVLW       17
	MOVWF       SendDataPacket_i_L1+0 
	MOVLW       0
	MOVWF       SendDataPacket_i_L1+1 
L_SendDataPacket14:
	MOVLW       17
	ADDWF       FARG_SendDataPacket_len+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_len+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       SendDataPacket_i_L1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket341
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L1+0, 0 
L__SendDataPacket341:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket15
;ZigbeeRemoteIOV1.0.c,135 :: 		DataToSend[i]=DataPacket[i-17];
	MOVLW       SendDataPacket_DataToSend_L1+0
	ADDWF       SendDataPacket_i_L1+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L1+0)
	ADDWFC      SendDataPacket_i_L1+1, 0 
	MOVWF       FSR1H 
	MOVLW       17
	SUBWF       SendDataPacket_i_L1+0, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      SendDataPacket_i_L1+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	ADDWF       FARG_SendDataPacket_DataPacket+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_SendDataPacket_DataPacket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,133 :: 		for( i=17; i<17+len; i++ )
	INFSNZ      SendDataPacket_i_L1+0, 1 
	INCF        SendDataPacket_i_L1+1, 1 
;ZigbeeRemoteIOV1.0.c,136 :: 		}
	GOTO        L_SendDataPacket14
L_SendDataPacket15:
;ZigbeeRemoteIOV1.0.c,139 :: 		for( i=3; i<framesize2+3; i++ )
	MOVLW       3
	MOVWF       SendDataPacket_i_L1+0 
	MOVLW       0
	MOVWF       SendDataPacket_i_L1+1 
L_SendDataPacket17:
	MOVLW       3
	ADDWF       SendDataPacket_framesize2_L1+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      SendDataPacket_framesize2_L1+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       SendDataPacket_i_L1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket342
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L1+0, 0 
L__SendDataPacket342:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket18
;ZigbeeRemoteIOV1.0.c,141 :: 		checkSum=checkSum+DataToSend[i];
	MOVLW       SendDataPacket_DataToSend_L1+0
	ADDWF       SendDataPacket_i_L1+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L1+0)
	ADDWFC      SendDataPacket_i_L1+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       SendDataPacket_checkSum_L1+0, 1 
;ZigbeeRemoteIOV1.0.c,139 :: 		for( i=3; i<framesize2+3; i++ )
	INFSNZ      SendDataPacket_i_L1+0, 1 
	INCF        SendDataPacket_i_L1+1, 1 
;ZigbeeRemoteIOV1.0.c,142 :: 		}
	GOTO        L_SendDataPacket17
L_SendDataPacket18:
;ZigbeeRemoteIOV1.0.c,144 :: 		checkSum=0xFF-checkSum;
	MOVF        SendDataPacket_checkSum_L1+0, 0 
	SUBLW       255
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       SendDataPacket_checkSum_L1+0 
;ZigbeeRemoteIOV1.0.c,147 :: 		DataToSend[i]=checkSum;
	MOVLW       SendDataPacket_DataToSend_L1+0
	ADDWF       SendDataPacket_i_L1+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L1+0)
	ADDWFC      SendDataPacket_i_L1+1, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,148 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket343
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket343:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket22
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket22
L__SendDataPacket302:
;ZigbeeRemoteIOV1.0.c,149 :: 		sprinti(writebuff,"\nPacket: ");
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
;ZigbeeRemoteIOV1.0.c,150 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,151 :: 		delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_SendDataPacket25:
	DECFSZ      R13, 1, 1
	BRA         L_SendDataPacket25
	DECFSZ      R12, 1, 1
	BRA         L_SendDataPacket25
	NOP
;ZigbeeRemoteIOV1.0.c,152 :: 		}
L_SendDataPacket22:
;ZigbeeRemoteIOV1.0.c,154 :: 		for( i=0; i<framesize2+4; i++ )
	CLRF        SendDataPacket_i_L1+0 
	CLRF        SendDataPacket_i_L1+1 
L_SendDataPacket26:
	MOVLW       4
	ADDWF       SendDataPacket_framesize2_L1+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      SendDataPacket_framesize2_L1+1, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       SendDataPacket_i_L1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket344
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L1+0, 0 
L__SendDataPacket344:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket27
;ZigbeeRemoteIOV1.0.c,156 :: 		UART1_Write( DataToSend[i]);
	MOVLW       SendDataPacket_DataToSend_L1+0
	ADDWF       SendDataPacket_i_L1+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L1+0)
	ADDWFC      SendDataPacket_i_L1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ZigbeeRemoteIOV1.0.c,157 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket345
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket345:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket31
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket31
L__SendDataPacket301:
;ZigbeeRemoteIOV1.0.c,158 :: 		sprinti(writebuff,"%X",DataToSend[i]);
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
	MOVLW       SendDataPacket_DataToSend_L1+0
	ADDWF       SendDataPacket_i_L1+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L1+0)
	ADDWFC      SendDataPacket_i_L1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_sprinti_wh+5 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,159 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket32:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket33
	GOTO        L_SendDataPacket32
L_SendDataPacket33:
;ZigbeeRemoteIOV1.0.c,160 :: 		delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_SendDataPacket34:
	DECFSZ      R13, 1, 1
	BRA         L_SendDataPacket34
	DECFSZ      R12, 1, 1
	BRA         L_SendDataPacket34
	NOP
;ZigbeeRemoteIOV1.0.c,161 :: 		}
L_SendDataPacket31:
;ZigbeeRemoteIOV1.0.c,154 :: 		for( i=0; i<framesize2+4; i++ )
	INFSNZ      SendDataPacket_i_L1+0, 1 
	INCF        SendDataPacket_i_L1+1, 1 
;ZigbeeRemoteIOV1.0.c,162 :: 		}
	GOTO        L_SendDataPacket26
L_SendDataPacket27:
;ZigbeeRemoteIOV1.0.c,163 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket346
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket346:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket37
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket37
L__SendDataPacket300:
;ZigbeeRemoteIOV1.0.c,164 :: 		sprinti(writebuff,"\n");
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
;ZigbeeRemoteIOV1.0.c,165 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,166 :: 		delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_SendDataPacket40:
	DECFSZ      R13, 1, 1
	BRA         L_SendDataPacket40
	DECFSZ      R12, 1, 1
	BRA         L_SendDataPacket40
	NOP
;ZigbeeRemoteIOV1.0.c,167 :: 		}
L_SendDataPacket37:
;ZigbeeRemoteIOV1.0.c,168 :: 		if(broadcast==1) break;
	MOVF        FARG_SendDataPacket_broadcast+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket41
	GOTO        L_SendDataPacket6
L_SendDataPacket41:
;ZigbeeRemoteIOV1.0.c,169 :: 		}
L_SendDataPacket11:
;ZigbeeRemoteIOV1.0.c,170 :: 		k++;
	INFSNZ      SendDataPacket_k_L0+0, 1 
	INCF        SendDataPacket_k_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,172 :: 		while(k<ZIGBEEDEVICES);
	MOVLW       128
	XORWF       SendDataPacket_k_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket347
	MOVLW       2
	SUBWF       SendDataPacket_k_L0+0, 0 
L__SendDataPacket347:
	BTFSS       STATUS+0, 0 
	GOTO        L_SendDataPacket5
L_SendDataPacket6:
;ZigbeeRemoteIOV1.0.c,173 :: 		}
L_end_SendDataPacket:
	RETURN      0
; end of _SendDataPacket

_ProcessZigBeeDataPacket:

;ZigbeeRemoteIOV1.0.c,175 :: 		void ProcessZigBeeDataPacket(char* DataPacket,char *DevIP)
;ZigbeeRemoteIOV1.0.c,179 :: 		char del[2] = "|";
	MOVLW       124
	MOVWF       ProcessZigBeeDataPacket_del_L0+0 
	CLRF        ProcessZigBeeDataPacket_del_L0+1 
	CLRF        ProcessZigBeeDataPacket_i_L0+0 
	CLRF        ProcessZigBeeDataPacket_i_L0+1 
;ZigbeeRemoteIOV1.0.c,183 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket349
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeDataPacket349:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket305
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket350
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeDataPacket350:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket305
	GOTO        L_ProcessZigBeeDataPacket46
L__ProcessZigBeeDataPacket305:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeDataPacket46
L__ProcessZigBeeDataPacket304:
;ZigbeeRemoteIOV1.0.c,184 :: 		sprinti(writebuff, "ZIGBEE|%s\n",DataPacket);
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
;ZigbeeRemoteIOV1.0.c,185 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeDataPacket47:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket48
	GOTO        L_ProcessZigBeeDataPacket47
L_ProcessZigBeeDataPacket48:
;ZigbeeRemoteIOV1.0.c,186 :: 		}
L_ProcessZigBeeDataPacket46:
;ZigbeeRemoteIOV1.0.c,189 :: 		CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(DataPacket,'\r'),'\n'), del);
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
;ZigbeeRemoteIOV1.0.c,192 :: 		do
L_ProcessZigBeeDataPacket49:
;ZigbeeRemoteIOV1.0.c,195 :: 		i++;
	INFSNZ      ProcessZigBeeDataPacket_i_L0+0, 1 
	INCF        ProcessZigBeeDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,196 :: 		CommandTrimmed[i] = strtok(0, del);
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
;ZigbeeRemoteIOV1.0.c,199 :: 		while( CommandTrimmed[i] != 0 );
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
	GOTO        L__ProcessZigBeeDataPacket351
	MOVLW       0
	XORWF       R1, 0 
L__ProcessZigBeeDataPacket351:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket49
;ZigbeeRemoteIOV1.0.c,205 :: 		if(strcmp(CommandTrimmed[0],"OUT")==0){
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
	GOTO        L__ProcessZigBeeDataPacket352
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket352:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket52
;ZigbeeRemoteIOV1.0.c,206 :: 		if(strcmp(CommandTrimmed[1],"1")==0){
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
	GOTO        L__ProcessZigBeeDataPacket353
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket353:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket53
;ZigbeeRemoteIOV1.0.c,207 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket354
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket354:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket54
;ZigbeeRemoteIOV1.0.c,208 :: 		PICOUT1=1;
	BSF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,209 :: 		}
	GOTO        L_ProcessZigBeeDataPacket55
L_ProcessZigBeeDataPacket54:
;ZigbeeRemoteIOV1.0.c,210 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
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
	GOTO        L__ProcessZigBeeDataPacket355
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket355:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket56
;ZigbeeRemoteIOV1.0.c,211 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,212 :: 		}
L_ProcessZigBeeDataPacket56:
L_ProcessZigBeeDataPacket55:
;ZigbeeRemoteIOV1.0.c,213 :: 		}
	GOTO        L_ProcessZigBeeDataPacket57
L_ProcessZigBeeDataPacket53:
;ZigbeeRemoteIOV1.0.c,214 :: 		else  if(strcmp(CommandTrimmed[1],"2")==0){
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
	GOTO        L__ProcessZigBeeDataPacket356
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket356:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket58
;ZigbeeRemoteIOV1.0.c,215 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket357
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket357:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket59
;ZigbeeRemoteIOV1.0.c,216 :: 		PICOUT2=1;
	BSF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,217 :: 		}
	GOTO        L_ProcessZigBeeDataPacket60
L_ProcessZigBeeDataPacket59:
;ZigbeeRemoteIOV1.0.c,218 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
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
	GOTO        L__ProcessZigBeeDataPacket358
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket358:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket61
;ZigbeeRemoteIOV1.0.c,219 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,220 :: 		}
L_ProcessZigBeeDataPacket61:
L_ProcessZigBeeDataPacket60:
;ZigbeeRemoteIOV1.0.c,221 :: 		}
	GOTO        L_ProcessZigBeeDataPacket62
L_ProcessZigBeeDataPacket58:
;ZigbeeRemoteIOV1.0.c,222 :: 		else if(strcmp(CommandTrimmed[1],"3")==0){
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
	GOTO        L__ProcessZigBeeDataPacket359
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket359:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket63
;ZigbeeRemoteIOV1.0.c,223 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket360
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket360:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket64
;ZigbeeRemoteIOV1.0.c,224 :: 		PICOUT3=1;
	BSF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,225 :: 		}
	GOTO        L_ProcessZigBeeDataPacket65
L_ProcessZigBeeDataPacket64:
;ZigbeeRemoteIOV1.0.c,226 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
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
	GOTO        L__ProcessZigBeeDataPacket361
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket361:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket66
;ZigbeeRemoteIOV1.0.c,227 :: 		PICOUT3=0;
	BCF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,228 :: 		}
L_ProcessZigBeeDataPacket66:
L_ProcessZigBeeDataPacket65:
;ZigbeeRemoteIOV1.0.c,229 :: 		}
	GOTO        L_ProcessZigBeeDataPacket67
L_ProcessZigBeeDataPacket63:
;ZigbeeRemoteIOV1.0.c,230 :: 		else if(strcmp(CommandTrimmed[1],"4")==0){
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
	GOTO        L__ProcessZigBeeDataPacket362
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket362:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket68
;ZigbeeRemoteIOV1.0.c,231 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket363
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket363:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket69
;ZigbeeRemoteIOV1.0.c,232 :: 		PICOUT4=1;
	BSF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,233 :: 		}
	GOTO        L_ProcessZigBeeDataPacket70
L_ProcessZigBeeDataPacket69:
;ZigbeeRemoteIOV1.0.c,234 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
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
	GOTO        L__ProcessZigBeeDataPacket364
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket364:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket71
;ZigbeeRemoteIOV1.0.c,235 :: 		PICOUT4=0;
	BCF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,236 :: 		}
L_ProcessZigBeeDataPacket71:
L_ProcessZigBeeDataPacket70:
;ZigbeeRemoteIOV1.0.c,237 :: 		}
L_ProcessZigBeeDataPacket68:
L_ProcessZigBeeDataPacket67:
L_ProcessZigBeeDataPacket62:
L_ProcessZigBeeDataPacket57:
;ZigbeeRemoteIOV1.0.c,238 :: 		}
L_ProcessZigBeeDataPacket52:
;ZigbeeRemoteIOV1.0.c,242 :: 		}
L_end_ProcessZigBeeDataPacket:
	RETURN      0
; end of _ProcessZigBeeDataPacket

_ProcessZigBeeFrame:

;ZigbeeRemoteIOV1.0.c,246 :: 		void ProcessZigBeeFrame()
;ZigbeeRemoteIOV1.0.c,249 :: 		int FrameType=0;
	CLRF        ProcessZigBeeFrame_FrameType_L0+0 
	CLRF        ProcessZigBeeFrame_FrameType_L0+1 
	CLRF        ProcessZigBeeFrame_ATCommand_L0+0 
	CLRF        ProcessZigBeeFrame_ATCommand_L0+1 
;ZigbeeRemoteIOV1.0.c,264 :: 		FrameType=ZigbeeFrame[3];
	MOVF        _ZigbeeFrame+3, 0 
	MOVWF       ProcessZigBeeFrame_FrameType_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_FrameType_L0+1 
;ZigbeeRemoteIOV1.0.c,267 :: 		if( FrameType==0x90 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame366
	MOVLW       144
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame366:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame72
;ZigbeeRemoteIOV1.0.c,270 :: 		for( i=4; i<=11; i++ )
	MOVLW       4
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
	GOTO        L__ProcessZigBeeFrame367
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBLW       11
L__ProcessZigBeeFrame367:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame74
;ZigbeeRemoteIOV1.0.c,273 :: 		SenderMac[i-4]=ZigbeeFrame [ i ];
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
;ZigbeeRemoteIOV1.0.c,270 :: 		for( i=4; i<=11; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,274 :: 		}
	GOTO        L_ProcessZigBeeFrame73
L_ProcessZigBeeFrame74:
;ZigbeeRemoteIOV1.0.c,277 :: 		for( i=12; i<=13; i++ )
	MOVLW       12
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame76:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame368
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBLW       13
L__ProcessZigBeeFrame368:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame77
;ZigbeeRemoteIOV1.0.c,280 :: 		SenderAddress[i-12]=ZigbeeFrame[ i ];
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
;ZigbeeRemoteIOV1.0.c,277 :: 		for( i=12; i<=13; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,281 :: 		}
	GOTO        L_ProcessZigBeeFrame76
L_ProcessZigBeeFrame77:
;ZigbeeRemoteIOV1.0.c,283 :: 		SenderAddress[i-12]='\0';
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
;ZigbeeRemoteIOV1.0.c,284 :: 		for( i=15; i<=framesize+2; i++ )
	MOVLW       15
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame79:
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
	GOTO        L__ProcessZigBeeFrame369
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBWF       R1, 0 
L__ProcessZigBeeFrame369:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame80
;ZigbeeRemoteIOV1.0.c,287 :: 		ZigbeeDataPacket[i-15]=ZigbeeFrame[ i ];
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
;ZigbeeRemoteIOV1.0.c,284 :: 		for( i=15; i<=framesize+2; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,288 :: 		}
	GOTO        L_ProcessZigBeeFrame79
L_ProcessZigBeeFrame80:
;ZigbeeRemoteIOV1.0.c,290 :: 		ZigbeeDataPacket[i-15]='\0';
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
;ZigbeeRemoteIOV1.0.c,292 :: 		ProcessZigBeeDataPacket( ZigbeeDataPacket, SenderAddress );
	MOVLW       ProcessZigBeeFrame_ZigbeeDataPacket_L0+0
	MOVWF       FARG_ProcessZigBeeDataPacket_DataPacket+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_ZigbeeDataPacket_L0+0)
	MOVWF       FARG_ProcessZigBeeDataPacket_DataPacket+1 
	MOVLW       ProcessZigBeeFrame_SenderAddress_L0+0
	MOVWF       FARG_ProcessZigBeeDataPacket_DevIP+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_SenderAddress_L0+0)
	MOVWF       FARG_ProcessZigBeeDataPacket_DevIP+1 
	CALL        _ProcessZigBeeDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,293 :: 		}
	GOTO        L_ProcessZigBeeFrame82
L_ProcessZigBeeFrame72:
;ZigbeeRemoteIOV1.0.c,296 :: 		else if( FrameType==0x95 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame370
	MOVLW       149
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame370:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame83
;ZigbeeRemoteIOV1.0.c,299 :: 		DeviceAdress[0]=ZigbeeFrame [12];
	MOVF        _ZigbeeFrame+12, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+0 
;ZigbeeRemoteIOV1.0.c,300 :: 		DeviceAdress[1]=ZigbeeFrame [13];
	MOVF        _ZigbeeFrame+13, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+1 
;ZigbeeRemoteIOV1.0.c,302 :: 		for( i=4; i<12; i++ )
	MOVLW       4
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame84:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame371
	MOVLW       12
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame371:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame85
;ZigbeeRemoteIOV1.0.c,304 :: 		DeviceMAC[i-4]=ZigbeeFrame[i];
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
;ZigbeeRemoteIOV1.0.c,302 :: 		for( i=4; i<12; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,305 :: 		}
	GOTO        L_ProcessZigBeeFrame84
L_ProcessZigBeeFrame85:
;ZigbeeRemoteIOV1.0.c,308 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	CLRF        ProcessZigBeeFrame_i_L0+0 
	CLRF        ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame87:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame372
	MOVLW       16
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame372:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame88
;ZigbeeRemoteIOV1.0.c,310 :: 		DeviceID[i]=ZigbeeFrame[i+26];
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
;ZigbeeRemoteIOV1.0.c,311 :: 		if( DeviceID[i]==0x00 )break;
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame90
	GOTO        L_ProcessZigBeeFrame88
L_ProcessZigBeeFrame90:
;ZigbeeRemoteIOV1.0.c,308 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,312 :: 		}
	GOTO        L_ProcessZigBeeFrame87
L_ProcessZigBeeFrame88:
;ZigbeeRemoteIOV1.0.c,314 :: 		}
	GOTO        L_ProcessZigBeeFrame91
L_ProcessZigBeeFrame83:
;ZigbeeRemoteIOV1.0.c,317 :: 		else if( FrameType==0x88 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame373
	MOVLW       136
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame373:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame92
;ZigbeeRemoteIOV1.0.c,325 :: 		ATCommand[0]=ZigbeeFrame [ 5 ];
	MOVF        _ZigbeeFrame+5, 0 
	MOVWF       ProcessZigBeeFrame_ATCommand_L0+0 
;ZigbeeRemoteIOV1.0.c,326 :: 		ATCommand[1]=ZigbeeFrame [ 6 ];
	MOVF        _ZigbeeFrame+6, 0 
	MOVWF       ProcessZigBeeFrame_ATCommand_L0+1 
;ZigbeeRemoteIOV1.0.c,329 :: 		if( ZigbeeFrame [7]==0x00 )
	MOVF        _ZigbeeFrame+7, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame93
;ZigbeeRemoteIOV1.0.c,332 :: 		if( ATCommand[0]=='N'&&ATCommand[1]=='D' )
	MOVF        ProcessZigBeeFrame_ATCommand_L0+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame96
	MOVF        ProcessZigBeeFrame_ATCommand_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame96
L__ProcessZigBeeFrame322:
;ZigbeeRemoteIOV1.0.c,334 :: 		DeviceAdress[0]=ZigbeeFrame [8];
	MOVF        _ZigbeeFrame+8, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+0 
;ZigbeeRemoteIOV1.0.c,335 :: 		DeviceAdress[1]=ZigbeeFrame [9];
	MOVF        _ZigbeeFrame+9, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+1 
;ZigbeeRemoteIOV1.0.c,337 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame374
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame374:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame97
;ZigbeeRemoteIOV1.0.c,338 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,339 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame375
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame375:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame321
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame376
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame376:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame321
	GOTO        L_ProcessZigBeeFrame102
L__ProcessZigBeeFrame321:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame102
L__ProcessZigBeeFrame320:
;ZigbeeRemoteIOV1.0.c,340 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr18_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr18_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,341 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame103:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame104
	GOTO        L_ProcessZigBeeFrame103
L_ProcessZigBeeFrame104:
;ZigbeeRemoteIOV1.0.c,342 :: 		}
L_ProcessZigBeeFrame102:
;ZigbeeRemoteIOV1.0.c,343 :: 		}
L_ProcessZigBeeFrame97:
;ZigbeeRemoteIOV1.0.c,345 :: 		for( i=10; i<18; i++ )
	MOVLW       10
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame105:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame377
	MOVLW       18
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame377:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame106
;ZigbeeRemoteIOV1.0.c,347 :: 		DeviceMAC[i-10]=ZigbeeFrame[i];
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
;ZigbeeRemoteIOV1.0.c,345 :: 		for( i=10; i<18; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,348 :: 		}
	GOTO        L_ProcessZigBeeFrame105
L_ProcessZigBeeFrame106:
;ZigbeeRemoteIOV1.0.c,353 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	CLRF        ProcessZigBeeFrame_i_L0+0 
	CLRF        ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame108:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame378
	MOVLW       16
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame378:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame109
;ZigbeeRemoteIOV1.0.c,355 :: 		DeviceID[i]=ZigbeeFrame[i+19];
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
;ZigbeeRemoteIOV1.0.c,356 :: 		if( DeviceID[i]==0x00 )break;
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
;ZigbeeRemoteIOV1.0.c,353 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,357 :: 		}
	GOTO        L_ProcessZigBeeFrame108
L_ProcessZigBeeFrame109:
;ZigbeeRemoteIOV1.0.c,361 :: 		}else if( ATCommand[0]=='M'&&ATCommand[1]=='Y' ){
	GOTO        L_ProcessZigBeeFrame112
L_ProcessZigBeeFrame96:
	MOVF        ProcessZigBeeFrame_ATCommand_L0+0, 0 
	XORLW       77
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame115
	MOVF        ProcessZigBeeFrame_ATCommand_L0+1, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame115
L__ProcessZigBeeFrame319:
;ZigbeeRemoteIOV1.0.c,362 :: 		LocalIP[0]=ZigbeeFrame [8];
	MOVF        _ZigbeeFrame+8, 0 
	MOVWF       _LocalIP+0 
;ZigbeeRemoteIOV1.0.c,363 :: 		LocalIP[1]=ZigbeeFrame [9];
	MOVF        _ZigbeeFrame+9, 0 
	MOVWF       _LocalIP+1 
;ZigbeeRemoteIOV1.0.c,365 :: 		if( LocalIP[0]!=0xFF&&LocalIP[1]!=0xFE )
	MOVF        _LocalIP+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame118
	MOVF        _LocalIP+1, 0 
	XORLW       254
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame118
L__ProcessZigBeeFrame318:
;ZigbeeRemoteIOV1.0.c,368 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,369 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame379
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame379:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame317
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame380
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame380:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame317
	GOTO        L_ProcessZigBeeFrame123
L__ProcessZigBeeFrame317:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame123
L__ProcessZigBeeFrame316:
;ZigbeeRemoteIOV1.0.c,370 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr19_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr19_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,371 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,372 :: 		}
L_ProcessZigBeeFrame123:
;ZigbeeRemoteIOV1.0.c,374 :: 		}
	GOTO        L_ProcessZigBeeFrame126
L_ProcessZigBeeFrame118:
;ZigbeeRemoteIOV1.0.c,378 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,380 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame381
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame381:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame315
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame382
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame382:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame315
	GOTO        L_ProcessZigBeeFrame131
L__ProcessZigBeeFrame315:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame131
L__ProcessZigBeeFrame314:
;ZigbeeRemoteIOV1.0.c,381 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK\n");
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
;ZigbeeRemoteIOV1.0.c,382 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,383 :: 		}
L_ProcessZigBeeFrame131:
;ZigbeeRemoteIOV1.0.c,385 :: 		}
L_ProcessZigBeeFrame126:
;ZigbeeRemoteIOV1.0.c,386 :: 		}
L_ProcessZigBeeFrame115:
L_ProcessZigBeeFrame112:
;ZigbeeRemoteIOV1.0.c,387 :: 		}
L_ProcessZigBeeFrame93:
;ZigbeeRemoteIOV1.0.c,388 :: 		}
	GOTO        L_ProcessZigBeeFrame134
L_ProcessZigBeeFrame92:
;ZigbeeRemoteIOV1.0.c,390 :: 		else if( FrameType==0x8A )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame383
	MOVLW       138
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame383:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame135
;ZigbeeRemoteIOV1.0.c,394 :: 		if( ZigbeeFrame[4]==0x03 )
	MOVF        _ZigbeeFrame+4, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame136
;ZigbeeRemoteIOV1.0.c,397 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame384
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame384:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame313
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame385
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame385:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame313
	GOTO        L_ProcessZigBeeFrame141
L__ProcessZigBeeFrame313:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame141
L__ProcessZigBeeFrame312:
;ZigbeeRemoteIOV1.0.c,398 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK\n");
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
;ZigbeeRemoteIOV1.0.c,399 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,400 :: 		}
L_ProcessZigBeeFrame141:
;ZigbeeRemoteIOV1.0.c,401 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,402 :: 		}
	GOTO        L_ProcessZigBeeFrame144
L_ProcessZigBeeFrame136:
;ZigbeeRemoteIOV1.0.c,405 :: 		else if( ZigbeeFrame[4]==0x02 )
	MOVF        _ZigbeeFrame+4, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame145
;ZigbeeRemoteIOV1.0.c,409 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame386
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame386:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame146
;ZigbeeRemoteIOV1.0.c,410 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,412 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame387
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame387:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame311
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame388
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame388:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame311
	GOTO        L_ProcessZigBeeFrame151
L__ProcessZigBeeFrame311:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame151
L__ProcessZigBeeFrame310:
;ZigbeeRemoteIOV1.0.c,413 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr22_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr22_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,414 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,415 :: 		}
L_ProcessZigBeeFrame151:
;ZigbeeRemoteIOV1.0.c,416 :: 		}
L_ProcessZigBeeFrame146:
;ZigbeeRemoteIOV1.0.c,419 :: 		}
L_ProcessZigBeeFrame145:
L_ProcessZigBeeFrame144:
;ZigbeeRemoteIOV1.0.c,422 :: 		}
	GOTO        L_ProcessZigBeeFrame154
L_ProcessZigBeeFrame135:
;ZigbeeRemoteIOV1.0.c,426 :: 		else if( FrameType==0x8B )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame389
	MOVLW       139
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame389:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame155
;ZigbeeRemoteIOV1.0.c,429 :: 		if( ZigbeeFrame[8]==0x00 )
	MOVF        _ZigbeeFrame+8, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame156
;ZigbeeRemoteIOV1.0.c,431 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame390
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame390:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame157
;ZigbeeRemoteIOV1.0.c,432 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,434 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame391
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame391:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame309
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame392
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame392:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame309
	GOTO        L_ProcessZigBeeFrame162
L__ProcessZigBeeFrame309:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame162
L__ProcessZigBeeFrame308:
;ZigbeeRemoteIOV1.0.c,435 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr23_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr23_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,436 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame163:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame164
	GOTO        L_ProcessZigBeeFrame163
L_ProcessZigBeeFrame164:
;ZigbeeRemoteIOV1.0.c,437 :: 		}
L_ProcessZigBeeFrame162:
;ZigbeeRemoteIOV1.0.c,438 :: 		}
L_ProcessZigBeeFrame157:
;ZigbeeRemoteIOV1.0.c,439 :: 		}
	GOTO        L_ProcessZigBeeFrame165
L_ProcessZigBeeFrame156:
;ZigbeeRemoteIOV1.0.c,442 :: 		else if( ZigbeeFrame[8]==0x21 )
	MOVF        _ZigbeeFrame+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame166
;ZigbeeRemoteIOV1.0.c,445 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,447 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame393
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame393:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame307
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame394
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame394:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame307
	GOTO        L_ProcessZigBeeFrame171
L__ProcessZigBeeFrame307:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame171
L__ProcessZigBeeFrame306:
;ZigbeeRemoteIOV1.0.c,448 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK|ACK FAILED\n");
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
;ZigbeeRemoteIOV1.0.c,449 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame172:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame173
	GOTO        L_ProcessZigBeeFrame172
L_ProcessZigBeeFrame173:
;ZigbeeRemoteIOV1.0.c,450 :: 		}
L_ProcessZigBeeFrame171:
;ZigbeeRemoteIOV1.0.c,452 :: 		}
L_ProcessZigBeeFrame166:
L_ProcessZigBeeFrame165:
;ZigbeeRemoteIOV1.0.c,453 :: 		}
L_ProcessZigBeeFrame155:
L_ProcessZigBeeFrame154:
L_ProcessZigBeeFrame134:
L_ProcessZigBeeFrame91:
L_ProcessZigBeeFrame82:
;ZigbeeRemoteIOV1.0.c,469 :: 		}
L_end_ProcessZigBeeFrame:
	RETURN      0
; end of _ProcessZigBeeFrame

_interrupt:

;ZigbeeRemoteIOV1.0.c,473 :: 		void interrupt()
;ZigbeeRemoteIOV1.0.c,478 :: 		if(USBIF_Bit && USBON){
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt176
	BTFSS       PORTB+0, 4 
	GOTO        L_interrupt176
L__interrupt323:
;ZigbeeRemoteIOV1.0.c,479 :: 		USB_Interrupt_Proc();                   // USB servicing is done inside the interrupt
	CALL        _USB_Interrupt_Proc+0, 0
;ZigbeeRemoteIOV1.0.c,480 :: 		}
L_interrupt176:
;ZigbeeRemoteIOV1.0.c,482 :: 		if (PIR1.RCIF) {          // test the interrupt for uart rx
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt177
;ZigbeeRemoteIOV1.0.c,483 :: 		if (UART1_Data_Ready() == 1) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt178
;ZigbeeRemoteIOV1.0.c,484 :: 		Rx_char = UART1_Read();  //
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Rx_char+0 
;ZigbeeRemoteIOV1.0.c,485 :: 		if(Rx_char==0x7E){
	MOVF        R0, 0 
	XORLW       126
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt179
;ZigbeeRemoteIOV1.0.c,486 :: 		frameindex=0;
	CLRF        _frameindex+0 
	CLRF        _frameindex+1 
;ZigbeeRemoteIOV1.0.c,487 :: 		frame_started=1;
	MOVLW       1
	MOVWF       _frame_started+0 
;ZigbeeRemoteIOV1.0.c,489 :: 		}
L_interrupt179:
;ZigbeeRemoteIOV1.0.c,491 :: 		if(frame_started==1){
	MOVF        _frame_started+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt180
;ZigbeeRemoteIOV1.0.c,492 :: 		ZigbeeFrame[frameindex]=Rx_char;
	MOVLW       _ZigbeeFrame+0
	ADDWF       _frameindex+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      _frameindex+1, 0 
	MOVWF       FSR1H 
	MOVF        _Rx_char+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,494 :: 		if( frameindex==2 )
	MOVLW       0
	XORWF       _frameindex+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt397
	MOVLW       2
	XORWF       _frameindex+0, 0 
L__interrupt397:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt181
;ZigbeeRemoteIOV1.0.c,496 :: 		framesize=ZigbeeFrame[1]+ZigbeeFrame[2];
	MOVF        _ZigbeeFrame+2, 0 
	ADDWF       _ZigbeeFrame+1, 0 
	MOVWF       _framesize+0 
	CLRF        _framesize+1 
	MOVLW       0
	ADDWFC      _framesize+1, 1 
;ZigbeeRemoteIOV1.0.c,497 :: 		}
L_interrupt181:
;ZigbeeRemoteIOV1.0.c,499 :: 		frameindex++;
	INFSNZ      _frameindex+0, 1 
	INCF        _frameindex+1, 1 
;ZigbeeRemoteIOV1.0.c,500 :: 		if( frameindex>=framesize+4 )
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
	GOTO        L__interrupt398
	MOVF        R1, 0 
	SUBWF       _frameindex+0, 0 
L__interrupt398:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt182
;ZigbeeRemoteIOV1.0.c,503 :: 		frameindex=0;
	CLRF        _frameindex+0 
	CLRF        _frameindex+1 
;ZigbeeRemoteIOV1.0.c,504 :: 		frame_started=0;
	CLRF        _frame_started+0 
;ZigbeeRemoteIOV1.0.c,505 :: 		GotFrame=1;
	MOVLW       1
	MOVWF       _GotFrame+0 
;ZigbeeRemoteIOV1.0.c,507 :: 		}
L_interrupt182:
;ZigbeeRemoteIOV1.0.c,508 :: 		}
L_interrupt180:
;ZigbeeRemoteIOV1.0.c,509 :: 		}
L_interrupt178:
;ZigbeeRemoteIOV1.0.c,510 :: 		}
L_interrupt177:
;ZigbeeRemoteIOV1.0.c,512 :: 		}
L_end_interrupt:
L__interrupt396:
	RETFIE      1
; end of _interrupt

_ProcessInputs:

;ZigbeeRemoteIOV1.0.c,518 :: 		void ProcessInputs(){
;ZigbeeRemoteIOV1.0.c,520 :: 		if(JoinedLastState!=JoinedToNet){
	MOVF        _JoinedLastState+1, 0 
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs400
	MOVF        _JoinedToNet+0, 0 
	XORWF       _JoinedLastState+0, 0 
L__ProcessInputs400:
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs183
;ZigbeeRemoteIOV1.0.c,521 :: 		JoinedLastState=JoinedToNet;
	MOVF        _JoinedToNet+0, 0 
	MOVWF       _JoinedLastState+0 
	MOVF        _JoinedToNet+1, 0 
	MOVWF       _JoinedLastState+1 
;ZigbeeRemoteIOV1.0.c,522 :: 		PICIN1LastState=!PICIN1;
	BTFSC       PORTB+0, 0 
	GOTO        L__ProcessInputs401
	BSF         4056, 0 
	GOTO        L__ProcessInputs402
L__ProcessInputs401:
	BCF         4056, 0 
L__ProcessInputs402:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN1LastState+0 
;ZigbeeRemoteIOV1.0.c,523 :: 		PICIN2LastState=!PICIN2;
	BTFSC       PORTB+0, 1 
	GOTO        L__ProcessInputs403
	BSF         4056, 0 
	GOTO        L__ProcessInputs404
L__ProcessInputs403:
	BCF         4056, 0 
L__ProcessInputs404:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN2LastState+0 
;ZigbeeRemoteIOV1.0.c,524 :: 		PICIN3LastState=!PICIN3;
	BTFSC       PORTB+0, 2 
	GOTO        L__ProcessInputs405
	BSF         4056, 0 
	GOTO        L__ProcessInputs406
L__ProcessInputs405:
	BCF         4056, 0 
L__ProcessInputs406:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN3LastState+0 
;ZigbeeRemoteIOV1.0.c,525 :: 		PICIN4LastState=!PICIN4;
	BTFSC       PORTB+0, 3 
	GOTO        L__ProcessInputs407
	BSF         4056, 0 
	GOTO        L__ProcessInputs408
L__ProcessInputs407:
	BCF         4056, 0 
L__ProcessInputs408:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN4LastState+0 
;ZigbeeRemoteIOV1.0.c,528 :: 		}
L_ProcessInputs183:
;ZigbeeRemoteIOV1.0.c,530 :: 		if(PICIN1LastState!=PICIN1){
	CLRF        R1 
	BTFSC       PORTB+0, 0 
	INCF        R1, 1 
	MOVF        _PICIN1LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs184
;ZigbeeRemoteIOV1.0.c,531 :: 		if(debounc_in1>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs409
	MOVF        _debounc_in1+0, 0 
	SUBLW       5
L__ProcessInputs409:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs185
;ZigbeeRemoteIOV1.0.c,532 :: 		debounc_in1=0;
	CLRF        _debounc_in1+0 
	CLRF        _debounc_in1+1 
;ZigbeeRemoteIOV1.0.c,533 :: 		PICIN1LastState= PICIN1;
	MOVLW       0
	BTFSC       PORTB+0, 0 
	MOVLW       1
	MOVWF       _PICIN1LastState+0 
;ZigbeeRemoteIOV1.0.c,534 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs410
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs410:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs331
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs411
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs411:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs331
	GOTO        L_ProcessInputs190
L__ProcessInputs331:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs190
L__ProcessInputs330:
;ZigbeeRemoteIOV1.0.c,535 :: 		sprinti(writebuff,"IN 1|%u \n",PICIN1LastState);
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
;ZigbeeRemoteIOV1.0.c,536 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs191:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs192
	GOTO        L_ProcessInputs191
L_ProcessInputs192:
;ZigbeeRemoteIOV1.0.c,537 :: 		}
L_ProcessInputs190:
;ZigbeeRemoteIOV1.0.c,538 :: 		if(PICIN1LastState)
	MOVF        _PICIN1LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs193
;ZigbeeRemoteIOV1.0.c,539 :: 		SendDataPacket(0,"OUT|1|OFF",9,0);
	CLRF        FARG_SendDataPacket_broadcast+0 
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
	GOTO        L_ProcessInputs194
L_ProcessInputs193:
;ZigbeeRemoteIOV1.0.c,541 :: 		SendDataPacket(0,"OUT|1|ON",8,0);
	CLRF        FARG_SendDataPacket_broadcast+0 
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
L_ProcessInputs194:
;ZigbeeRemoteIOV1.0.c,542 :: 		}
	GOTO        L_ProcessInputs195
L_ProcessInputs185:
;ZigbeeRemoteIOV1.0.c,544 :: 		debounc_in1++;
	INFSNZ      _debounc_in1+0, 1 
	INCF        _debounc_in1+1, 1 
L_ProcessInputs195:
;ZigbeeRemoteIOV1.0.c,546 :: 		}
L_ProcessInputs184:
;ZigbeeRemoteIOV1.0.c,547 :: 		if(PICIN2LastState!=PICIN2){
	CLRF        R1 
	BTFSC       PORTB+0, 1 
	INCF        R1, 1 
	MOVF        _PICIN2LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs196
;ZigbeeRemoteIOV1.0.c,549 :: 		if(debounc_in2>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs412
	MOVF        _debounc_in2+0, 0 
	SUBLW       5
L__ProcessInputs412:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs197
;ZigbeeRemoteIOV1.0.c,550 :: 		debounc_in2=0;
	CLRF        _debounc_in2+0 
	CLRF        _debounc_in2+1 
;ZigbeeRemoteIOV1.0.c,551 :: 		PICIN2LastState= PICIN2;
	MOVLW       0
	BTFSC       PORTB+0, 1 
	MOVLW       1
	MOVWF       _PICIN2LastState+0 
;ZigbeeRemoteIOV1.0.c,552 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs413
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs413:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs329
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs414
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs414:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs329
	GOTO        L_ProcessInputs202
L__ProcessInputs329:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs202
L__ProcessInputs328:
;ZigbeeRemoteIOV1.0.c,553 :: 		sprinti(writebuff,"IN 2|%u\n",PICIN2LastState);
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
;ZigbeeRemoteIOV1.0.c,554 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs203:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs204
	GOTO        L_ProcessInputs203
L_ProcessInputs204:
;ZigbeeRemoteIOV1.0.c,555 :: 		}
L_ProcessInputs202:
;ZigbeeRemoteIOV1.0.c,556 :: 		if(PICIN2LastState){
	MOVF        _PICIN2LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs205
;ZigbeeRemoteIOV1.0.c,557 :: 		SendDataPacket(0,"OUT|2|OFF",9,0);
	CLRF        FARG_SendDataPacket_broadcast+0 
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
;ZigbeeRemoteIOV1.0.c,558 :: 		}
	GOTO        L_ProcessInputs206
L_ProcessInputs205:
;ZigbeeRemoteIOV1.0.c,560 :: 		SendDataPacket(0,"OUT|2|ON",8,0);
	CLRF        FARG_SendDataPacket_broadcast+0 
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
;ZigbeeRemoteIOV1.0.c,561 :: 		}
L_ProcessInputs206:
;ZigbeeRemoteIOV1.0.c,562 :: 		}
	GOTO        L_ProcessInputs207
L_ProcessInputs197:
;ZigbeeRemoteIOV1.0.c,564 :: 		debounc_in2++;
	INFSNZ      _debounc_in2+0, 1 
	INCF        _debounc_in2+1, 1 
L_ProcessInputs207:
;ZigbeeRemoteIOV1.0.c,565 :: 		}
L_ProcessInputs196:
;ZigbeeRemoteIOV1.0.c,566 :: 		if(PICIN3LastState!=PICIN3){
	CLRF        R1 
	BTFSC       PORTB+0, 2 
	INCF        R1, 1 
	MOVF        _PICIN3LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs208
;ZigbeeRemoteIOV1.0.c,567 :: 		if(debounc_in3>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in3+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs415
	MOVF        _debounc_in3+0, 0 
	SUBLW       5
L__ProcessInputs415:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs209
;ZigbeeRemoteIOV1.0.c,568 :: 		debounc_in3=0;
	CLRF        _debounc_in3+0 
	CLRF        _debounc_in3+1 
;ZigbeeRemoteIOV1.0.c,569 :: 		PICIN3LastState= PICIN3;
	MOVLW       0
	BTFSC       PORTB+0, 2 
	MOVLW       1
	MOVWF       _PICIN3LastState+0 
;ZigbeeRemoteIOV1.0.c,570 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs416
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs416:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs327
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs417
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs417:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs327
	GOTO        L_ProcessInputs214
L__ProcessInputs327:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs214
L__ProcessInputs326:
;ZigbeeRemoteIOV1.0.c,571 :: 		sprinti(writebuff,"IN 3|%u\n",PICIN3LastState);
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
;ZigbeeRemoteIOV1.0.c,572 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs215:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs216
	GOTO        L_ProcessInputs215
L_ProcessInputs216:
;ZigbeeRemoteIOV1.0.c,573 :: 		}
L_ProcessInputs214:
;ZigbeeRemoteIOV1.0.c,574 :: 		if(PICIN3LastState)
	MOVF        _PICIN3LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs217
;ZigbeeRemoteIOV1.0.c,575 :: 		SendDataPacket(0,"OUT|3|OFF",9,0);
	CLRF        FARG_SendDataPacket_broadcast+0 
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
	GOTO        L_ProcessInputs218
L_ProcessInputs217:
;ZigbeeRemoteIOV1.0.c,577 :: 		SendDataPacket(0,"OUT|3|ON",8,0);
	CLRF        FARG_SendDataPacket_broadcast+0 
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
L_ProcessInputs218:
;ZigbeeRemoteIOV1.0.c,578 :: 		}
	GOTO        L_ProcessInputs219
L_ProcessInputs209:
;ZigbeeRemoteIOV1.0.c,580 :: 		debounc_in3++;
	INFSNZ      _debounc_in3+0, 1 
	INCF        _debounc_in3+1, 1 
L_ProcessInputs219:
;ZigbeeRemoteIOV1.0.c,581 :: 		}
L_ProcessInputs208:
;ZigbeeRemoteIOV1.0.c,582 :: 		if(PICIN4LastState!=PICIN4){
	CLRF        R1 
	BTFSC       PORTB+0, 3 
	INCF        R1, 1 
	MOVF        _PICIN4LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs220
;ZigbeeRemoteIOV1.0.c,583 :: 		if(debounc_in4>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in4+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs418
	MOVF        _debounc_in4+0, 0 
	SUBLW       5
L__ProcessInputs418:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs221
;ZigbeeRemoteIOV1.0.c,584 :: 		debounc_in4=0;
	CLRF        _debounc_in4+0 
	CLRF        _debounc_in4+1 
;ZigbeeRemoteIOV1.0.c,585 :: 		PICIN4LastState= PICIN4;
	MOVLW       0
	BTFSC       PORTB+0, 3 
	MOVLW       1
	MOVWF       _PICIN4LastState+0 
;ZigbeeRemoteIOV1.0.c,586 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs419
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs419:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs325
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs420
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs420:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs325
	GOTO        L_ProcessInputs226
L__ProcessInputs325:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs226
L__ProcessInputs324:
;ZigbeeRemoteIOV1.0.c,587 :: 		sprinti(writebuff,"IN 4|%u\n",PICIN4LastState);
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
;ZigbeeRemoteIOV1.0.c,588 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs227:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs228
	GOTO        L_ProcessInputs227
L_ProcessInputs228:
;ZigbeeRemoteIOV1.0.c,589 :: 		}
L_ProcessInputs226:
;ZigbeeRemoteIOV1.0.c,590 :: 		if(PICIN4LastState)
	MOVF        _PICIN4LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs229
;ZigbeeRemoteIOV1.0.c,591 :: 		SendDataPacket(0,"OUT|4|OFF",9,0);
	CLRF        FARG_SendDataPacket_broadcast+0 
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
	GOTO        L_ProcessInputs230
L_ProcessInputs229:
;ZigbeeRemoteIOV1.0.c,593 :: 		SendDataPacket(0,"OUT|4|ON",8,0);
	CLRF        FARG_SendDataPacket_broadcast+0 
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
L_ProcessInputs230:
;ZigbeeRemoteIOV1.0.c,594 :: 		}
	GOTO        L_ProcessInputs231
L_ProcessInputs221:
;ZigbeeRemoteIOV1.0.c,596 :: 		debounc_in4++;
	INFSNZ      _debounc_in4+0, 1 
	INCF        _debounc_in4+1, 1 
L_ProcessInputs231:
;ZigbeeRemoteIOV1.0.c,597 :: 		}
L_ProcessInputs220:
;ZigbeeRemoteIOV1.0.c,600 :: 		}
L_end_ProcessInputs:
	RETURN      0
; end of _ProcessInputs

_write_eeprom_from:

;ZigbeeRemoteIOV1.0.c,604 :: 		void write_eeprom_from(unsigned int startaddress,char *str){
;ZigbeeRemoteIOV1.0.c,608 :: 		int i=0,j=0;
	CLRF        write_eeprom_from_i_L0+0 
	CLRF        write_eeprom_from_i_L0+1 
	CLRF        write_eeprom_from_j_L0+0 
	CLRF        write_eeprom_from_j_L0+1 
;ZigbeeRemoteIOV1.0.c,609 :: 		for(i=0;i<16;i=i+2){
	CLRF        write_eeprom_from_i_L0+0 
	CLRF        write_eeprom_from_i_L0+1 
L_write_eeprom_from232:
	MOVLW       128
	XORWF       write_eeprom_from_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_eeprom_from422
	MOVLW       16
	SUBWF       write_eeprom_from_i_L0+0, 0 
L__write_eeprom_from422:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_eeprom_from233
;ZigbeeRemoteIOV1.0.c,610 :: 		hexstr[0]=str[i];
	MOVF        write_eeprom_from_i_L0+0, 0 
	ADDWF       FARG_write_eeprom_from_str+0, 0 
	MOVWF       FSR0 
	MOVF        write_eeprom_from_i_L0+1, 0 
	ADDWFC      FARG_write_eeprom_from_str+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       write_eeprom_from_hexstr_L0+0 
;ZigbeeRemoteIOV1.0.c,611 :: 		hexstr[1]=str[i+1];
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
;ZigbeeRemoteIOV1.0.c,612 :: 		hexstr[2]='\0';
	CLRF        write_eeprom_from_hexstr_L0+2 
;ZigbeeRemoteIOV1.0.c,613 :: 		hexval=xtoi(hexstr);
	MOVLW       write_eeprom_from_hexstr_L0+0
	MOVWF       FARG_xtoi_s+0 
	MOVLW       hi_addr(write_eeprom_from_hexstr_L0+0)
	MOVWF       FARG_xtoi_s+1 
	CALL        _xtoi+0, 0
;ZigbeeRemoteIOV1.0.c,614 :: 		EEPROM_Write(startaddress+j,hexval);
	MOVF        write_eeprom_from_j_L0+0, 0 
	ADDWF       FARG_write_eeprom_from_startaddress+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ZigbeeRemoteIOV1.0.c,615 :: 		delay_ms(20);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_write_eeprom_from235:
	DECFSZ      R13, 1, 1
	BRA         L_write_eeprom_from235
	DECFSZ      R12, 1, 1
	BRA         L_write_eeprom_from235
	DECFSZ      R11, 1, 1
	BRA         L_write_eeprom_from235
;ZigbeeRemoteIOV1.0.c,616 :: 		j++;
	INFSNZ      write_eeprom_from_j_L0+0, 1 
	INCF        write_eeprom_from_j_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,609 :: 		for(i=0;i<16;i=i+2){
	MOVLW       2
	ADDWF       write_eeprom_from_i_L0+0, 1 
	MOVLW       0
	ADDWFC      write_eeprom_from_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,617 :: 		}
	GOTO        L_write_eeprom_from232
L_write_eeprom_from233:
;ZigbeeRemoteIOV1.0.c,618 :: 		}
L_end_write_eeprom_from:
	RETURN      0
; end of _write_eeprom_from

_read_eeprom_to:

;ZigbeeRemoteIOV1.0.c,620 :: 		void read_eeprom_to(unsigned int startadress,char *dest){
;ZigbeeRemoteIOV1.0.c,623 :: 		for(i=0;i<8;i++){
	CLRF        read_eeprom_to_i_L0+0 
	CLRF        read_eeprom_to_i_L0+1 
L_read_eeprom_to236:
	MOVLW       128
	XORWF       read_eeprom_to_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_eeprom_to424
	MOVLW       8
	SUBWF       read_eeprom_to_i_L0+0, 0 
L__read_eeprom_to424:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_eeprom_to237
;ZigbeeRemoteIOV1.0.c,624 :: 		delay_ms(30);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       212
	MOVWF       R12, 0
	MOVLW       133
	MOVWF       R13, 0
L_read_eeprom_to239:
	DECFSZ      R13, 1, 1
	BRA         L_read_eeprom_to239
	DECFSZ      R12, 1, 1
	BRA         L_read_eeprom_to239
	DECFSZ      R11, 1, 1
	BRA         L_read_eeprom_to239
;ZigbeeRemoteIOV1.0.c,625 :: 		dest[i]=EEPROM_Read(startadress+i);
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
;ZigbeeRemoteIOV1.0.c,623 :: 		for(i=0;i<8;i++){
	INFSNZ      read_eeprom_to_i_L0+0, 1 
	INCF        read_eeprom_to_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,627 :: 		}
	GOTO        L_read_eeprom_to236
L_read_eeprom_to237:
;ZigbeeRemoteIOV1.0.c,629 :: 		}
L_end_read_eeprom_to:
	RETURN      0
; end of _read_eeprom_to

_main:

;ZigbeeRemoteIOV1.0.c,630 :: 		void main() {
;ZigbeeRemoteIOV1.0.c,632 :: 		int i, MY_retry=0;
;ZigbeeRemoteIOV1.0.c,636 :: 		char del[2] = "|";
	MOVLW       124
	MOVWF       main_del_L0+0 
	CLRF        main_del_L0+1 
;ZigbeeRemoteIOV1.0.c,640 :: 		delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main240:
	DECFSZ      R13, 1, 1
	BRA         L_main240
	DECFSZ      R12, 1, 1
	BRA         L_main240
	DECFSZ      R11, 1, 1
	BRA         L_main240
	NOP
	NOP
;ZigbeeRemoteIOV1.0.c,642 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       225
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;ZigbeeRemoteIOV1.0.c,644 :: 		MM_Init();
	CALL        _MM_Init+0, 0
;ZigbeeRemoteIOV1.0.c,646 :: 		for(i=0;i<10;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main241:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main426
	MOVLW       10
	SUBWF       main_i_L0+0, 0 
L__main426:
	BTFSC       STATUS+0, 0 
	GOTO        L_main242
;ZigbeeRemoteIOV1.0.c,647 :: 		CommandTrimmed[i]=(char *)malloc(sizeof(char)*30);
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
;ZigbeeRemoteIOV1.0.c,648 :: 		if(CommandTrimmed[i]==0) PICOUT4=1;
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
	GOTO        L__main427
	MOVLW       0
	XORWF       R1, 0 
L__main427:
	BTFSS       STATUS+0, 2 
	GOTO        L_main244
	BSF         LATA3_bit+0, BitPos(LATA3_bit+0) 
L_main244:
;ZigbeeRemoteIOV1.0.c,646 :: 		for(i=0;i<10;i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,649 :: 		}
	GOTO        L_main241
L_main242:
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
;ZigbeeRemoteIOV1.0.c,686 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main245:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main428
	MOVLW       2
	SUBWF       main_i_L0+0, 0 
L__main428:
	BTFSC       STATUS+0, 0 
	GOTO        L_main246
;ZigbeeRemoteIOV1.0.c,688 :: 		ZigbeeSendDevices[i].enabled=EEPROM_Read(0x01+(i*8));
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       FLOC__main+0 
	MOVF        R1, 0 
	MOVWF       FLOC__main+1 
	MOVLW       3
	MOVWF       R1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__main429:
	BZ          L__main430
	RLCF        R0, 1 
	BCF         R0, 0 
	ADDLW       255
	GOTO        L__main429
L__main430:
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
;ZigbeeRemoteIOV1.0.c,689 :: 		ZigbeeSendDevices[i].Address=(unsigned short*)malloc(sizeof(char) *8);
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _ZigbeeSendDevices+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_ZigbeeSendDevices+0)
	ADDWFC      R1, 1 
	MOVLW       2
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
;ZigbeeRemoteIOV1.0.c,690 :: 		delay_ms(20);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main248:
	DECFSZ      R13, 1, 1
	BRA         L_main248
	DECFSZ      R12, 1, 1
	BRA         L_main248
	DECFSZ      R11, 1, 1
	BRA         L_main248
;ZigbeeRemoteIOV1.0.c,691 :: 		read_eeprom_to(0x02+(i*8),ZigbeeSendDevices[i].Address);
	MOVLW       3
	MOVWF       R2 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main431:
	BZ          L__main432
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main431
L__main432:
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_read_eeprom_to_startadress+1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
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
	MOVWF       FARG_read_eeprom_to_dest+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+1 
	CALL        _read_eeprom_to+0, 0
;ZigbeeRemoteIOV1.0.c,692 :: 		delay_ms(20);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       56
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main249:
	DECFSZ      R13, 1, 1
	BRA         L_main249
	DECFSZ      R12, 1, 1
	BRA         L_main249
	DECFSZ      R11, 1, 1
	BRA         L_main249
;ZigbeeRemoteIOV1.0.c,686 :: 		for(i=0;i<ZIGBEEDEVICES;i++){
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,693 :: 		}
	GOTO        L_main245
L_main246:
;ZigbeeRemoteIOV1.0.c,696 :: 		if(USBON)
	BTFSS       PORTB+0, 4 
	GOTO        L_main250
;ZigbeeRemoteIOV1.0.c,697 :: 		HID_Enable(readbuff,writebuff);      // Enable HID communication
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
L_main250:
;ZigbeeRemoteIOV1.0.c,701 :: 		debug=0;
	CLRF        _debug+0 
	CLRF        _debug+1 
;ZigbeeRemoteIOV1.0.c,705 :: 		while(1)
L_main251:
;ZigbeeRemoteIOV1.0.c,709 :: 		if(GotFrame==1){
	MOVF        _GotFrame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main253
;ZigbeeRemoteIOV1.0.c,710 :: 		GotFrame=0;
	CLRF        _GotFrame+0 
;ZigbeeRemoteIOV1.0.c,711 :: 		ProcessZigBeeFrame();
	CALL        _ProcessZigBeeFrame+0, 0
;ZigbeeRemoteIOV1.0.c,713 :: 		}
L_main253:
;ZigbeeRemoteIOV1.0.c,716 :: 		ProcessInputs();
	CALL        _ProcessInputs+0, 0
;ZigbeeRemoteIOV1.0.c,719 :: 		if(USBON){
	BTFSS       PORTB+0, 4 
	GOTO        L_main254
;ZigbeeRemoteIOV1.0.c,721 :: 		if(!(hid_read()==0)) {
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main255
;ZigbeeRemoteIOV1.0.c,722 :: 		i=0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;ZigbeeRemoteIOV1.0.c,724 :: 		PICOUT1=!PICOUT1;
	BTG         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,727 :: 		CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(readbuff,'\r'),'\n'), del);
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
;ZigbeeRemoteIOV1.0.c,730 :: 		do
L_main256:
;ZigbeeRemoteIOV1.0.c,733 :: 		i++;
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,734 :: 		CommandTrimmed[i] = strtok(0, del);
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
;ZigbeeRemoteIOV1.0.c,737 :: 		while( CommandTrimmed[i] != 0 );
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
	GOTO        L_main256
;ZigbeeRemoteIOV1.0.c,741 :: 		if(strcmp(CommandTrimmed[0],"UPGRADE")==0){
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
	GOTO        L__main434
	MOVLW       0
	XORWF       R0, 0 
L__main434:
	BTFSS       STATUS+0, 2 
	GOTO        L_main259
;ZigbeeRemoteIOV1.0.c,742 :: 		sprinti(writebuff,"UPGRADING\n");
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
;ZigbeeRemoteIOV1.0.c,743 :: 		while(!hid_write(writebuff,64));
L_main260:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main261
	GOTO        L_main260
L_main261:
;ZigbeeRemoteIOV1.0.c,744 :: 		EEPROM_Write(0x00,0x01);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ZigbeeRemoteIOV1.0.c,745 :: 		HID_Disable();
	CALL        _HID_Disable+0, 0
;ZigbeeRemoteIOV1.0.c,746 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main262:
	DECFSZ      R13, 1, 1
	BRA         L_main262
	DECFSZ      R12, 1, 1
	BRA         L_main262
	DECFSZ      R11, 1, 1
	BRA         L_main262
	NOP
	NOP
;ZigbeeRemoteIOV1.0.c,747 :: 		asm { reset; }
	RESET
;ZigbeeRemoteIOV1.0.c,748 :: 		} else if(strcmp(CommandTrimmed[0],"SET")==0){
	GOTO        L_main263
L_main259:
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
	GOTO        L__main435
	MOVLW       0
	XORWF       R0, 0 
L__main435:
	BTFSS       STATUS+0, 2 
	GOTO        L_main264
;ZigbeeRemoteIOV1.0.c,749 :: 		if(strcmp(CommandTrimmed[1],"DEBUG")==0){
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
	GOTO        L__main436
	MOVLW       0
	XORWF       R0, 0 
L__main436:
	BTFSS       STATUS+0, 2 
	GOTO        L_main265
;ZigbeeRemoteIOV1.0.c,750 :: 		int debug_val=0;
;ZigbeeRemoteIOV1.0.c,751 :: 		debug_val=atoi(CommandTrimmed[2]);
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
;ZigbeeRemoteIOV1.0.c,752 :: 		debug=debug_val;
	MOVF        R0, 0 
	MOVWF       _debug+0 
	MOVF        R1, 0 
	MOVWF       _debug+1 
;ZigbeeRemoteIOV1.0.c,753 :: 		sprinti(writebuff,"DEBUG|%d\n",debug_val);
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
;ZigbeeRemoteIOV1.0.c,754 :: 		while(!hid_write(writebuff,64));
L_main266:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main267
	GOTO        L_main266
L_main267:
;ZigbeeRemoteIOV1.0.c,755 :: 		}
L_main265:
;ZigbeeRemoteIOV1.0.c,756 :: 		}
	GOTO        L_main268
L_main264:
;ZigbeeRemoteIOV1.0.c,757 :: 		else if(strcmp(CommandTrimmed[0],"SEND")==0){
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
	GOTO        L__main437
	MOVLW       0
	XORWF       R0, 0 
L__main437:
	BTFSS       STATUS+0, 2 
	GOTO        L_main269
;ZigbeeRemoteIOV1.0.c,758 :: 		SendDataPacket(0,CommandTrimmed[1],strlen(CommandTrimmed[1]),0);
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SendDataPacket_len+0 
	MOVF        R1, 0 
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_broadcast+0 
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,760 :: 		}
	GOTO        L_main270
L_main269:
;ZigbeeRemoteIOV1.0.c,761 :: 		else if(strcmp(CommandTrimmed[0],"?")==0){
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
	GOTO        L__main438
	MOVLW       0
	XORWF       R0, 0 
L__main438:
	BTFSS       STATUS+0, 2 
	GOTO        L_main271
;ZigbeeRemoteIOV1.0.c,763 :: 		sprinti(writebuff,"KPP ZIGBEE BOARD V1.1\n");
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
;ZigbeeRemoteIOV1.0.c,764 :: 		while(!hid_write(writebuff,64));
L_main272:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main273
	GOTO        L_main272
L_main273:
;ZigbeeRemoteIOV1.0.c,765 :: 		}
	GOTO        L_main274
L_main271:
;ZigbeeRemoteIOV1.0.c,766 :: 		else if(strcmp(CommandTrimmed[0],"READ")==0){
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
	GOTO        L__main439
	MOVLW       0
	XORWF       R0, 0 
L__main439:
	BTFSS       STATUS+0, 2 
	GOTO        L_main275
;ZigbeeRemoteIOV1.0.c,768 :: 		}
	GOTO        L_main276
L_main275:
;ZigbeeRemoteIOV1.0.c,769 :: 		else if(strcmp(CommandTrimmed[0],"ZIGBEE")==0){
	MOVF        main_CommandTrimmed_L0+0, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+1, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr46_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr46_ZigbeeRemoteIOV1.0+0)
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
	GOTO        L_main277
;ZigbeeRemoteIOV1.0.c,771 :: 		if(strcmp(CommandTrimmed[1],"SET")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr47_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr47_ZigbeeRemoteIOV1.0+0)
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
	GOTO        L_main278
;ZigbeeRemoteIOV1.0.c,772 :: 		if(strcmp(CommandTrimmed[2],"DEVICE")==0){
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr48_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr48_ZigbeeRemoteIOV1.0+0)
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
	GOTO        L_main279
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
	GOTO        L__main443
	MOVF        R0, 0 
	SUBLW       0
L__main443:
	BTFSC       STATUS+0, 0 
	GOTO        L_main282
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
	GOTO        L_main282
L__main334:
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
	GOTO        L__main445
	MOVLW       0
	XORWF       R0, 0 
L__main445:
	BTFSC       STATUS+0, 2 
	GOTO        L__main333
	MOVLW       0
	XORWF       main_enabledval_L7+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main446
	MOVLW       1
	XORWF       main_enabledval_L7+0, 0 
L__main446:
	BTFSC       STATUS+0, 2 
	GOTO        L__main333
	GOTO        L_main285
L__main333:
;ZigbeeRemoteIOV1.0.c,779 :: 		write_eeprom_from(0x01+(devnum-1)*8,CommandTrimmed[4]);
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R4 
	MOVLW       3
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
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
;ZigbeeRemoteIOV1.0.c,780 :: 		write_eeprom_from(0x02+(devnum-1)*8,CommandTrimmed[5]);
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R4 
	MOVLW       3
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
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
;ZigbeeRemoteIOV1.0.c,781 :: 		read_eeprom_to(0x01+(devnum-1)*8,ZigbeeSendDevices[i].enabled);
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R4 
	MOVLW       3
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main451:
	BZ          L__main452
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main451
L__main452:
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_read_eeprom_to_startadress+1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
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
;ZigbeeRemoteIOV1.0.c,782 :: 		read_eeprom_to(0x02+(devnum-1)*8,ZigbeeSendDevices[i].Address);
	MOVLW       1
	SUBWF       main_devnum_L6+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      main_devnum_L6+1, 0 
	MOVWF       R4 
	MOVLW       3
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__main453:
	BZ          L__main454
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	ADDLW       255
	GOTO        L__main453
L__main454:
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FARG_read_eeprom_to_startadress+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FARG_read_eeprom_to_startadress+1 
	MOVF        main_i_L0+0, 0 
	MOVWF       R0 
	MOVF        main_i_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
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
	MOVWF       FARG_read_eeprom_to_dest+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+1 
	CALL        _read_eeprom_to+0, 0
;ZigbeeRemoteIOV1.0.c,783 :: 		}
L_main285:
;ZigbeeRemoteIOV1.0.c,784 :: 		}
L_main282:
;ZigbeeRemoteIOV1.0.c,785 :: 		}
L_main279:
;ZigbeeRemoteIOV1.0.c,786 :: 		}
	GOTO        L_main286
L_main278:
;ZigbeeRemoteIOV1.0.c,788 :: 		else if(strcmp(CommandTrimmed[1],"GET")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr49_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr49_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main455
	MOVLW       0
	XORWF       R0, 0 
L__main455:
	BTFSS       STATUS+0, 2 
	GOTO        L_main287
;ZigbeeRemoteIOV1.0.c,789 :: 		if(strcmp(CommandTrimmed[2],"DEVICE")==0){
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr50_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr50_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcmp_s2+1 
	CALL        _strcmp+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main456
	MOVLW       0
	XORWF       R0, 0 
L__main456:
	BTFSS       STATUS+0, 2 
	GOTO        L_main288
;ZigbeeRemoteIOV1.0.c,790 :: 		int devnum=0;
	CLRF        main_devnum_L6_L6+0 
	CLRF        main_devnum_L6_L6+1 
;ZigbeeRemoteIOV1.0.c,791 :: 		devnum=atoi(CommandTrimmed[3]);
	MOVF        main_CommandTrimmed_L0+6, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+7, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVF        R0, 0 
	MOVWF       main_devnum_L6_L6+0 
	MOVF        R1, 0 
	MOVWF       main_devnum_L6_L6+1 
;ZigbeeRemoteIOV1.0.c,792 :: 		if(devnum>0 && devnum-1<ZIGBEEDEVICES){
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main457
	MOVF        R0, 0 
	SUBLW       0
L__main457:
	BTFSC       STATUS+0, 0 
	GOTO        L_main291
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
	GOTO        L__main458
	MOVLW       2
	SUBWF       R1, 0 
L__main458:
	BTFSC       STATUS+0, 0 
	GOTO        L_main291
L__main332:
;ZigbeeRemoteIOV1.0.c,793 :: 		int i,k=0;
	CLRF        main_k_L7+0 
	CLRF        main_k_L7+1 
;ZigbeeRemoteIOV1.0.c,796 :: 		for(i=0;i<8;i++){
	CLRF        main_i_L7+0 
	CLRF        main_i_L7+1 
L_main292:
	MOVLW       128
	XORWF       main_i_L7+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main459
	MOVLW       8
	SUBWF       main_i_L7+0, 0 
L__main459:
	BTFSC       STATUS+0, 0 
	GOTO        L_main293
;ZigbeeRemoteIOV1.0.c,797 :: 		ShortToHex(ZigbeeSendDevices[devnum-1].Address[i],HostZigbeeStr+k);
	MOVLW       1
	SUBWF       main_devnum_L6_L6+0, 0 
	MOVWF       R3 
	MOVLW       0
	SUBWFB      main_devnum_L6_L6+1, 0 
	MOVWF       R4 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
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
;ZigbeeRemoteIOV1.0.c,798 :: 		k=k+2;
	MOVLW       2
	ADDWF       main_k_L7+0, 1 
	MOVLW       0
	ADDWFC      main_k_L7+1, 1 
;ZigbeeRemoteIOV1.0.c,796 :: 		for(i=0;i<8;i++){
	INFSNZ      main_i_L7+0, 1 
	INCF        main_i_L7+1, 1 
;ZigbeeRemoteIOV1.0.c,799 :: 		}
	GOTO        L_main292
L_main293:
;ZigbeeRemoteIOV1.0.c,800 :: 		sprinti(writebuff,"ZIGBEE|DEVICE|%d|%s|%d\n",devnum,HostZigbeeStr,ZigbeeSendDevices[devnum-1].enabled);
	MOVLW       _writebuff+0
	MOVWF       FARG_sprinti_wh+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_sprinti_wh+1 
	MOVLW       ?lstr_51_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_sprinti_f+0 
	MOVLW       hi_addr(?lstr_51_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_sprinti_f+1 
	MOVLW       higher_addr(?lstr_51_ZigbeeRemoteIOV1.0+0)
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
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
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
;ZigbeeRemoteIOV1.0.c,801 :: 		while(!hid_write(writebuff,64));
L_main295:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main296
	GOTO        L_main295
L_main296:
;ZigbeeRemoteIOV1.0.c,802 :: 		}
L_main291:
;ZigbeeRemoteIOV1.0.c,803 :: 		}
L_main288:
;ZigbeeRemoteIOV1.0.c,804 :: 		}
	GOTO        L_main297
L_main287:
;ZigbeeRemoteIOV1.0.c,805 :: 		else if(strcmp(CommandTrimmed[1],"MY")==0){
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strcmp_s1+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strcmp_s1+1 
	MOVLW       ?lstr52_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcmp_s2+0 
	MOVLW       hi_addr(?lstr52_ZigbeeRemoteIOV1.0+0)
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
	GOTO        L_main298
;ZigbeeRemoteIOV1.0.c,806 :: 		SendRawPacket(MY1, 8);
	MOVLW       _MY1+0
	MOVWF       FARG_SendRawPacket_RawPacket+0 
	MOVLW       hi_addr(_MY1+0)
	MOVWF       FARG_SendRawPacket_RawPacket+1 
	MOVLW       8
	MOVWF       FARG_SendRawPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendRawPacket_len+1 
	CALL        _SendRawPacket+0, 0
;ZigbeeRemoteIOV1.0.c,807 :: 		}
L_main298:
L_main297:
L_main286:
;ZigbeeRemoteIOV1.0.c,808 :: 		}
L_main277:
L_main276:
L_main274:
L_main270:
L_main268:
L_main263:
;ZigbeeRemoteIOV1.0.c,810 :: 		}
L_main255:
;ZigbeeRemoteIOV1.0.c,812 :: 		}
L_main254:
;ZigbeeRemoteIOV1.0.c,814 :: 		}
	GOTO        L_main251
;ZigbeeRemoteIOV1.0.c,816 :: 		Delay_ms(1);
L_main299:
	DECFSZ      R13, 1, 1
	BRA         L_main299
	DECFSZ      R12, 1, 1
	BRA         L_main299
	NOP
;ZigbeeRemoteIOV1.0.c,818 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
