MEMORY
{

	/* ROM 是可读的(r)和可执行的(x) */
	rom (rx)  : ORIGIN = 0x8000000, LENGTH = 512K
	/* RAM 是可读的(r),可写的(w),可执行的(x) */
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}
ENTRY(Reset_Handler)
_system_stack_size = 0x100;
/* SECTIONS 命令 : 定义各输入段到输出段的映射 */
SECTIONS
{

	. = 0x0;
	/* 从 0x00000000 开始 */
	.text : {
		. = ALIGN(4);
		_stext = .;
		KEEP(*(.isr_vector)) /* 向量表 */
		. = ALIGN(4);
		*(.text) /* 程序代码 */
		*(.rodata) /* 只读数据 */
	} > rom = 0
	__exdix_start = .;
	.ARM.exidx :
	{
		*(.ARM.exidx* .gnu.linkonce.armexidx.*)
		/* This is used by the startup in order to initialize the .data secion */
		_sidata = .;
    	} > rom
	__exdix_end = .;

	. = 0x20000000;
	/* 从 0x20000000 开始 */
	.data : AT(_sidata)
	{
		. = ALIGN(4);
		_sdata = . ;
		*(.data)
		*(.data.*)
		. = ALIGN(4);
		_edata = . ;
		/* 数据存储器 */
	} > ram

	.stack : 
	{
		. = . + _system_stack_size;  
		. = ALIGN(4);
		_estack = .;
  	} > ram

	__bss_start = .;
	.bss :
	{
		. = ALIGN(4);
		/* This is used by the startup in order to initialize the .bss secion */
		_sbss = .;
		*(.bss)
		*(.bss.*)
		*(COMMON)

		. = ALIGN(4);
		/* This is used by the startup in order to initialize the .bss secion */
		_ebss = . ;

		*(.bss.init)
    } > ram
    __bss_end = .;
    _end = .;
}
