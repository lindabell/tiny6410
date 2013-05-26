.globl _start
_start:
/* Ӳ����ص����� */
    /* Peri port setup */
    ldr r0, =0x70000000
    orr r0, r0, #0x13
    mcr p15,0,r0,c15,c2,4       @ 256M(0x70000000-0x7fffffff)
    
/* �ؿ��Ź� */
/* ��WTCON(0x7E004000)д0 */
	
	ldr r0, =0x7E004000  /* αָ�� */
	mov r1, #0
	str r1, [r0]

/*����ʱ��*/
//	bl clock_init //ʹ�ú����clock_init_c����ʼ��ʱ��
	
	
/* Ϊ����C����׼������ */
	ldr sp, =8*1024+0x50000000
	bl clock_init_c
	bl sdram_init

/* �ض�λ���� */
/* �ѳ���Ĵ���Ρ����ݶθ��Ƶ��������ӵ�ַȥ */	
	adr r0, _start   	/* ���_startָ�ǰ���ڵĵ�ַ : 0*/
	ldr r1, =_start  	/* _start�����ӵ�ַ 0x50000000 */
	
	ldr r2, =bss_start	/* bss�ε���ʼ���ӵ�ַ */
	
	cmp r0,r1
	beq clean_bss
	
copy_loop:				/*�������뵽���ӵ�ַȥ*/
	ldr r3, [r0], #4
	str r3, [r1], #4
	cmp r1, r2
	bne copy_loop	


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
/* ����C���� */
	ldr pc, =main  /* pc����main�����ӵ�ַ */
