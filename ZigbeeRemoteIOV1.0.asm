
_DeleteChar:

;ZigbeeRemoteIOV1.0.c,51 :: 		char *DeleteChar (char *str, char oldChar) {
;ZigbeeRemoteIOV1.0.c,52 :: 		char *strPtr = str;
	MOVF        FARG_DeleteChar_str+0, 0 
	MOVWF       DeleteChar_strPtr_L0+0 
	MOVF        FARG_DeleteChar_str+1, 0 
	MOVWF       DeleteChar_strPtr_L0+1 
;ZigbeeRemoteIOV1.0.c,53 :: 		while ((strPtr = strchr (strPtr, oldChar)) != 0)
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
	GOTO        L__DeleteChar303
	MOVLW       0
	XORWF       R0, 0 
L__DeleteChar303:
	BTFSC       STATUS+0, 2 
	GOTO        L_DeleteChar1
;ZigbeeRemoteIOV1.0.c,54 :: 		*strPtr++ = '\0';
	MOVFF       DeleteChar_strPtr_L0+0, FSR1
	MOVFF       DeleteChar_strPtr_L0+1, FSR1H
	CLRF        POSTINC1+0 
	INFSNZ      DeleteChar_strPtr_L0+0, 1 
	INCF        DeleteChar_strPtr_L0+1, 1 
	GOTO        L_DeleteChar0
L_DeleteChar1:
;ZigbeeRemoteIOV1.0.c,55 :: 		return str;
	MOVF        FARG_DeleteChar_str+0, 0 
	MOVWF       R0 
	MOVF        FARG_DeleteChar_str+1, 0 
	MOVWF       R1 
;ZigbeeRemoteIOV1.0.c,56 :: 		}
L_end_DeleteChar:
	RETURN      0
; end of _DeleteChar

_SendRawPacket:

;ZigbeeRemoteIOV1.0.c,60 :: 		void SendRawPacket(char* RawPacket,int len)
;ZigbeeRemoteIOV1.0.c,64 :: 		for( i=0; i<len; i++ )
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
	GOTO        L__SendRawPacket305
	MOVF        FARG_SendRawPacket_len+0, 0 
	SUBWF       SendRawPacket_i_L0+0, 0 
L__SendRawPacket305:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendRawPacket3
;ZigbeeRemoteIOV1.0.c,66 :: 		UART1_Write( RawPacket[i]);
	MOVF        SendRawPacket_i_L0+0, 0 
	ADDWF       FARG_SendRawPacket_RawPacket+0, 0 
	MOVWF       FSR0 
	MOVF        SendRawPacket_i_L0+1, 0 
	ADDWFC      FARG_SendRawPacket_RawPacket+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ZigbeeRemoteIOV1.0.c,64 :: 		for( i=0; i<len; i++ )
	INFSNZ      SendRawPacket_i_L0+0, 1 
	INCF        SendRawPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,67 :: 		}
	GOTO        L_SendRawPacket2
L_SendRawPacket3:
;ZigbeeRemoteIOV1.0.c,69 :: 		}
L_end_SendRawPacket:
	RETURN      0
; end of _SendRawPacket

_SendDataPacket:

;ZigbeeRemoteIOV1.0.c,71 :: 		void SendDataPacket(char *toadress,char* DataPacket,int len,char Ack)
;ZigbeeRemoteIOV1.0.c,73 :: 		int i, framesize2=14+len;
	MOVLW       14
	ADDWF       FARG_SendDataPacket_len+0, 0 
	MOVWF       SendDataPacket_framesize2_L0+0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_len+1, 0 
	MOVWF       SendDataPacket_framesize2_L0+1 
;ZigbeeRemoteIOV1.0.c,75 :: 		unsigned short checkSum=0;
	CLRF        SendDataPacket_checkSum_L0+0 
;ZigbeeRemoteIOV1.0.c,79 :: 		DataToSend[0]=0x7E;
	MOVLW       126
	MOVWF       SendDataPacket_DataToSend_L0+0 
;ZigbeeRemoteIOV1.0.c,80 :: 		DataToSend[1]=0x00;
	CLRF        SendDataPacket_DataToSend_L0+1 
;ZigbeeRemoteIOV1.0.c,82 :: 		DataToSend[2]=framesize2;
	MOVF        SendDataPacket_framesize2_L0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+2 
;ZigbeeRemoteIOV1.0.c,83 :: 		DataToSend[3]=0x10;
	MOVLW       16
	MOVWF       SendDataPacket_DataToSend_L0+3 
;ZigbeeRemoteIOV1.0.c,84 :: 		DataToSend[4]=0x01;
	MOVLW       1
	MOVWF       SendDataPacket_DataToSend_L0+4 
;ZigbeeRemoteIOV1.0.c,87 :: 		if( toadress==0 )
	MOVLW       0
	XORWF       FARG_SendDataPacket_toadress+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket307
	MOVLW       0
	XORWF       FARG_SendDataPacket_toadress+0, 0 
L__SendDataPacket307:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket5
;ZigbeeRemoteIOV1.0.c,90 :: 		DataToSend[5]=0;
	CLRF        SendDataPacket_DataToSend_L0+5 
;ZigbeeRemoteIOV1.0.c,91 :: 		DataToSend[6]=0;
	CLRF        SendDataPacket_DataToSend_L0+6 
;ZigbeeRemoteIOV1.0.c,92 :: 		DataToSend[7]=0;
	CLRF        SendDataPacket_DataToSend_L0+7 
;ZigbeeRemoteIOV1.0.c,93 :: 		DataToSend[8]=0;
	CLRF        SendDataPacket_DataToSend_L0+8 
;ZigbeeRemoteIOV1.0.c,94 :: 		DataToSend[9]=0;
	CLRF        SendDataPacket_DataToSend_L0+9 
;ZigbeeRemoteIOV1.0.c,95 :: 		DataToSend[10]=0;
	CLRF        SendDataPacket_DataToSend_L0+10 
;ZigbeeRemoteIOV1.0.c,96 :: 		DataToSend[11]=0;
	CLRF        SendDataPacket_DataToSend_L0+11 
;ZigbeeRemoteIOV1.0.c,97 :: 		DataToSend[12]=0;
	CLRF        SendDataPacket_DataToSend_L0+12 
;ZigbeeRemoteIOV1.0.c,98 :: 		}
	GOTO        L_SendDataPacket6
L_SendDataPacket5:
;ZigbeeRemoteIOV1.0.c,104 :: 		DataToSend[5]=toadress[0];
	MOVFF       FARG_SendDataPacket_toadress+0, FSR0
	MOVFF       FARG_SendDataPacket_toadress+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+5 
;ZigbeeRemoteIOV1.0.c,105 :: 		DataToSend[6]=toadress[1];
	MOVLW       1
	ADDWF       FARG_SendDataPacket_toadress+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_toadress+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+6 
;ZigbeeRemoteIOV1.0.c,106 :: 		DataToSend[7]=toadress[2];
	MOVLW       2
	ADDWF       FARG_SendDataPacket_toadress+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_toadress+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+7 
;ZigbeeRemoteIOV1.0.c,107 :: 		DataToSend[8]=toadress[3];
	MOVLW       3
	ADDWF       FARG_SendDataPacket_toadress+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_toadress+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+8 
;ZigbeeRemoteIOV1.0.c,108 :: 		DataToSend[9]=toadress[4];
	MOVLW       4
	ADDWF       FARG_SendDataPacket_toadress+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_toadress+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+9 
;ZigbeeRemoteIOV1.0.c,109 :: 		DataToSend[10]=toadress[5];
	MOVLW       5
	ADDWF       FARG_SendDataPacket_toadress+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_toadress+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+10 
;ZigbeeRemoteIOV1.0.c,110 :: 		DataToSend[11]=toadress[6];
	MOVLW       6
	ADDWF       FARG_SendDataPacket_toadress+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_toadress+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+11 
;ZigbeeRemoteIOV1.0.c,111 :: 		DataToSend[12]=toadress[7];
	MOVLW       7
	ADDWF       FARG_SendDataPacket_toadress+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_SendDataPacket_toadress+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       SendDataPacket_DataToSend_L0+12 
;ZigbeeRemoteIOV1.0.c,113 :: 		}
L_SendDataPacket6:
;ZigbeeRemoteIOV1.0.c,118 :: 		DataToSend[13]=0xFF;
	MOVLW       255
	MOVWF       SendDataPacket_DataToSend_L0+13 
;ZigbeeRemoteIOV1.0.c,119 :: 		DataToSend[14]=0xFE;
	MOVLW       254
	MOVWF       SendDataPacket_DataToSend_L0+14 
;ZigbeeRemoteIOV1.0.c,122 :: 		DataToSend[15]=0x00;
	CLRF        SendDataPacket_DataToSend_L0+15 
;ZigbeeRemoteIOV1.0.c,125 :: 		DataToSend[16]=0x01;
	MOVLW       1
	MOVWF       SendDataPacket_DataToSend_L0+16 
;ZigbeeRemoteIOV1.0.c,128 :: 		for( i=17; i<17+len; i++ )
	MOVLW       17
	MOVWF       SendDataPacket_i_L0+0 
	MOVLW       0
	MOVWF       SendDataPacket_i_L0+1 
L_SendDataPacket7:
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
	GOTO        L__SendDataPacket308
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket308:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket8
;ZigbeeRemoteIOV1.0.c,130 :: 		DataToSend[i]=DataPacket[i-17];
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
;ZigbeeRemoteIOV1.0.c,128 :: 		for( i=17; i<17+len; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,131 :: 		}
	GOTO        L_SendDataPacket7
L_SendDataPacket8:
;ZigbeeRemoteIOV1.0.c,134 :: 		for( i=3; i<framesize2+3; i++ )
	MOVLW       3
	MOVWF       SendDataPacket_i_L0+0 
	MOVLW       0
	MOVWF       SendDataPacket_i_L0+1 
L_SendDataPacket10:
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
	GOTO        L__SendDataPacket309
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket309:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket11
;ZigbeeRemoteIOV1.0.c,136 :: 		checkSum=checkSum+DataToSend[i];
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       SendDataPacket_checkSum_L0+0, 1 
;ZigbeeRemoteIOV1.0.c,134 :: 		for( i=3; i<framesize2+3; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,137 :: 		}
	GOTO        L_SendDataPacket10
