#line 1 "F:/MEOCloud/KPP/Electronica/PIC Progs/MikroC/ZigBee Remote IO V1.0/Config.c"
#line 37 "F:/MEOCloud/KPP/Electronica/PIC Progs/MikroC/ZigBee Remote IO V1.0/Config.c"
const enum TMcuType MCU_TYPE = mtPIC18;






const unsigned long BOOTLOADER_SIZE = 7400;








const unsigned int BOOTLOADER_REVISION = 0x1200;


const unsigned long BOOTLOADER_START = ((__FLASH_SIZE-BOOTLOADER_SIZE)/_FLASH_ERASE)*_FLASH_ERASE;
const unsigned char RESET_VECTOR_SIZE = 4;




const TBootInfo BootInfo = { sizeof(TBootInfo),
 {bifMCUTYPE, MCU_TYPE},
 {bifMCUSIZE, __FLASH_SIZE},
 {bifERASEBLOCK, _FLASH_ERASE},
 {bifWRITEBLOCK, _FLASH_WRITE_LATCH},
 {bifBOOTREV, BOOTLOADER_REVISION},
 {bifBOOTSTART, BOOTLOADER_START},
 {bifDEVDSC,  "NO NAME" }
 };





unsigned char HidReadBuff[64] absolute 0x500;
unsigned char HidWriteBuff[64] absolute 0x540;
unsigned char Reserve4thBankForUSB[256] absolute 0x400;
#line 137 "F:/MEOCloud/KPP/Electronica/PIC Progs/MikroC/ZigBee Remote IO V1.0/Config.c"
void Config() {
  OrgAll(BOOTLOADER_START-RESET_VECTOR_SIZE); FuncOrg(main, BOOTLOADER_START); FuncOrg(StartProgram, BOOTLOADER_START-RESET_VECTOR_SIZE); if (Reserve4thBankForUSB) ; ;
}
