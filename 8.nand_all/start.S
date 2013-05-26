
.globl _start
_start:

/* Ӳ����ص����� */
    /* Peri port setup */
    ldr r0, =0x70000000
    orr r0, r0, #0x13
    mcr p15,0,r0,c15,c2,4       @ 256M(0x70000000-0x7fffffff)
    
/* �ؿ��Ź� */
/* ��WTCON(0x7E004000)д0 */
	
	ldr r0, =0x7E004000
	mov r1, #0
	str r1, [r0]
	
	/* ����ջ */
	ldr sp, =30*1024+0x51000000
	//ldr sp, =8*1024
	/* ����ʱ�� */
	bl clock_init

	/* ����DDR */
	bl ddr_init
	bl nand_init
	/* �ض�λ */
/* �ѳ���Ĵ���Ρ����ݶθ��Ƶ��������ӵ�ַȥ */	
	adr r0, _start   /* ���_startָ�ǰ���ڵĵ�ַ : 0*/
	ldr r1, =_start  /* _start�����ӵ�ַ 0x51000000 */
	
	ldr r2, =bss_start      /* bss�ε���ʼ���ӵ�ַ */
	
	sub r2, r2, r1
	
	cmp r0,r1
	beq clean_bss
	
	bl copy2ddr

	cmp r0, #0
	bne halt
		
	/* ��BSS */
/* ��BSS�ζ�Ӧ���ڴ����� */
clean_bss:
	ldr r0, =bss_start
	ldr r1, =bss_end
	mov r3, #0
	cmp r0, r1
	beq on_ddr
clean_loop:
	str r3, [r0], #4
	cmp r0, r1	
	bne clean_loop		

on_ddr:
	ldr pc, =main
halt:
	b halt	