L_SendDataPacket11:
;ZigbeeRemoteIOV1.0.c,139 :: 		checkSum=0xFF-checkSum;
	MOVF        SendDataPacket_checkSum_L0+0, 0 
	SUBLW       255
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       SendDataPacket_checkSum_L0+0 
;ZigbeeRemoteIOV1.0.c,142 :: 		DataToSend[i]=checkSum;
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,143 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket310
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket310:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket15
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket15
L__SendDataPacket273:
;ZigbeeRemoteIOV1.0.c,144 :: 		sprinti(writebuff,"Packet: ");
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
;ZigbeeRemoteIOV1.0.c,145 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket16:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket17
	GOTO        L_SendDataPacket16
L_SendDataPacket17:
;ZigbeeRemoteIOV1.0.c,146 :: 		}
L_SendDataPacket15:
;ZigbeeRemoteIOV1.0.c,148 :: 		for( i=0; i<framesize2+4; i++ )
	CLRF        SendDataPacket_i_L0+0 
	CLRF        SendDataPacket_i_L0+1 
L_SendDataPacket18:
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
	GOTO        L__SendDataPacket311
	MOVF        R1, 0 
	SUBWF       SendDataPacket_i_L0+0, 0 
L__SendDataPacket311:
	BTFSC       STATUS+0, 0 
	GOTO        L_SendDataPacket19
;ZigbeeRemoteIOV1.0.c,150 :: 		UART1_Write( DataToSend[i]);
	MOVLW       SendDataPacket_DataToSend_L0+0
	ADDWF       SendDataPacket_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(SendDataPacket_DataToSend_L0+0)
	ADDWFC      SendDataPacket_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ZigbeeRemoteIOV1.0.c,151 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket312
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket312:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket23
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket23
L__SendDataPacket272:
;ZigbeeRemoteIOV1.0.c,152 :: 		sprinti(writebuff,"%X",DataToSend[i]);
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
;ZigbeeRemoteIOV1.0.c,153 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket24:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket25
	GOTO        L_SendDataPacket24
L_SendDataPacket25:
;ZigbeeRemoteIOV1.0.c,154 :: 		}
L_SendDataPacket23:
;ZigbeeRemoteIOV1.0.c,148 :: 		for( i=0; i<framesize2+4; i++ )
	INFSNZ      SendDataPacket_i_L0+0, 1 
	INCF        SendDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,155 :: 		}
	GOTO        L_SendDataPacket18
L_SendDataPacket19:
;ZigbeeRemoteIOV1.0.c,156 :: 		if(debug==1 && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SendDataPacket313
	MOVLW       1
	XORWF       _debug+0, 0 
L__SendDataPacket313:
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket28
	BTFSS       PORTB+0, 4 
	GOTO        L_SendDataPacket28
L__SendDataPacket271:
;ZigbeeRemoteIOV1.0.c,157 :: 		sprinti(writebuff,"\n");
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
;ZigbeeRemoteIOV1.0.c,158 :: 		while(!hid_write(writebuff,64));
L_SendDataPacket29:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SendDataPacket30
	GOTO        L_SendDataPacket29
L_SendDataPacket30:
;ZigbeeRemoteIOV1.0.c,159 :: 		}
L_SendDataPacket28:
;ZigbeeRemoteIOV1.0.c,161 :: 		}
L_end_SendDataPacket:
	RETURN      0
; end of _SendDataPacket

_ProcessZigBeeDataPacket:

;ZigbeeRemoteIOV1.0.c,163 :: 		void ProcessZigBeeDataPacket(char* DataPacket,char *DevIP)
;ZigbeeRemoteIOV1.0.c,167 :: 		char del[2] = "|";
	MOVLW       124
	MOVWF       ProcessZigBeeDataPacket_del_L0+0 
	CLRF        ProcessZigBeeDataPacket_del_L0+1 
	CLRF        ProcessZigBeeDataPacket_i_L0+0 
	CLRF        ProcessZigBeeDataPacket_i_L0+1 
;ZigbeeRemoteIOV1.0.c,171 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket315
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeDataPacket315:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket275
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket316
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeDataPacket316:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeDataPacket275
	GOTO        L_ProcessZigBeeDataPacket35
L__ProcessZigBeeDataPacket275:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeDataPacket35
L__ProcessZigBeeDataPacket274:
;ZigbeeRemoteIOV1.0.c,172 :: 		sprinti(writebuff, "ZIGBEE|%s\n",DataPacket);
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
;ZigbeeRemoteIOV1.0.c,173 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeDataPacket36:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket37
	GOTO        L_ProcessZigBeeDataPacket36
L_ProcessZigBeeDataPacket37:
;ZigbeeRemoteIOV1.0.c,174 :: 		}
L_ProcessZigBeeDataPacket35:
;ZigbeeRemoteIOV1.0.c,177 :: 		CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(DataPacket,'\r'),'\n'), del);
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
;ZigbeeRemoteIOV1.0.c,180 :: 		do
L_ProcessZigBeeDataPacket38:
;ZigbeeRemoteIOV1.0.c,183 :: 		i++;
	INFSNZ      ProcessZigBeeDataPacket_i_L0+0, 1 
	INCF        ProcessZigBeeDataPacket_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,184 :: 		CommandTrimmed[i] = strtok(0, del);
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
;ZigbeeRemoteIOV1.0.c,187 :: 		while( CommandTrimmed[i] != 0 );
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
	GOTO        L__ProcessZigBeeDataPacket317
	MOVLW       0
	XORWF       R1, 0 
L__ProcessZigBeeDataPacket317:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket38
;ZigbeeRemoteIOV1.0.c,193 :: 		if(strcmp(CommandTrimmed[0],"OUT")==0){
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
	GOTO        L__ProcessZigBeeDataPacket318
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket318:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket41
;ZigbeeRemoteIOV1.0.c,194 :: 		if(strcmp(CommandTrimmed[1],"1")==0){
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
	GOTO        L__ProcessZigBeeDataPacket319
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket319:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket42
;ZigbeeRemoteIOV1.0.c,195 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket320
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket320:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket43
;ZigbeeRemoteIOV1.0.c,196 :: 		PICOUT1=1;
	BSF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,197 :: 		}
	GOTO        L_ProcessZigBeeDataPacket44
L_ProcessZigBeeDataPacket43:
;ZigbeeRemoteIOV1.0.c,198 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
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
	GOTO        L__ProcessZigBeeDataPacket321
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket321:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket45
;ZigbeeRemoteIOV1.0.c,199 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,200 :: 		}
L_ProcessZigBeeDataPacket45:
L_ProcessZigBeeDataPacket44:
;ZigbeeRemoteIOV1.0.c,201 :: 		}
	GOTO        L_ProcessZigBeeDataPacket46
L_ProcessZigBeeDataPacket42:
;ZigbeeRemoteIOV1.0.c,202 :: 		else  if(strcmp(CommandTrimmed[1],"2")==0){
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
	GOTO        L__ProcessZigBeeDataPacket322
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket322:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket47
;ZigbeeRemoteIOV1.0.c,203 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket323
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket323:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket48
;ZigbeeRemoteIOV1.0.c,204 :: 		PICOUT2=1;
	BSF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,205 :: 		}
	GOTO        L_ProcessZigBeeDataPacket49
L_ProcessZigBeeDataPacket48:
;ZigbeeRemoteIOV1.0.c,206 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
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
	GOTO        L__ProcessZigBeeDataPacket324
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket324:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket50
;ZigbeeRemoteIOV1.0.c,207 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,208 :: 		}
L_ProcessZigBeeDataPacket50:
L_ProcessZigBeeDataPacket49:
;ZigbeeRemoteIOV1.0.c,209 :: 		}
	GOTO        L_ProcessZigBeeDataPacket51
L_ProcessZigBeeDataPacket47:
;ZigbeeRemoteIOV1.0.c,210 :: 		else if(strcmp(CommandTrimmed[1],"3")==0){
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
	GOTO        L__ProcessZigBeeDataPacket325
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket325:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket52
;ZigbeeRemoteIOV1.0.c,211 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket326
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket326:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket53
;ZigbeeRemoteIOV1.0.c,212 :: 		PICOUT3=1;
	BSF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,213 :: 		}
	GOTO        L_ProcessZigBeeDataPacket54
L_ProcessZigBeeDataPacket53:
;ZigbeeRemoteIOV1.0.c,214 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
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
	GOTO        L__ProcessZigBeeDataPacket327
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket327:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket55
;ZigbeeRemoteIOV1.0.c,215 :: 		PICOUT3=0;
	BCF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,216 :: 		}
L_ProcessZigBeeDataPacket55:
L_ProcessZigBeeDataPacket54:
;ZigbeeRemoteIOV1.0.c,217 :: 		}
	GOTO        L_ProcessZigBeeDataPacket56
L_ProcessZigBeeDataPacket52:
;ZigbeeRemoteIOV1.0.c,218 :: 		else if(strcmp(CommandTrimmed[1],"4")==0){
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
	GOTO        L__ProcessZigBeeDataPacket328
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket328:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket57
;ZigbeeRemoteIOV1.0.c,219 :: 		if(strcmp(CommandTrimmed[2],"ON")==0){
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
	GOTO        L__ProcessZigBeeDataPacket329
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket329:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket58
;ZigbeeRemoteIOV1.0.c,220 :: 		PICOUT4=1;
	BSF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,221 :: 		}
	GOTO        L_ProcessZigBeeDataPacket59
L_ProcessZigBeeDataPacket58:
;ZigbeeRemoteIOV1.0.c,222 :: 		else if(strcmp(CommandTrimmed[2],"OFF")==0){
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
	GOTO        L__ProcessZigBeeDataPacket330
	MOVLW       0
	XORWF       R0, 0 
L__ProcessZigBeeDataPacket330:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeDataPacket60
;ZigbeeRemoteIOV1.0.c,223 :: 		PICOUT4=0;
	BCF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,224 :: 		}
L_ProcessZigBeeDataPacket60:
L_ProcessZigBeeDataPacket59:
;ZigbeeRemoteIOV1.0.c,225 :: 		}
L_ProcessZigBeeDataPacket57:
L_ProcessZigBeeDataPacket56:
L_ProcessZigBeeDataPacket51:
L_ProcessZigBeeDataPacket46:
;ZigbeeRemoteIOV1.0.c,226 :: 		}
L_ProcessZigBeeDataPacket41:
;ZigbeeRemoteIOV1.0.c,230 :: 		}
L_end_ProcessZigBeeDataPacket:
	RETURN      0
; end of _ProcessZigBeeDataPacket

_ProcessZigBeeFrame:

