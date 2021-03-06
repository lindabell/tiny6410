
.globl _start
_start:

/* 硬件相关的设置 */
    /* Peri port setup */
    ldr r0, =0x70000000
    orr r0, r0, #0x13
    mcr p15,0,r0,c15,c2,4       @ 256M(0x70000000-0x7fffffff)
    
/* 关看门狗 */
/* 往WTCON(0x7E004000)写0 */
	
	ldr r0, =0x7E004000
	mov r1, #0
	str r1, [r0]

	/* 设置栈 */
	ldr sp, =6*1024
	
	/* int xxxxx(int start, int end, int a, int b, int c, int d) */
	mov r0, #0   /* start */
	mov r1, #8   /* end */
	mov r2, #0   /* a */
	mov r3, #0   /* b */
	
	/* c, d 存在栈里 */
	ldr sp, =6*1024-8;
	mov r4, #0
	str r4, [sp]  /* c */
	
	mov r4, #1
	str r4, [sp, #4]  /* d */
	
	bl xxxxx
halt:
	b halt	
