
.globl _start	/*ȫ������*/
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
/* ����GPKCON��GPK4��Ϊ�������*/
	ldr r1, =0x7F008800
	mov r0, #0x10000    @0000 0000 0000 0001 0000 0000 0000 0000=0x1000
	str r0, [r1]	

/* ����GPMDAT��GPK4���0 */
	ldr r1, =0x7F008808
	mov r0, #0
	str r0, [r1]

halt:
	b halt	