;ZigbeeRemoteIOV1.0.c,234 :: 		void ProcessZigBeeFrame()
;ZigbeeRemoteIOV1.0.c,237 :: 		int FrameType=0;
	CLRF        ProcessZigBeeFrame_FrameType_L0+0 
	CLRF        ProcessZigBeeFrame_FrameType_L0+1 
	CLRF        ProcessZigBeeFrame_ATCommand_L0+0 
	CLRF        ProcessZigBeeFrame_ATCommand_L0+1 
;ZigbeeRemoteIOV1.0.c,252 :: 		FrameType=ZigbeeFrame[3];
	MOVF        _ZigbeeFrame+3, 0 
	MOVWF       ProcessZigBeeFrame_FrameType_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_FrameType_L0+1 
;ZigbeeRemoteIOV1.0.c,255 :: 		if( FrameType==0x90 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame332
	MOVLW       144
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame332:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame61
;ZigbeeRemoteIOV1.0.c,258 :: 		for( i=4; i<=11; i++ )
	MOVLW       4
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame62:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame333
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBLW       11
L__ProcessZigBeeFrame333:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame63
;ZigbeeRemoteIOV1.0.c,261 :: 		SenderMac[i-4]=ZigbeeFrame [ i ];
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
;ZigbeeRemoteIOV1.0.c,258 :: 		for( i=4; i<=11; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,262 :: 		}
	GOTO        L_ProcessZigBeeFrame62
L_ProcessZigBeeFrame63:
;ZigbeeRemoteIOV1.0.c,265 :: 		for( i=12; i<=13; i++ )
	MOVLW       12
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame65:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame334
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBLW       13
L__ProcessZigBeeFrame334:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame66
;ZigbeeRemoteIOV1.0.c,268 :: 		SenderAddress[i-12]=ZigbeeFrame[ i ];
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
;ZigbeeRemoteIOV1.0.c,265 :: 		for( i=12; i<=13; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,269 :: 		}
	GOTO        L_ProcessZigBeeFrame65
L_ProcessZigBeeFrame66:
;ZigbeeRemoteIOV1.0.c,271 :: 		SenderAddress[i-12]='\0';
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
;ZigbeeRemoteIOV1.0.c,272 :: 		for( i=15; i<=framesize+2; i++ )
	MOVLW       15
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame68:
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
	GOTO        L__ProcessZigBeeFrame335
	MOVF        ProcessZigBeeFrame_i_L0+0, 0 
	SUBWF       R1, 0 
L__ProcessZigBeeFrame335:
	BTFSS       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame69
;ZigbeeRemoteIOV1.0.c,275 :: 		ZigbeeDataPacket[i-15]=ZigbeeFrame[ i ];
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
;ZigbeeRemoteIOV1.0.c,272 :: 		for( i=15; i<=framesize+2; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,276 :: 		}
	GOTO        L_ProcessZigBeeFrame68
L_ProcessZigBeeFrame69:
;ZigbeeRemoteIOV1.0.c,278 :: 		ZigbeeDataPacket[i-15]='\0';
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
;ZigbeeRemoteIOV1.0.c,280 :: 		ProcessZigBeeDataPacket( ZigbeeDataPacket, SenderAddress );
	MOVLW       ProcessZigBeeFrame_ZigbeeDataPacket_L0+0
	MOVWF       FARG_ProcessZigBeeDataPacket_DataPacket+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_ZigbeeDataPacket_L0+0)
	MOVWF       FARG_ProcessZigBeeDataPacket_DataPacket+1 
	MOVLW       ProcessZigBeeFrame_SenderAddress_L0+0
	MOVWF       FARG_ProcessZigBeeDataPacket_DevIP+0 
	MOVLW       hi_addr(ProcessZigBeeFrame_SenderAddress_L0+0)
	MOVWF       FARG_ProcessZigBeeDataPacket_DevIP+1 
	CALL        _ProcessZigBeeDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,281 :: 		}
	GOTO        L_ProcessZigBeeFrame71
L_ProcessZigBeeFrame61:
;ZigbeeRemoteIOV1.0.c,284 :: 		else if( FrameType==0x95 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame336
	MOVLW       149
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame336:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame72
;ZigbeeRemoteIOV1.0.c,287 :: 		DeviceAdress[0]=ZigbeeFrame [12];
	MOVF        _ZigbeeFrame+12, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+0 
;ZigbeeRemoteIOV1.0.c,288 :: 		DeviceAdress[1]=ZigbeeFrame [13];
	MOVF        _ZigbeeFrame+13, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+1 
;ZigbeeRemoteIOV1.0.c,290 :: 		for( i=4; i<12; i++ )
	MOVLW       4
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame73:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame337
	MOVLW       12
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame337:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame74
;ZigbeeRemoteIOV1.0.c,292 :: 		DeviceMAC[i-4]=ZigbeeFrame[i];
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
;ZigbeeRemoteIOV1.0.c,290 :: 		for( i=4; i<12; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,293 :: 		}
	GOTO        L_ProcessZigBeeFrame73
L_ProcessZigBeeFrame74:
;ZigbeeRemoteIOV1.0.c,296 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	CLRF        ProcessZigBeeFrame_i_L0+0 
	CLRF        ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame76:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame338
	MOVLW       16
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame338:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame77
;ZigbeeRemoteIOV1.0.c,298 :: 		DeviceID[i]=ZigbeeFrame[i+26];
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
;ZigbeeRemoteIOV1.0.c,299 :: 		if( DeviceID[i]==0x00 )break;
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame79
	GOTO        L_ProcessZigBeeFrame77
L_ProcessZigBeeFrame79:
;ZigbeeRemoteIOV1.0.c,296 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,300 :: 		}
	GOTO        L_ProcessZigBeeFrame76
L_ProcessZigBeeFrame77:
;ZigbeeRemoteIOV1.0.c,302 :: 		}
	GOTO        L_ProcessZigBeeFrame80
L_ProcessZigBeeFrame72:
;ZigbeeRemoteIOV1.0.c,305 :: 		else if( FrameType==0x88 )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame339
	MOVLW       136
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame339:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame81
;ZigbeeRemoteIOV1.0.c,313 :: 		ATCommand[0]=ZigbeeFrame [ 5 ];
	MOVF        _ZigbeeFrame+5, 0 
	MOVWF       ProcessZigBeeFrame_ATCommand_L0+0 
;ZigbeeRemoteIOV1.0.c,314 :: 		ATCommand[1]=ZigbeeFrame [ 6 ];
	MOVF        _ZigbeeFrame+6, 0 
	MOVWF       ProcessZigBeeFrame_ATCommand_L0+1 
;ZigbeeRemoteIOV1.0.c,317 :: 		if( ZigbeeFrame [7]==0x00 )
	MOVF        _ZigbeeFrame+7, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame82
;ZigbeeRemoteIOV1.0.c,320 :: 		if( ATCommand[0]=='N'&&ATCommand[1]=='D' )
	MOVF        ProcessZigBeeFrame_ATCommand_L0+0, 0 
	XORLW       78
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame85
	MOVF        ProcessZigBeeFrame_ATCommand_L0+1, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame85
L__ProcessZigBeeFrame292:
;ZigbeeRemoteIOV1.0.c,322 :: 		DeviceAdress[0]=ZigbeeFrame [8];
	MOVF        _ZigbeeFrame+8, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+0 
;ZigbeeRemoteIOV1.0.c,323 :: 		DeviceAdress[1]=ZigbeeFrame [9];
	MOVF        _ZigbeeFrame+9, 0 
	MOVWF       ProcessZigBeeFrame_DeviceAdress_L0+1 
;ZigbeeRemoteIOV1.0.c,325 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame340
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame340:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame86
;ZigbeeRemoteIOV1.0.c,326 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,327 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame341
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame341:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame291
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame342
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame342:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame291
	GOTO        L_ProcessZigBeeFrame91
L__ProcessZigBeeFrame291:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame91
L__ProcessZigBeeFrame290:
;ZigbeeRemoteIOV1.0.c,328 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr18_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr18_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,329 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame92:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame93
	GOTO        L_ProcessZigBeeFrame92
L_ProcessZigBeeFrame93:
;ZigbeeRemoteIOV1.0.c,330 :: 		}
L_ProcessZigBeeFrame91:
;ZigbeeRemoteIOV1.0.c,331 :: 		}
L_ProcessZigBeeFrame86:
;ZigbeeRemoteIOV1.0.c,333 :: 		for( i=10; i<18; i++ )
	MOVLW       10
	MOVWF       ProcessZigBeeFrame_i_L0+0 
	MOVLW       0
	MOVWF       ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame94:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame343
	MOVLW       18
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame343:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame95
;ZigbeeRemoteIOV1.0.c,335 :: 		DeviceMAC[i-10]=ZigbeeFrame[i];
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
;ZigbeeRemoteIOV1.0.c,333 :: 		for( i=10; i<18; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,336 :: 		}
	GOTO        L_ProcessZigBeeFrame94
L_ProcessZigBeeFrame95:
;ZigbeeRemoteIOV1.0.c,341 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	CLRF        ProcessZigBeeFrame_i_L0+0 
	CLRF        ProcessZigBeeFrame_i_L0+1 
L_ProcessZigBeeFrame97:
	MOVLW       128
	XORWF       ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame344
	MOVLW       16
	SUBWF       ProcessZigBeeFrame_i_L0+0, 0 
L__ProcessZigBeeFrame344:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame98
;ZigbeeRemoteIOV1.0.c,343 :: 		DeviceID[i]=ZigbeeFrame[i+19];
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
;ZigbeeRemoteIOV1.0.c,344 :: 		if( DeviceID[i]==0x00 )break;
	MOVLW       ProcessZigBeeFrame_DeviceID_L0+0
	ADDWF       ProcessZigBeeFrame_i_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(ProcessZigBeeFrame_DeviceID_L0+0)
	ADDWFC      ProcessZigBeeFrame_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame100
	GOTO        L_ProcessZigBeeFrame98
L_ProcessZigBeeFrame100:
;ZigbeeRemoteIOV1.0.c,341 :: 		for( i=0; i<MAXZIGBEEID; i++ )
	INFSNZ      ProcessZigBeeFrame_i_L0+0, 1 
	INCF        ProcessZigBeeFrame_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,345 :: 		}
	GOTO        L_ProcessZigBeeFrame97
