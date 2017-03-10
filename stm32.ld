MEMORY
{

	/* ROM 是可读的(r)和可执行的(x) */
	rom (rx) : ORIGIN = 0, LENGTH = 64K
	/* RAM 是可读的(r),可写的(w),可执行的(x) */
	ram (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}
/* SECTIONS 命令 : 定义各输入段到输出段的映射 */
SECTIONS
{

	. = 0x0;
	/* 从 0x00000000 开始 */
	.text : {
		*(vectors) /* 向量表 */
		*(.text) /* 程序代码 */
		*(.rodata) /* 只读数据 */
	}
	. = 0x20000000;
	/* 从 0x20000000 开始 */
	.data : {
		*(.data)
		/* 数据存储器 */
	}
	.bss : {
		*(.bss)
		/* 预留的数据存储器,必须初始化为零 */
	}
}
