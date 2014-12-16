
_USB_Init_Desc:

;USBdsc.c,173 :: 		void USB_Init_Desc(){
;USBdsc.c,174 :: 		USB_config_dsc_ptr[0] = &configDescriptor1;
	MOVLW       _configDescriptor1+0
	MOVWF       _USB_config_dsc_ptr+0 
	MOVLW       hi_addr(_configDescriptor1+0)
	MOVWF       _USB_config_dsc_ptr+1 
	MOVLW       higher_addr(_configDescriptor1+0)
	MOVWF       _USB_config_dsc_ptr+2 
;USBdsc.c,175 :: 		USB_string_dsc_ptr[0] = (const char*)&strd1;
	MOVLW       _strd1+0
	MOVWF       _USB_string_dsc_ptr+0 
	MOVLW       hi_addr(_strd1+0)
	MOVWF       _USB_string_dsc_ptr+1 
	MOVLW       higher_addr(_strd1+0)
	MOVWF       _USB_string_dsc_ptr+2 
;USBdsc.c,176 :: 		USB_string_dsc_ptr[1] = (const char*)&strd2;
	MOVLW       _strd2+0
	MOVWF       _USB_string_dsc_ptr+3 
	MOVLW       hi_addr(_strd2+0)
	MOVWF       _USB_string_dsc_ptr+4 
	MOVLW       higher_addr(_strd2+0)
	MOVWF       _USB_string_dsc_ptr+5 
;USBdsc.c,177 :: 		USB_string_dsc_ptr[2] = (const char*)&strd3;
	MOVLW       _strd3+0
	MOVWF       _USB_string_dsc_ptr+6 
	MOVLW       hi_addr(_strd3+0)
	MOVWF       _USB_string_dsc_ptr+7 
	MOVLW       higher_addr(_strd3+0)
	MOVWF       _USB_string_dsc_ptr+8 
;USBdsc.c,178 :: 		USB_string_dsc_ptr[3] = (const char*)&strd4;
	MOVLW       _strd4+0
	MOVWF       _USB_string_dsc_ptr+9 
	MOVLW       hi_addr(_strd4+0)
	MOVWF       _USB_string_dsc_ptr+10 
	MOVLW       higher_addr(_strd4+0)
	MOVWF       _USB_string_dsc_ptr+11 
;USBdsc.c,179 :: 		}
L_end_USB_Init_Desc:
	RETURN      0
; end of _USB_Init_Desc