L_ProcessZigBeeFrame98:
;ZigbeeRemoteIOV1.0.c,349 :: 		}else if( ATCommand[0]=='M'&&ATCommand[1]=='Y' ){
	GOTO        L_ProcessZigBeeFrame101
L_ProcessZigBeeFrame85:
	MOVF        ProcessZigBeeFrame_ATCommand_L0+0, 0 
	XORLW       77
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame104
	MOVF        ProcessZigBeeFrame_ATCommand_L0+1, 0 
	XORLW       89
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame104
L__ProcessZigBeeFrame289:
;ZigbeeRemoteIOV1.0.c,350 :: 		LocalIP[0]=ZigbeeFrame [8];
	MOVF        _ZigbeeFrame+8, 0 
	MOVWF       _LocalIP+0 
;ZigbeeRemoteIOV1.0.c,351 :: 		LocalIP[1]=ZigbeeFrame [9];
	MOVF        _ZigbeeFrame+9, 0 
	MOVWF       _LocalIP+1 
;ZigbeeRemoteIOV1.0.c,353 :: 		if( LocalIP[0]!=0xFF&&LocalIP[1]!=0xFE )
	MOVF        _LocalIP+0, 0 
	XORLW       255
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame107
	MOVF        _LocalIP+1, 0 
	XORLW       254
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame107
L__ProcessZigBeeFrame288:
;ZigbeeRemoteIOV1.0.c,356 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,357 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame345
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame345:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame287
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame346
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame346:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame287
	GOTO        L_ProcessZigBeeFrame112
L__ProcessZigBeeFrame287:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame112
L__ProcessZigBeeFrame286:
;ZigbeeRemoteIOV1.0.c,358 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr19_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr19_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,359 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame113:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame114
	GOTO        L_ProcessZigBeeFrame113
L_ProcessZigBeeFrame114:
;ZigbeeRemoteIOV1.0.c,360 :: 		}
L_ProcessZigBeeFrame112:
;ZigbeeRemoteIOV1.0.c,362 :: 		}
	GOTO        L_ProcessZigBeeFrame115
L_ProcessZigBeeFrame107:
;ZigbeeRemoteIOV1.0.c,366 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,368 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame347
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame347:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame285
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame348
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame348:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame285
	GOTO        L_ProcessZigBeeFrame120
L__ProcessZigBeeFrame285:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame120
L__ProcessZigBeeFrame284:
;ZigbeeRemoteIOV1.0.c,369 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK\n");
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
;ZigbeeRemoteIOV1.0.c,370 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,371 :: 		}
L_ProcessZigBeeFrame120:
;ZigbeeRemoteIOV1.0.c,373 :: 		}
L_ProcessZigBeeFrame115:
;ZigbeeRemoteIOV1.0.c,374 :: 		}
L_ProcessZigBeeFrame104:
L_ProcessZigBeeFrame101:
;ZigbeeRemoteIOV1.0.c,375 :: 		}
L_ProcessZigBeeFrame82:
;ZigbeeRemoteIOV1.0.c,376 :: 		}
	GOTO        L_ProcessZigBeeFrame123
L_ProcessZigBeeFrame81:
;ZigbeeRemoteIOV1.0.c,378 :: 		else if( FrameType==0x8A )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame349
	MOVLW       138
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame349:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame124
;ZigbeeRemoteIOV1.0.c,382 :: 		if( ZigbeeFrame[4]==0x03 )
	MOVF        _ZigbeeFrame+4, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame125
;ZigbeeRemoteIOV1.0.c,385 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame350
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame350:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame283
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame351
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame351:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame283
	GOTO        L_ProcessZigBeeFrame130
L__ProcessZigBeeFrame283:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame130
L__ProcessZigBeeFrame282:
;ZigbeeRemoteIOV1.0.c,386 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK\n");
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
;ZigbeeRemoteIOV1.0.c,387 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame131:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame132
	GOTO        L_ProcessZigBeeFrame131
L_ProcessZigBeeFrame132:
;ZigbeeRemoteIOV1.0.c,388 :: 		}
L_ProcessZigBeeFrame130:
;ZigbeeRemoteIOV1.0.c,389 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,390 :: 		}
	GOTO        L_ProcessZigBeeFrame133
L_ProcessZigBeeFrame125:
;ZigbeeRemoteIOV1.0.c,393 :: 		else if( ZigbeeFrame[4]==0x02 )
	MOVF        _ZigbeeFrame+4, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame134
;ZigbeeRemoteIOV1.0.c,397 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame352
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame352:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame135
;ZigbeeRemoteIOV1.0.c,398 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,400 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame353
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame353:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame281
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame354
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame354:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame281
	GOTO        L_ProcessZigBeeFrame140
L__ProcessZigBeeFrame281:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame140
L__ProcessZigBeeFrame280:
;ZigbeeRemoteIOV1.0.c,401 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr22_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr22_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,402 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame141:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame142
	GOTO        L_ProcessZigBeeFrame141
L_ProcessZigBeeFrame142:
;ZigbeeRemoteIOV1.0.c,403 :: 		}
L_ProcessZigBeeFrame140:
;ZigbeeRemoteIOV1.0.c,404 :: 		}
L_ProcessZigBeeFrame135:
;ZigbeeRemoteIOV1.0.c,407 :: 		}
L_ProcessZigBeeFrame134:
L_ProcessZigBeeFrame133:
;ZigbeeRemoteIOV1.0.c,410 :: 		}
	GOTO        L_ProcessZigBeeFrame143
L_ProcessZigBeeFrame124:
;ZigbeeRemoteIOV1.0.c,414 :: 		else if( FrameType==0x8B )
	MOVLW       0
	XORWF       ProcessZigBeeFrame_FrameType_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame355
	MOVLW       139
	XORWF       ProcessZigBeeFrame_FrameType_L0+0, 0 
L__ProcessZigBeeFrame355:
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame144
;ZigbeeRemoteIOV1.0.c,417 :: 		if( ZigbeeFrame[8]==0x00 )
	MOVF        _ZigbeeFrame+8, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame145
;ZigbeeRemoteIOV1.0.c,419 :: 		if( JoinedToNet<2 ){
	MOVLW       128
	XORWF       _JoinedToNet+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame356
	MOVLW       2
	SUBWF       _JoinedToNet+0, 0 
L__ProcessZigBeeFrame356:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessZigBeeFrame146
;ZigbeeRemoteIOV1.0.c,420 :: 		JoinedToNet=2;
	MOVLW       2
	MOVWF       _JoinedToNet+0 
	MOVLW       0
	MOVWF       _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,422 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame357
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame357:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame279
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame358
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame358:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame279
	GOTO        L_ProcessZigBeeFrame151
L__ProcessZigBeeFrame279:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame151
L__ProcessZigBeeFrame278:
;ZigbeeRemoteIOV1.0.c,423 :: 		strcpy(writebuff, "ZIGBEE|JOINED\n");
	MOVLW       _writebuff+0
	MOVWF       FARG_strcpy_to+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_strcpy_to+1 
	MOVLW       ?lstr23_ZigbeeRemoteIOV1.0+0
	MOVWF       FARG_strcpy_from+0 
	MOVLW       hi_addr(?lstr23_ZigbeeRemoteIOV1.0+0)
	MOVWF       FARG_strcpy_from+1 
	CALL        _strcpy+0, 0
;ZigbeeRemoteIOV1.0.c,424 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,425 :: 		}
L_ProcessZigBeeFrame151:
;ZigbeeRemoteIOV1.0.c,426 :: 		}
L_ProcessZigBeeFrame146:
;ZigbeeRemoteIOV1.0.c,427 :: 		}
	GOTO        L_ProcessZigBeeFrame154
L_ProcessZigBeeFrame145:
;ZigbeeRemoteIOV1.0.c,430 :: 		else if( ZigbeeFrame[8]==0x21 )
	MOVF        _ZigbeeFrame+8, 0 
	XORLW       33
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame155
;ZigbeeRemoteIOV1.0.c,433 :: 		JoinedToNet=0;
	CLRF        _JoinedToNet+0 
	CLRF        _JoinedToNet+1 
;ZigbeeRemoteIOV1.0.c,435 :: 		if((debug==2 || debug==1) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame359
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame359:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame277
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame360
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessZigBeeFrame360:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessZigBeeFrame277
	GOTO        L_ProcessZigBeeFrame160
L__ProcessZigBeeFrame277:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessZigBeeFrame160
L__ProcessZigBeeFrame276:
;ZigbeeRemoteIOV1.0.c,436 :: 		sprinti(writebuff, "ZIGBEE|NONETWORK|ACK FAILED\n");
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
;ZigbeeRemoteIOV1.0.c,437 :: 		while(!hid_write(writebuff,64));
L_ProcessZigBeeFrame161:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessZigBeeFrame162
	GOTO        L_ProcessZigBeeFrame161
L_ProcessZigBeeFrame162:
;ZigbeeRemoteIOV1.0.c,438 :: 		}
L_ProcessZigBeeFrame160:
;ZigbeeRemoteIOV1.0.c,440 :: 		}
L_ProcessZigBeeFrame155:
L_ProcessZigBeeFrame154:
;ZigbeeRemoteIOV1.0.c,441 :: 		}
L_ProcessZigBeeFrame144:
L_ProcessZigBeeFrame143:
L_ProcessZigBeeFrame123:
L_ProcessZigBeeFrame80:
L_ProcessZigBeeFrame71:
;ZigbeeRemoteIOV1.0.c,457 :: 		}
L_end_ProcessZigBeeFrame:
	RETURN      0
; end of _ProcessZigBeeFrame

_interrupt:

