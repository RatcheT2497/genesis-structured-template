
MEMORY {
    HDR(r):    ORIGIN=0x00000000, LENGTH=0x00000200
    ROM(rx):   ORIGIN=0x00000200, LENGTH=0x00400000
    SRAM(rw):  ORIGIN=0x00200000, LENGTH=0x00200000
    BSS(rwx):  ORIGIN=0x00FF0000, LENGTH=0x00008000
    FBSS(rwx): ORIGIN=0x00FF8000, LENGTH=0x00008000
}
ENTRY(IntEntry)
SECTIONS {
    bss (NOLOAD) : {
        . = ALIGN(2);
        *(bss)
    } >BSS AT>BSS;
    fbss (NOLOAD) : {
        . = ALIGN(2);
        *(fbss)
    } >FBSS AT>FBSS;

    __rom_start = .;
    header : {
        *(header)
    } >HDR =0x20;

    code : {
        . = ALIGN(2);
        *(code)
    } >ROM;

    rodata : {
        . = ALIGN(2);
        *(rodata)
    } >ROM;
    __rom_end = .;
    __rom_size = __rom_end - __rom_start;

}