;ZigbeeRemoteIOV1.0.c,461 :: 		void interrupt()
;ZigbeeRemoteIOV1.0.c,466 :: 		if(USBIF_Bit && USBON){
	BTFSS       USBIF_bit+0, BitPos(USBIF_bit+0) 
	GOTO        L_interrupt165
	BTFSS       PORTB+0, 4 
	GOTO        L_interrupt165
L__interrupt293:
;ZigbeeRemoteIOV1.0.c,467 :: 		USB_Interrupt_Proc();                   // USB servicing is done inside the interrupt
	CALL        _USB_Interrupt_Proc+0, 0
;ZigbeeRemoteIOV1.0.c,468 :: 		}
L_interrupt165:
;ZigbeeRemoteIOV1.0.c,470 :: 		if (PIR1.RCIF) {          // test the interrupt for uart rx
	BTFSS       PIR1+0, 5 
	GOTO        L_interrupt166
;ZigbeeRemoteIOV1.0.c,471 :: 		if (UART1_Data_Ready() == 1) {
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt167
;ZigbeeRemoteIOV1.0.c,472 :: 		Rx_char = UART1_Read();  //
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Rx_char+0 
;ZigbeeRemoteIOV1.0.c,473 :: 		if(Rx_char==0x7E){
	MOVF        R0, 0 
	XORLW       126
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt168
;ZigbeeRemoteIOV1.0.c,474 :: 		frameindex=0;
	CLRF        _frameindex+0 
	CLRF        _frameindex+1 
;ZigbeeRemoteIOV1.0.c,475 :: 		frame_started=1;
	MOVLW       1
	MOVWF       _frame_started+0 
;ZigbeeRemoteIOV1.0.c,477 :: 		}
L_interrupt168:
;ZigbeeRemoteIOV1.0.c,479 :: 		if(frame_started==1){
	MOVF        _frame_started+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt169
;ZigbeeRemoteIOV1.0.c,480 :: 		ZigbeeFrame[frameindex]=Rx_char;
	MOVLW       _ZigbeeFrame+0
	ADDWF       _frameindex+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_ZigbeeFrame+0)
	ADDWFC      _frameindex+1, 0 
	MOVWF       FSR1H 
	MOVF        _Rx_char+0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,482 :: 		if( frameindex==2 )
	MOVLW       0
	XORWF       _frameindex+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__interrupt363
	MOVLW       2
	XORWF       _frameindex+0, 0 
L__interrupt363:
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt170
;ZigbeeRemoteIOV1.0.c,484 :: 		framesize=ZigbeeFrame[1]+ZigbeeFrame[2];
	MOVF        _ZigbeeFrame+2, 0 
	ADDWF       _ZigbeeFrame+1, 0 
	MOVWF       _framesize+0 
	CLRF        _framesize+1 
	MOVLW       0
	ADDWFC      _framesize+1, 1 
;ZigbeeRemoteIOV1.0.c,485 :: 		}
L_interrupt170:
;ZigbeeRemoteIOV1.0.c,487 :: 		frameindex++;
	INFSNZ      _frameindex+0, 1 
	INCF        _frameindex+1, 1 
;ZigbeeRemoteIOV1.0.c,488 :: 		if( frameindex>=framesize+4 )
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
	GOTO        L__interrupt364
	MOVF        R1, 0 
	SUBWF       _frameindex+0, 0 
L__interrupt364:
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt171
;ZigbeeRemoteIOV1.0.c,491 :: 		frameindex=0;
	CLRF        _frameindex+0 
	CLRF        _frameindex+1 
;ZigbeeRemoteIOV1.0.c,492 :: 		frame_started=0;
	CLRF        _frame_started+0 
;ZigbeeRemoteIOV1.0.c,493 :: 		GotFrame=1;
	MOVLW       1
	MOVWF       _GotFrame+0 
;ZigbeeRemoteIOV1.0.c,495 :: 		}
L_interrupt171:
;ZigbeeRemoteIOV1.0.c,496 :: 		}
L_interrupt169:
;ZigbeeRemoteIOV1.0.c,497 :: 		}
L_interrupt167:
;ZigbeeRemoteIOV1.0.c,498 :: 		}
L_interrupt166:
;ZigbeeRemoteIOV1.0.c,500 :: 		}
L_end_interrupt:
L__interrupt362:
	RETFIE      1
; end of _interrupt

_ProcessInputs:

;ZigbeeRemoteIOV1.0.c,506 :: 		void ProcessInputs(){
;ZigbeeRemoteIOV1.0.c,508 :: 		if(JoinedLastState!=JoinedToNet){
	MOVF        _JoinedLastState+1, 0 
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs366
	MOVF        _JoinedToNet+0, 0 
	XORWF       _JoinedLastState+0, 0 
L__ProcessInputs366:
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs172
;ZigbeeRemoteIOV1.0.c,509 :: 		JoinedLastState=JoinedToNet;
	MOVF        _JoinedToNet+0, 0 
	MOVWF       _JoinedLastState+0 
	MOVF        _JoinedToNet+1, 0 
	MOVWF       _JoinedLastState+1 
;ZigbeeRemoteIOV1.0.c,510 :: 		PICIN1LastState=!PICIN1;
	BTFSC       PORTB+0, 0 
	GOTO        L__ProcessInputs367
	BSF         4056, 0 
	GOTO        L__ProcessInputs368
L__ProcessInputs367:
	BCF         4056, 0 
L__ProcessInputs368:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN1LastState+0 
;ZigbeeRemoteIOV1.0.c,511 :: 		PICIN2LastState=!PICIN2;
	BTFSC       PORTB+0, 1 
	GOTO        L__ProcessInputs369
	BSF         4056, 0 
	GOTO        L__ProcessInputs370
L__ProcessInputs369:
	BCF         4056, 0 
L__ProcessInputs370:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN2LastState+0 
;ZigbeeRemoteIOV1.0.c,512 :: 		PICIN3LastState=!PICIN3;
	BTFSC       PORTB+0, 2 
	GOTO        L__ProcessInputs371
	BSF         4056, 0 
	GOTO        L__ProcessInputs372
L__ProcessInputs371:
	BCF         4056, 0 
L__ProcessInputs372:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN3LastState+0 
;ZigbeeRemoteIOV1.0.c,513 :: 		PICIN4LastState=!PICIN4;
	BTFSC       PORTB+0, 3 
	GOTO        L__ProcessInputs373
	BSF         4056, 0 
	GOTO        L__ProcessInputs374
L__ProcessInputs373:
	BCF         4056, 0 
L__ProcessInputs374:
	MOVLW       0
	BTFSC       4056, 0 
	MOVLW       1
	MOVWF       _PICIN4LastState+0 
;ZigbeeRemoteIOV1.0.c,516 :: 		}
L_ProcessInputs172:
;ZigbeeRemoteIOV1.0.c,518 :: 		if(PICIN1LastState!=PICIN1){
	CLRF        R1 
	BTFSC       PORTB+0, 0 
	INCF        R1, 1 
	MOVF        _PICIN1LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs173
;ZigbeeRemoteIOV1.0.c,519 :: 		if(debounc_in1>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs375
	MOVF        _debounc_in1+0, 0 
	SUBLW       5
L__ProcessInputs375:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs174
;ZigbeeRemoteIOV1.0.c,520 :: 		debounc_in1=0;
	CLRF        _debounc_in1+0 
	CLRF        _debounc_in1+1 
;ZigbeeRemoteIOV1.0.c,521 :: 		PICIN1LastState= PICIN1;
	MOVLW       0
	BTFSC       PORTB+0, 0 
	MOVLW       1
	MOVWF       _PICIN1LastState+0 
;ZigbeeRemoteIOV1.0.c,522 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs376
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs376:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs301
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs377
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs377:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs301
	GOTO        L_ProcessInputs179
L__ProcessInputs301:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs179
L__ProcessInputs300:
;ZigbeeRemoteIOV1.0.c,523 :: 		sprinti(writebuff,"IN 1|%u \n",PICIN1LastState);
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
;ZigbeeRemoteIOV1.0.c,524 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs180:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs181
	GOTO        L_ProcessInputs180
L_ProcessInputs181:
;ZigbeeRemoteIOV1.0.c,525 :: 		}
L_ProcessInputs179:
;ZigbeeRemoteIOV1.0.c,526 :: 		if(PICIN1LastState)
	MOVF        _PICIN1LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs182
;ZigbeeRemoteIOV1.0.c,527 :: 		SendDataPacket(HostZigbee,"OUT|1|OFF",9,0);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_SendDataPacket_toadress+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_SendDataPacket_toadress+1 
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
	GOTO        L_ProcessInputs183
L_ProcessInputs182:
;ZigbeeRemoteIOV1.0.c,529 :: 		SendDataPacket(HostZigbee,"OUT|1|ON",8,0);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_SendDataPacket_toadress+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_SendDataPacket_toadress+1 
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
L_ProcessInputs183:
;ZigbeeRemoteIOV1.0.c,530 :: 		}
	GOTO        L_ProcessInputs184
L_ProcessInputs174:
;ZigbeeRemoteIOV1.0.c,532 :: 		debounc_in1++;
	INFSNZ      _debounc_in1+0, 1 
	INCF        _debounc_in1+1, 1 
L_ProcessInputs184:
;ZigbeeRemoteIOV1.0.c,534 :: 		}
L_ProcessInputs173:
;ZigbeeRemoteIOV1.0.c,535 :: 		if(PICIN2LastState!=PICIN2){
	CLRF        R1 
	BTFSC       PORTB+0, 1 
	INCF        R1, 1 
	MOVF        _PICIN2LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs185
;ZigbeeRemoteIOV1.0.c,537 :: 		if(debounc_in2>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in2+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs378
	MOVF        _debounc_in2+0, 0 
	SUBLW       5
L__ProcessInputs378:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs186
;ZigbeeRemoteIOV1.0.c,538 :: 		debounc_in2=0;
	CLRF        _debounc_in2+0 
	CLRF        _debounc_in2+1 
;ZigbeeRemoteIOV1.0.c,539 :: 		PICIN2LastState= PICIN2;
	MOVLW       0
	BTFSC       PORTB+0, 1 
	MOVLW       1
	MOVWF       _PICIN2LastState+0 
;ZigbeeRemoteIOV1.0.c,540 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs379
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs379:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs299
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs380
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs380:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs299
	GOTO        L_ProcessInputs191
L__ProcessInputs299:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs191
L__ProcessInputs298:
;ZigbeeRemoteIOV1.0.c,541 :: 		sprinti(writebuff,"IN 2|%u\n",PICIN2LastState);
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
;ZigbeeRemoteIOV1.0.c,542 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs192:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs193
	GOTO        L_ProcessInputs192
L_ProcessInputs193:
;ZigbeeRemoteIOV1.0.c,543 :: 		}
L_ProcessInputs191:
;ZigbeeRemoteIOV1.0.c,544 :: 		if(PICIN2LastState){
	MOVF        _PICIN2LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs194
;ZigbeeRemoteIOV1.0.c,545 :: 		SendDataPacket(HostZigbee,"OUT|2|OFF",9,0);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_SendDataPacket_toadress+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_SendDataPacket_toadress+1 
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
;ZigbeeRemoteIOV1.0.c,546 :: 		}
	GOTO        L_ProcessInputs195
L_ProcessInputs194:
;ZigbeeRemoteIOV1.0.c,548 :: 		SendDataPacket(HostZigbee,"OUT|2|ON",8,0);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_SendDataPacket_toadress+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_SendDataPacket_toadress+1 
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
;ZigbeeRemoteIOV1.0.c,549 :: 		}
L_ProcessInputs195:
;ZigbeeRemoteIOV1.0.c,550 :: 		}
	GOTO        L_ProcessInputs196
L_ProcessInputs186:
;ZigbeeRemoteIOV1.0.c,552 :: 		debounc_in2++;
	INFSNZ      _debounc_in2+0, 1 
	INCF        _debounc_in2+1, 1 
L_ProcessInputs196:
;ZigbeeRemoteIOV1.0.c,553 :: 		}
L_ProcessInputs185:
;ZigbeeRemoteIOV1.0.c,554 :: 		if(PICIN3LastState!=PICIN3){
	CLRF        R1 
	BTFSC       PORTB+0, 2 
	INCF        R1, 1 
	MOVF        _PICIN3LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs197
;ZigbeeRemoteIOV1.0.c,555 :: 		if(debounc_in3>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in3+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs381
	MOVF        _debounc_in3+0, 0 
	SUBLW       5
L__ProcessInputs381:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs198
;ZigbeeRemoteIOV1.0.c,556 :: 		debounc_in3=0;
	CLRF        _debounc_in3+0 
	CLRF        _debounc_in3+1 
;ZigbeeRemoteIOV1.0.c,557 :: 		PICIN3LastState= PICIN3;
	MOVLW       0
	BTFSC       PORTB+0, 2 
	MOVLW       1
	MOVWF       _PICIN3LastState+0 
;ZigbeeRemoteIOV1.0.c,558 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs382
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs382:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs297
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs383
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs383:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs297
	GOTO        L_ProcessInputs203
L__ProcessInputs297:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs203
L__ProcessInputs296:
;ZigbeeRemoteIOV1.0.c,559 :: 		sprinti(writebuff,"IN 3|%u\n",PICIN3LastState);
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
;ZigbeeRemoteIOV1.0.c,560 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs204:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs205
	GOTO        L_ProcessInputs204
L_ProcessInputs205:
;ZigbeeRemoteIOV1.0.c,561 :: 		}
L_ProcessInputs203:
;ZigbeeRemoteIOV1.0.c,562 :: 		if(PICIN3LastState)
	MOVF        _PICIN3LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs206
;ZigbeeRemoteIOV1.0.c,563 :: 		SendDataPacket(HostZigbee,"OUT|3|OFF",9,0);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_SendDataPacket_toadress+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_SendDataPacket_toadress+1 
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
	GOTO        L_ProcessInputs207
L_ProcessInputs206:
;ZigbeeRemoteIOV1.0.c,565 :: 		SendDataPacket(HostZigbee,"OUT|3|ON",8,0);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_SendDataPacket_toadress+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_SendDataPacket_toadress+1 
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
L_ProcessInputs207:
;ZigbeeRemoteIOV1.0.c,566 :: 		}
	GOTO        L_ProcessInputs208
L_ProcessInputs198:
;ZigbeeRemoteIOV1.0.c,568 :: 		debounc_in3++;
	INFSNZ      _debounc_in3+0, 1 
	INCF        _debounc_in3+1, 1 
L_ProcessInputs208:
;ZigbeeRemoteIOV1.0.c,569 :: 		}
L_ProcessInputs197:
;ZigbeeRemoteIOV1.0.c,570 :: 		if(PICIN4LastState!=PICIN4){
	CLRF        R1 
	BTFSC       PORTB+0, 3 
	INCF        R1, 1 
	MOVF        _PICIN4LastState+0, 0 
	XORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs209
;ZigbeeRemoteIOV1.0.c,571 :: 		if(debounc_in4>5){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _debounc_in4+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs384
	MOVF        _debounc_in4+0, 0 
	SUBLW       5
L__ProcessInputs384:
	BTFSC       STATUS+0, 0 
	GOTO        L_ProcessInputs210
;ZigbeeRemoteIOV1.0.c,572 :: 		debounc_in4=0;
	CLRF        _debounc_in4+0 
	CLRF        _debounc_in4+1 
;ZigbeeRemoteIOV1.0.c,573 :: 		PICIN4LastState= PICIN4;
	MOVLW       0
	BTFSC       PORTB+0, 3 
	MOVLW       1
	MOVWF       _PICIN4LastState+0 
;ZigbeeRemoteIOV1.0.c,574 :: 		if((debug==1 || debug==2) && USBON){
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs385
	MOVLW       1
	XORWF       _debug+0, 0 
L__ProcessInputs385:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs295
	MOVLW       0
	XORWF       _debug+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__ProcessInputs386
	MOVLW       2
	XORWF       _debug+0, 0 
L__ProcessInputs386:
	BTFSC       STATUS+0, 2 
	GOTO        L__ProcessInputs295
	GOTO        L_ProcessInputs215
L__ProcessInputs295:
	BTFSS       PORTB+0, 4 
	GOTO        L_ProcessInputs215
L__ProcessInputs294:
;ZigbeeRemoteIOV1.0.c,575 :: 		sprinti(writebuff,"IN 4|%u\n",PICIN4LastState);
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
;ZigbeeRemoteIOV1.0.c,576 :: 		while(!hid_write(writebuff,64));
L_ProcessInputs216:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_ProcessInputs217
	GOTO        L_ProcessInputs216
L_ProcessInputs217:
;ZigbeeRemoteIOV1.0.c,577 :: 		}
L_ProcessInputs215:
;ZigbeeRemoteIOV1.0.c,578 :: 		if(PICIN4LastState)
	MOVF        _PICIN4LastState+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ProcessInputs218
;ZigbeeRemoteIOV1.0.c,579 :: 		SendDataPacket(HostZigbee,"OUT|4|OFF",9,0);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_SendDataPacket_toadress+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_SendDataPacket_toadress+1 
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
	GOTO        L_ProcessInputs219
L_ProcessInputs218:
;ZigbeeRemoteIOV1.0.c,581 :: 		SendDataPacket(HostZigbee,"OUT|4|ON",8,0);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_SendDataPacket_toadress+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_SendDataPacket_toadress+1 
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
L_ProcessInputs219:
;ZigbeeRemoteIOV1.0.c,582 :: 		}
	GOTO        L_ProcessInputs220
L_ProcessInputs210:
;ZigbeeRemoteIOV1.0.c,584 :: 		debounc_in4++;
	INFSNZ      _debounc_in4+0, 1 
	INCF        _debounc_in4+1, 1 
L_ProcessInputs220:
;ZigbeeRemoteIOV1.0.c,585 :: 		}
L_ProcessInputs209:
;ZigbeeRemoteIOV1.0.c,588 :: 		}
L_end_ProcessInputs:
	RETURN      0
; end of _ProcessInputs

_write_eeprom_from:

;ZigbeeRemoteIOV1.0.c,592 :: 		void write_eeprom_from(char *str){
;ZigbeeRemoteIOV1.0.c,595 :: 		int i=0,j=0;
	CLRF        write_eeprom_from_i_L0+0 
	CLRF        write_eeprom_from_i_L0+1 
	CLRF        write_eeprom_from_j_L0+0 
	CLRF        write_eeprom_from_j_L0+1 
;ZigbeeRemoteIOV1.0.c,596 :: 		for(i=0;i<16;i=i+2){
	CLRF        write_eeprom_from_i_L0+0 
	CLRF        write_eeprom_from_i_L0+1 
L_write_eeprom_from221:
	MOVLW       128
	XORWF       write_eeprom_from_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_eeprom_from388
	MOVLW       16
	SUBWF       write_eeprom_from_i_L0+0, 0 
L__write_eeprom_from388:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_eeprom_from222
;ZigbeeRemoteIOV1.0.c,597 :: 		hexstr[0]=str[i];
	MOVF        write_eeprom_from_i_L0+0, 0 
	ADDWF       FARG_write_eeprom_from_str+0, 0 
	MOVWF       FSR0 
	MOVF        write_eeprom_from_i_L0+1, 0 
	ADDWFC      FARG_write_eeprom_from_str+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       write_eeprom_from_hexstr_L0+0 
;ZigbeeRemoteIOV1.0.c,598 :: 		hexstr[1]=str[i+1];
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
;ZigbeeRemoteIOV1.0.c,599 :: 		hexval=xtoi(hexstr);
	MOVLW       write_eeprom_from_hexstr_L0+0
	MOVWF       FARG_xtoi_s+0 
	MOVLW       hi_addr(write_eeprom_from_hexstr_L0+0)
	MOVWF       FARG_xtoi_s+1 
	CALL        _xtoi+0, 0
;ZigbeeRemoteIOV1.0.c,600 :: 		EEPROM_Write(0x01+j,hexval);
	MOVF        write_eeprom_from_j_L0+0, 0 
	ADDLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ZigbeeRemoteIOV1.0.c,601 :: 		j++;
	INFSNZ      write_eeprom_from_j_L0+0, 1 
	INCF        write_eeprom_from_j_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,596 :: 		for(i=0;i<16;i=i+2){
	MOVLW       2
	ADDWF       write_eeprom_from_i_L0+0, 1 
	MOVLW       0
	ADDWFC      write_eeprom_from_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,602 :: 		}
	GOTO        L_write_eeprom_from221
L_write_eeprom_from222:
;ZigbeeRemoteIOV1.0.c,603 :: 		}
L_end_write_eeprom_from:
	RETURN      0
; end of _write_eeprom_from

_read_eeprom_to:

;ZigbeeRemoteIOV1.0.c,605 :: 		void read_eeprom_to(char *dest){
;ZigbeeRemoteIOV1.0.c,608 :: 		for(i=0;i<8;i++){
	CLRF        read_eeprom_to_i_L0+0 
	CLRF        read_eeprom_to_i_L0+1 
L_read_eeprom_to224:
	MOVLW       128
	XORWF       read_eeprom_to_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_eeprom_to390
	MOVLW       8
	SUBWF       read_eeprom_to_i_L0+0, 0 
L__read_eeprom_to390:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_eeprom_to225
;ZigbeeRemoteIOV1.0.c,609 :: 		dest[i]=EEPROM_Read(0x01+i);
	MOVF        read_eeprom_to_i_L0+0, 0 
	ADDWF       FARG_read_eeprom_to_dest+0, 0 
	MOVWF       FLOC__read_eeprom_to+0 
	MOVF        read_eeprom_to_i_L0+1, 0 
	ADDWFC      FARG_read_eeprom_to_dest+1, 0 
	MOVWF       FLOC__read_eeprom_to+1 
	MOVF        read_eeprom_to_i_L0+0, 0 
	ADDLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVFF       FLOC__read_eeprom_to+0, FSR1
	MOVFF       FLOC__read_eeprom_to+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ZigbeeRemoteIOV1.0.c,608 :: 		for(i=0;i<8;i++){
	INFSNZ      read_eeprom_to_i_L0+0, 1 
	INCF        read_eeprom_to_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,614 :: 		}
	GOTO        L_read_eeprom_to224
L_read_eeprom_to225:
;ZigbeeRemoteIOV1.0.c,616 :: 		}
L_end_read_eeprom_to:
	RETURN      0
; end of _read_eeprom_to

_main:

;ZigbeeRemoteIOV1.0.c,617 :: 		void main() {
;ZigbeeRemoteIOV1.0.c,619 :: 		int i, MY_retry=0;
;ZigbeeRemoteIOV1.0.c,623 :: 		char del[2] = "|";
	MOVLW       124
	MOVWF       main_del_L0+0 
	CLRF        main_del_L0+1 
;ZigbeeRemoteIOV1.0.c,626 :: 		delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main227:
	DECFSZ      R13, 1, 1
	BRA         L_main227
	DECFSZ      R12, 1, 1
	BRA         L_main227
	DECFSZ      R11, 1, 1
	BRA         L_main227
	NOP
	NOP
;ZigbeeRemoteIOV1.0.c,628 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       4
	MOVWF       SPBRGH+0 
	MOVLW       225
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;ZigbeeRemoteIOV1.0.c,630 :: 		MM_Init();
	CALL        _MM_Init+0, 0
;ZigbeeRemoteIOV1.0.c,632 :: 		HostZigbee=(unsigned short*)malloc(sizeof(char) *8);
	MOVLW       8
	MOVWF       FARG_Malloc_Size+0 
	MOVLW       0
	MOVWF       FARG_Malloc_Size+1 
	CALL        _Malloc+0, 0
	MOVF        R0, 0 
	MOVWF       _HostZigbee+0 
	MOVF        R1, 0 
	MOVWF       _HostZigbee+1 
;ZigbeeRemoteIOV1.0.c,635 :: 		PICOUT1_Direction=0;
	BCF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,636 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,637 :: 		PICOUT2_Direction=0;
	BCF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,638 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,639 :: 		PICOUT3_Direction=0;
	BCF         TRISA2_bit+0, BitPos(TRISA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,640 :: 		PICOUT3=0;
	BCF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,641 :: 		PICOUT4_Direction=0;
	BCF         TRISA3_bit+0, BitPos(TRISA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,642 :: 		PICOUT4=0;
	BCF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,647 :: 		PICIN1_Direction=1;
	BSF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;ZigbeeRemoteIOV1.0.c,648 :: 		PICIN2_Direction=1;
	BSF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;ZigbeeRemoteIOV1.0.c,649 :: 		PICIN3_Direction=1;
	BSF         TRISB2_bit+0, BitPos(TRISB2_bit+0) 
;ZigbeeRemoteIOV1.0.c,650 :: 		PICIN4_Direction=1;
	BSF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;ZigbeeRemoteIOV1.0.c,651 :: 		USBON_Direction=1;
	BSF         TRISB3_bit+0, BitPos(TRISB3_bit+0) 
;ZigbeeRemoteIOV1.0.c,652 :: 		PROG_Direction=1;
	BSF         TRISB5_bit+0, BitPos(TRISB5_bit+0) 
;ZigbeeRemoteIOV1.0.c,654 :: 		ADCON0 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON0+0, 1 
;ZigbeeRemoteIOV1.0.c,655 :: 		ADCON1 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON1+0, 1 
;ZigbeeRemoteIOV1.0.c,656 :: 		ADCON2 |= 0x0F;                         // Configure all ports with analog function as digital
	MOVLW       15
	IORWF       ADCON2+0, 1 
;ZigbeeRemoteIOV1.0.c,657 :: 		CMCON  |= 7;
	MOVLW       7
	IORWF       CMCON+0, 1 
;ZigbeeRemoteIOV1.0.c,661 :: 		INTCON.GIE = 1;
	BSF         INTCON+0, 7 
;ZigbeeRemoteIOV1.0.c,662 :: 		INTCON.PEIE = 1;
	BSF         INTCON+0, 6 
;ZigbeeRemoteIOV1.0.c,663 :: 		PIE1.RCIE = 1; //enable interrupt.
	BSF         PIE1+0, 5 
;ZigbeeRemoteIOV1.0.c,666 :: 		if(HostZigbee == 0)
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main392
	MOVLW       0
	XORWF       R0, 0 
L__main392:
	BTFSS       STATUS+0, 2 
	GOTO        L_main228
;ZigbeeRemoteIOV1.0.c,668 :: 		PICOUT1=1;
	BSF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,669 :: 		PICOUT2=1;
	BSF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,670 :: 		PICOUT3=1;
	BSF         LATA2_bit+0, BitPos(LATA2_bit+0) 
;ZigbeeRemoteIOV1.0.c,671 :: 		PICOUT4=1;
	BSF         LATA3_bit+0, BitPos(LATA3_bit+0) 
;ZigbeeRemoteIOV1.0.c,673 :: 		}
L_main228:
;ZigbeeRemoteIOV1.0.c,674 :: 		if(USBON)
	BTFSS       PORTB+0, 4 
	GOTO        L_main229
;ZigbeeRemoteIOV1.0.c,675 :: 		HID_Enable(readbuff,writebuff);      // Enable HID communication
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
L_main229:
;ZigbeeRemoteIOV1.0.c,679 :: 		debug=0;
	CLRF        _debug+0 
	CLRF        _debug+1 
;ZigbeeRemoteIOV1.0.c,681 :: 		read_eeprom_to(HostZigbee);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_read_eeprom_to_dest+1 
	CALL        _read_eeprom_to+0, 0
;ZigbeeRemoteIOV1.0.c,684 :: 		SendRawPacket(MY1, 8);
	MOVLW       _MY1+0
	MOVWF       FARG_SendRawPacket_RawPacket+0 
	MOVLW       hi_addr(_MY1+0)
	MOVWF       FARG_SendRawPacket_RawPacket+1 
	MOVLW       8
	MOVWF       FARG_SendRawPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendRawPacket_len+1 
	CALL        _SendRawPacket+0, 0
;ZigbeeRemoteIOV1.0.c,685 :: 		while(1)
L_main230:
;ZigbeeRemoteIOV1.0.c,689 :: 		if(GotFrame==1){
	MOVF        _GotFrame+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main232
;ZigbeeRemoteIOV1.0.c,690 :: 		GotFrame=0;
	CLRF        _GotFrame+0 
;ZigbeeRemoteIOV1.0.c,691 :: 		ProcessZigBeeFrame();
	CALL        _ProcessZigBeeFrame+0, 0
;ZigbeeRemoteIOV1.0.c,693 :: 		}
L_main232:
;ZigbeeRemoteIOV1.0.c,696 :: 		ProcessInputs();
	CALL        _ProcessInputs+0, 0
;ZigbeeRemoteIOV1.0.c,703 :: 		if(JoinedToNet==0){
	MOVLW       0
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main393
	MOVLW       0
	XORWF       _JoinedToNet+0, 0 
L__main393:
	BTFSS       STATUS+0, 2 
	GOTO        L_main233
;ZigbeeRemoteIOV1.0.c,704 :: 		PICOUT1=1;
	BSF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,705 :: 		PICOUT2=0;
	BCF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,706 :: 		}
L_main233:
;ZigbeeRemoteIOV1.0.c,708 :: 		if(JoinedToNet==2){
	MOVLW       0
	XORWF       _JoinedToNet+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main394
	MOVLW       2
	XORWF       _JoinedToNet+0, 0 
L__main394:
	BTFSS       STATUS+0, 2 
	GOTO        L_main234
;ZigbeeRemoteIOV1.0.c,709 :: 		PICOUT2=1;
	BSF         LATA1_bit+0, BitPos(LATA1_bit+0) 
;ZigbeeRemoteIOV1.0.c,710 :: 		PICOUT1=0;
	BCF         LATA0_bit+0, BitPos(LATA0_bit+0) 
;ZigbeeRemoteIOV1.0.c,711 :: 		}
L_main234:
;ZigbeeRemoteIOV1.0.c,712 :: 		if(USBON){
	BTFSS       PORTB+0, 4 
	GOTO        L_main235
;ZigbeeRemoteIOV1.0.c,713 :: 		if(!(hid_read()==0)) {
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main236
;ZigbeeRemoteIOV1.0.c,714 :: 		i=0;
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
;ZigbeeRemoteIOV1.0.c,719 :: 		CommandTrimmed[0]=strtok(DeleteChar(DeleteChar(readbuff,'\r'),'\n'), del);
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
;ZigbeeRemoteIOV1.0.c,722 :: 		do
L_main237:
;ZigbeeRemoteIOV1.0.c,725 :: 		i++;
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;ZigbeeRemoteIOV1.0.c,726 :: 		CommandTrimmed[i] = strtok(0, del);
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
;ZigbeeRemoteIOV1.0.c,729 :: 		while( CommandTrimmed[i] != 0 );
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
	GOTO        L__main395
	MOVLW       0
	XORWF       R1, 0 
L__main395:
	BTFSS       STATUS+0, 2 
	GOTO        L_main237
;ZigbeeRemoteIOV1.0.c,733 :: 		if(strcmp(CommandTrimmed[0],"UPGRADE")==0){
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
	GOTO        L__main396
	MOVLW       0
	XORWF       R0, 0 
L__main396:
	BTFSS       STATUS+0, 2 
	GOTO        L_main240
;ZigbeeRemoteIOV1.0.c,734 :: 		sprinti(writebuff,"UPGRADING\n");
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
;ZigbeeRemoteIOV1.0.c,735 :: 		while(!hid_write(writebuff,64));
L_main241:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main242
	GOTO        L_main241
L_main242:
;ZigbeeRemoteIOV1.0.c,736 :: 		EEPROM_Write(0x00,0x01);
	CLRF        FARG_EEPROM_Write_address+0 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ZigbeeRemoteIOV1.0.c,737 :: 		HID_Disable();
	CALL        _HID_Disable+0, 0
;ZigbeeRemoteIOV1.0.c,738 :: 		Delay_ms(1000);
	MOVLW       61
	MOVWF       R11, 0
	MOVLW       225
	MOVWF       R12, 0
	MOVLW       63
	MOVWF       R13, 0
L_main243:
	DECFSZ      R13, 1, 1
	BRA         L_main243
	DECFSZ      R12, 1, 1
	BRA         L_main243
	DECFSZ      R11, 1, 1
	BRA         L_main243
	NOP
	NOP
;ZigbeeRemoteIOV1.0.c,739 :: 		asm { reset; }
	RESET
;ZigbeeRemoteIOV1.0.c,740 :: 		} else if(strcmp(CommandTrimmed[0],"SET")==0){
	GOTO        L_main244
L_main240:
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
	GOTO        L__main397
	MOVLW       0
	XORWF       R0, 0 
L__main397:
	BTFSS       STATUS+0, 2 
	GOTO        L_main245
;ZigbeeRemoteIOV1.0.c,741 :: 		if(strcmp(CommandTrimmed[1],"DEBUG")==0){
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
	GOTO        L__main398
	MOVLW       0
	XORWF       R0, 0 
L__main398:
	BTFSS       STATUS+0, 2 
	GOTO        L_main246
;ZigbeeRemoteIOV1.0.c,742 :: 		int debug_val=0;
;ZigbeeRemoteIOV1.0.c,743 :: 		debug_val=atoi(CommandTrimmed[2]);
	MOVF        main_CommandTrimmed_L0+4, 0 
	MOVWF       FARG_atoi_s+0 
	MOVF        main_CommandTrimmed_L0+5, 0 
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
;ZigbeeRemoteIOV1.0.c,744 :: 		debug=debug_val;
	MOVF        R0, 0 
	MOVWF       _debug+0 
	MOVF        R1, 0 
	MOVWF       _debug+1 
;ZigbeeRemoteIOV1.0.c,745 :: 		sprinti(writebuff,"DEBUG|%d\n",debug_val);
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
;ZigbeeRemoteIOV1.0.c,746 :: 		while(!hid_write(writebuff,64));
L_main247:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main248
	GOTO        L_main247
L_main248:
;ZigbeeRemoteIOV1.0.c,747 :: 		}
L_main246:
;ZigbeeRemoteIOV1.0.c,748 :: 		}
	GOTO        L_main249
L_main245:
;ZigbeeRemoteIOV1.0.c,749 :: 		else if(strcmp(CommandTrimmed[0],"SEND")==0){
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
	GOTO        L__main399
	MOVLW       0
	XORWF       R0, 0 
L__main399:
	BTFSS       STATUS+0, 2 
	GOTO        L_main250
;ZigbeeRemoteIOV1.0.c,750 :: 		SendDataPacket(0,CommandTrimmed[1],strlen(CommandTrimmed[1]),0);
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_SendDataPacket_len+0 
	MOVF        R1, 0 
	MOVWF       FARG_SendDataPacket_len+1 
	CLRF        FARG_SendDataPacket_toadress+0 
	CLRF        FARG_SendDataPacket_toadress+1 
	MOVF        main_CommandTrimmed_L0+2, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+0 
	MOVF        main_CommandTrimmed_L0+3, 0 
	MOVWF       FARG_SendDataPacket_DataPacket+1 
	CLRF        FARG_SendDataPacket_Ack+0 
	CALL        _SendDataPacket+0, 0
;ZigbeeRemoteIOV1.0.c,752 :: 		}
	GOTO        L_main251
L_main250:
;ZigbeeRemoteIOV1.0.c,753 :: 		else if(strcmp(CommandTrimmed[0],"?")==0){
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
	GOTO        L__main400
	MOVLW       0
	XORWF       R0, 0 
L__main400:
	BTFSS       STATUS+0, 2 
	GOTO        L_main252
;ZigbeeRemoteIOV1.0.c,755 :: 		sprinti(writebuff,"KPP ZIGBEE BOARD V1.1\n");
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
;ZigbeeRemoteIOV1.0.c,756 :: 		while(!hid_write(writebuff,64));
L_main253:
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main254
	GOTO        L_main253
L_main254:
;ZigbeeRemoteIOV1.0.c,757 :: 		}
	GOTO        L_main255
L_main252:
;ZigbeeRemoteIOV1.0.c,759 :: 		else if(strcmp(CommandTrimmed[0],"ZIGBEE")==0){
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
	GOTO        L__main401
	MOVLW       0
	XORWF       R0, 0 
L__main401:
	BTFSS       STATUS+0, 2 
	GOTO        L_main256
;ZigbeeRemoteIOV1.0.c,761 :: 		if(strcmp(CommandTrimmed[1],"SET")==0){
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
	GOTO        L__main402
	MOVLW       0
	XORWF       R0, 0 
L__main402:
	BTFSS       STATUS+0, 2 
	GOTO        L_main257
;ZigbeeRemoteIOV1.0.c,762 :: 		if(strcmp(CommandTrimmed[2],"HOST")==0){
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
	GOTO        L__main403
	MOVLW       0
	XORWF       R0, 0 
L__main403:
	BTFSS       STATUS+0, 2 
	GOTO        L_main258
;ZigbeeRemoteIOV1.0.c,764 :: 		write_eeprom_from(CommandTrimmed[3]);
	MOVF        main_CommandTrimmed_L0+6, 0 
	MOVWF       FARG_write_eeprom_from_str+0 
	MOVF        main_CommandTrimmed_L0+7, 0 
	MOVWF       FARG_write_eeprom_from_str+1 
	CALL        _write_eeprom_from+0, 0
;ZigbeeRemoteIOV1.0.c,765 :: 		delay_ms(100);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main259:
	DECFSZ      R13, 1, 1
	BRA         L_main259
	DECFSZ      R12, 1, 1
	BRA         L_main259
	DECFSZ      R11, 1, 1
	BRA         L_main259
	NOP
;ZigbeeRemoteIOV1.0.c,766 :: 		read_eeprom_to(HostZigbee);
	MOVF        _HostZigbee+0, 0 
	MOVWF       FARG_read_eeprom_to_dest+0 
	MOVF        _HostZigbee+1, 0 
	MOVWF       FARG_read_eeprom_to_dest+1 
	CALL        _read_eeprom_to+0, 0
;ZigbeeRemoteIOV1.0.c,768 :: 		}
L_main258:
;ZigbeeRemoteIOV1.0.c,769 :: 		}
	GOTO        L_main260
L_main257:
;ZigbeeRemoteIOV1.0.c,771 :: 		else if(strcmp(CommandTrimmed[1],"GET")==0){
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
	GOTO        L__main404
	MOVLW       0
	XORWF       R0, 0 
L__main404:
	BTFSS       STATUS+0, 2 
	GOTO        L_main261
;ZigbeeRemoteIOV1.0.c,772 :: 		if(strcmp(CommandTrimmed[2],"HOST")==0){
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
	GOTO        L__main405
	MOVLW       0
	XORWF       R0, 0 
L__main405:
	BTFSS       STATUS+0, 2 
	GOTO        L_main262
;ZigbeeRemoteIOV1.0.c,773 :: 		int i,k=0;
	CLRF        main_k_L6+0 
	CLRF        main_k_L6+1 
;ZigbeeRemoteIOV1.0.c,776 :: 		for(i=0;i<8;i++){
	CLRF        main_i_L6+0 
	CLRF        main_i_L6+1 
L_main263:
	MOVLW       128
	XORWF       main_i_L6+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main406
	MOVLW       8
	SUBWF       main_i_L6+0, 0 
L__main406:
	BTFSC       STATUS+0, 0 
	GOTO        L_main264
;ZigbeeRemoteIOV1.0.c,777 :: 		ShortToHex(HostZigbee[i],HostZigbeeStr+k);
	MOVF        main_i_L6+0, 0 
	ADDWF       _HostZigbee+0, 0 
	MOVWF       FSR0 
	MOVF        main_i_L6+1, 0 
	ADDWFC      _HostZigbee+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_ShortToHex_input+0 
	MOVLW       main_HostZigbeeStr_L6+0
	ADDWF       main_k_L6+0, 0 
	MOVWF       FARG_ShortToHex_output+0 
	MOVLW       hi_addr(main_HostZigbeeStr_L6+0)
	ADDWFC      main_k_L6+1, 0 
	MOVWF       FARG_ShortToHex_output+1 
	CALL        _ShortToHex+0, 0
;ZigbeeRemoteIOV1.0.c,778 :: 		k=k+2;
	MOVLW       2
	ADDWF       main_k_L6+0, 1 
	MOVLW       0
	ADDWFC      main_k_L6+1, 1 
;ZigbeeRemoteIOV1.0.c,776 :: 		for(i=0;i<8;i++){
	INFSNZ      main_i_L6+0, 1 
	INCF        main_i_L6+1, 1 
;ZigbeeRemoteIOV1.0.c,779 :: 		}
	GOTO        L_main263
L_main264:
;ZigbeeRemoteIOV1.0.c,780 :: 		sprinti(writebuff,"ZIGBEE|HOST|%s\n",HostZigbeeStr);
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
	MOVLW       main_HostZigbeeStr_L6+0
	MOVWF       FARG_sprinti_wh+5 
	MOVLW       hi_addr(main_HostZigbeeStr_L6+0)
	MOVWF       FARG_sprinti_wh+6 
	CALL        _sprinti+0, 0
;ZigbeeRemoteIOV1.0.c,781 :: 		while(!hid_write(writebuff,64));
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
;ZigbeeRemoteIOV1.0.c,782 :: 		}
L_main262:
;ZigbeeRemoteIOV1.0.c,783 :: 		}
	GOTO        L_main268
L_main261:
;ZigbeeRemoteIOV1.0.c,784 :: 		else if(strcmp(CommandTrimmed[1],"MY")==0){
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
	GOTO        L__main407
	MOVLW       0
	XORWF       R0, 0 
L__main407:
	BTFSS       STATUS+0, 2 
	GOTO        L_main269
;ZigbeeRemoteIOV1.0.c,785 :: 		SendRawPacket(MY1, 8);
	MOVLW       _MY1+0
	MOVWF       FARG_SendRawPacket_RawPacket+0 
	MOVLW       hi_addr(_MY1+0)
	MOVWF       FARG_SendRawPacket_RawPacket+1 
	MOVLW       8
	MOVWF       FARG_SendRawPacket_len+0 
	MOVLW       0
	MOVWF       FARG_SendRawPacket_len+1 
	CALL        _SendRawPacket+0, 0
;ZigbeeRemoteIOV1.0.c,786 :: 		}
L_main269:
L_main268:
L_main260:
;ZigbeeRemoteIOV1.0.c,787 :: 		}
L_main256:
L_main255:
L_main251:
L_main249:
L_main244:
;ZigbeeRemoteIOV1.0.c,789 :: 		}
L_main236:
;ZigbeeRemoteIOV1.0.c,791 :: 		}
L_main235:
;ZigbeeRemoteIOV1.0.c,793 :: 		}
	GOTO        L_main230
;ZigbeeRemoteIOV1.0.c,795 :: 		Delay_ms(1);
L_main270:
	DECFSZ      R13, 1, 1
	BRA         L_main270
	DECFSZ      R12, 1, 1
	BRA         L_main270
	NOP
;ZigbeeRemoteIOV1.0.c,797 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
