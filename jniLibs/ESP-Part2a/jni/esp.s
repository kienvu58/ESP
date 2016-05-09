	.arch armv5t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.arm
	.syntax divided
	.file	"esp.c"
	.text
	.align	2
	.global	EDD_schedule
	.type	EDD_schedule, %function
EDD_schedule:
	@ args = 8, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r7, r3
	mov	r3, r3, asl #4
	add	fp, sp, #32
	add	r3, r3, #8
	sub	sp, sp, #28
	sub	ip, r7, #1
	sub	sp, sp, r3
	cmp	r7, #0
	str	sp, [fp, #-60]
	str	ip, [fp, #-56]
	ble	.L2
	sub	r1, r1, #4
	sub	r2, r2, #4
	add	r5, r0, r7, lsl #2
	add	r3, sp, #4
.L3:
	ldr	r4, [r0], #4
	ldr	lr, [r1, #4]!
	ldr	ip, [r2, #4]!
	cmp	r0, r5
	stmda	r3, {r4, lr}
	str	ip, [r3, #4]
	add	r3, r3, #16
	bne	.L3
	ldr	r3, [fp, #-56]
	cmp	r3, #0
	ble	.L10
.L12:
	ldr	r3, [fp, #-60]
	mov	r10, #0
	mov	r8, r3
	add	r9, r3, #8
.L6:
	add	r10, r10, #1
	cmp	r7, r10
	movgt	r5, r8
	movgt	r6, r10
	ble	.L9
.L5:
	ldr	r2, [r8, #8]
	ldr	r3, [r5, #24]
	add	ip, r5, #16
	cmp	r2, r3
	ble	.L8
	sub	lr, r9, #8
	sub	r4, fp, #52
	ldmia	lr, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	ldmia	r4, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
.L8:
	add	r6, r6, #1
	cmp	r7, r6
	mov	r5, ip
	bne	.L5
.L9:
	ldr	r3, [fp, #-56]
	add	r8, r8, #16
	cmp	r3, r10
	add	r9, r9, #16
	bgt	.L6
	cmp	r7, #0
	ble	.L11
.L10:
	ldr	r3, [fp, #-60]
	ldmib	r3, {r1, r3}
	cmp	r1, r3
	bgt	.L23
	ldr	r3, [fp, #-60]
	mov	r0, r1
	mov	r2, #0
	b	.L15
.L16:
	ldr	lr, [r3, #20]
	add	r3, r3, #16
	ldr	ip, [r3, #8]
	add	r0, r0, lr
	cmp	r0, ip
	bgt	.L23
.L15:
	add	r2, r2, #1
	cmp	r7, r2
	bgt	.L16
	mov	lr, #0
	ldr	r3, [fp, #8]
	mov	r2, r1
	str	r0, [r3]
	ldr	r3, [fp, #-60]
	ldr	r4, [fp, #4]
	add	ip, r3, #20
	mov	r3, lr
.L20:
	cmp	r2, #0
	ble	.L19
	add	r0, r2, r3
	ldr	r2, [ip, #-20]
	add	r3, r4, r3, lsl #2
	add	r1, r4, r0, lsl #2
.L18:
	str	r2, [r3], #4
	cmp	r1, r3
	bne	.L18
	mov	r3, r0
.L19:
	add	lr, lr, #1
	cmp	r7, lr
	add	ip, ip, #16
	ble	.L24
	ldr	r2, [ip, #-16]
	b	.L20
.L23:
	mov	r0, #0
.L35:
	sub	sp, fp, #32
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L24:
	mov	r0, #1
	sub	sp, fp, #32
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L2:
	sub	r3, r7, #1
	cmp	r3, #0
	bgt	.L12
.L11:
	mov	r3, #0
	ldr	r2, [fp, #8]
	mov	r0, #1
	str	r3, [r2]
	b	.L35
	.size	EDD_schedule, .-EDD_schedule
	.global	__aeabi_idivmod
	.align	2
	.global	gcd
	.type	gcd, %function
gcd:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	subs	r4, r0, #0
	mov	r0, r1
	bne	.L42
	b	.L48
.L43:
	mov	r4, r1
.L42:
	mov	r1, r4
	bl	__aeabi_idivmod
	cmp	r1, #0
	mov	r0, r4
	bne	.L43
	ldmfd	sp!, {r4, pc}
.L48:
	ldmfd	sp!, {r4, pc}
	.size	gcd, .-gcd
	.global	__aeabi_idiv
	.global	__aeabi_i2d
	.global	__aeabi_dadd
	.global	__aeabi_dsub
	.global	__aeabi_dmul
	.global	__aeabi_dcmplt
	.align	2
	.global	RM_schedule
	.type	RM_schedule, %function
RM_schedule:
	@ args = 8, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, r3
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, lr}
	add	fp, sp, #32
	sub	sp, sp, #36
	str	r3, [fp, #-64]
	mov	r3, r3, asl #4
	add	r3, r3, #8
	sub	sp, sp, r3
	cmp	ip, #0
	mov	r8, sp
	ldr	r4, [fp, #8]
	ble	.L50
	sub	r9, r1, #4
	mov	r4, r9
	mov	r6, r0
	mov	r8, #0
	mov	r9, #0
	sub	r7, r2, #4
	add	r10, r0, ip, lsl #2
	add	r5, sp, #4
	str	sp, [fp, #-68]
.L51:
	ldr	r2, [r4, #4]!
	ldr	r3, [r7, #4]!
	ldr	ip, [r6], #4
	str	r2, [r5]
	str	r3, [r5, #8]
	str	ip, [r5, #-4]
	mov	r0, r2
	mov	r1, r3
	bl	__aeabi_idiv
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, r8
	mov	r1, r9
	bl	__aeabi_dadd
	cmp	r6, r10
	mov	r8, r0
	mov	r9, r1
	add	r5, r5, #16
	bne	.L51
	ldr	r5, [fp, #-64]
	mov	r0, #1
	mov	r1, r5
	str	r8, [fp, #-60]
	str	r9, [fp, #-56]
	bl	__aeabi_idiv
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, #0
	mov	r1, #1073741824
	ldr	r8, [fp, #-68]
	ldr	r4, [fp, #8]
	bl	pow
	mov	r6, r0
	mov	r0, r5
	mov	r7, r1
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r9, r0
	mov	r10, r1
	ldr	r3, .L103
	mov	r0, r6
	mov	r1, r7
	bl	__aeabi_dsub
	mov	r2, r0
	mov	r3, r1
	mov	r0, r9
	mov	r1, r10
	bl	__aeabi_dmul
	sub	r3, fp, #60
	ldmia	r3, {r2-r3}
	bl	__aeabi_dcmplt
	cmp	r0, #0
	bne	.L53
	str	r8, [fp, #-60]
	mov	r9, r8
	add	r10, r8, #12
	str	r8, [fp, #-68]
	mov	r8, r0
	ldr	r7, [fp, #-64]
	add	r8, r8, #1
	cmp	r7, r8
	str	r4, [fp, #8]
	ble	.L76
.L101:
	mov	r5, r9
	mov	r6, r8
.L57:
	ldr	r2, [r9, #12]
	ldr	r3, [r5, #28]
	add	ip, r5, #16
	cmp	r2, r3
	ble	.L56
	sub	lr, r10, #12
	sub	r4, fp, #52
	ldmia	lr, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	ldmia	r4, {r0, r1, r2, r3}
	stmia	ip, {r0, r1, r2, r3}
.L56:
	add	r6, r6, #1
	cmp	r7, r6
	mov	r5, ip
	bne	.L57
	add	r8, r8, #1
	cmp	r7, r8
	add	r9, r9, #16
	add	r10, r10, #16
	bgt	.L101
.L76:
	mov	r5, #1
	mov	r6, #0
	ldr	r4, [fp, #8]
	ldr	r7, [fp, #-60]
	ldr	r10, [fp, #-64]
.L55:
	cmp	r5, #0
	ldr	r9, [r7, #12]
	beq	.L77
	mov	r8, r5
	mov	r0, r9
	b	.L60
.L78:
	mov	r8, r1
.L60:
	mov	r1, r8
	bl	__aeabi_idivmod
	cmp	r1, #0
	mov	r0, r8
	bne	.L78
.L59:
	mul	r0, r5, r9
	mov	r1, r8
	bl	__aeabi_idiv
	add	r6, r6, #1
	cmp	r10, r6
	str	r0, [r4]
	add	r7, r7, #16
	mov	r5, r0
	bne	.L55
	cmp	r0, #0
	ldr	r8, [fp, #-68]
	ble	.L63
.L75:
	mov	r3, #0
	mvn	r1, #0
	ldr	r2, [fp, #4]
	sub	r2, r2, #4
.L62:
	str	r1, [r2, #4]!
	ldr	r0, [r4]
	add	r3, r3, #1
	cmp	r0, r3
	bgt	.L62
	ldr	r3, [fp, #-64]
	cmp	r3, #0
	ble	.L71
.L63:
	mov	r10, r8
	mov	r5, #0
.L72:
	cmp	r0, #0
	ble	.L68
	ldr	r7, [r10, #12]
	ldr	r6, [fp, #4]
	mov	ip, r7
	mov	r3, r7, asl #2
	str	r3, [fp, #-60]
.L73:
	rsb	r3, r7, ip
	cmp	r3, r0
	bge	.L98
	ldr	lr, [r10, #4]
	cmp	lr, #0
	ble	.L98
	cmp	ip, #0
	mov	r9, ip
	movgt	r1, r6
	movgt	r2, #0
	bgt	.L67
	b	.L66
.L102:
	cmp	r2, lr
	bge	.L66
	cmp	r2, ip
	bge	.L66
.L67:
	ldr	r0, [r1], #4
	add	r3, r3, #1
	cmn	r0, #1
	ldreq	r0, [r8, r5, asl #4]
	addeq	r2, r2, #1
	streq	r0, [r1, #-4]
	ldr	r0, [r4]
	cmp	r0, r3
	bgt	.L102
.L66:
	ldr	r3, [fp, #-60]
	cmp	r9, r0
	add	ip, ip, r7
	add	r6, r6, r3
	blt	.L73
.L68:
	ldr	r3, [fp, #-64]
	add	r5, r5, #1
	cmp	r3, r5
	add	r10, r10, #16
	ble	.L71
	ldr	r0, [r4]
	b	.L72
.L98:
	mov	r9, ip
	b	.L66
.L71:
	mov	r0, #1
	sub	sp, fp, #32
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L77:
	mov	r8, r9
	b	.L59
.L50:
	ldr	r5, [fp, #-64]
	mov	r0, #1
	mov	r1, r5
	bl	__aeabi_idiv
	bl	__aeabi_i2d
	mov	r2, r0
	mov	r3, r1
	mov	r0, #0
	mov	r1, #1073741824
	bl	pow
	mov	r6, r0
	mov	r0, r5
	mov	r7, r1
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r9, r0
	mov	r10, r1
	ldr	r3, .L103
	mov	r0, r6
	mov	r1, r7
	bl	__aeabi_dsub
	mov	r2, r0
	mov	r3, r1
	mov	r0, r9
	mov	r1, r10
	bl	__aeabi_dmul
	mov	r3, #0
	mov	r2, #0
	bl	__aeabi_dcmplt
	cmp	r0, #0
	moveq	r3, #1
	streq	r3, [r4]
	beq	.L75
.L53:
	mov	r0, #0
	sub	sp, fp, #32
	@ sp needed
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, r10, fp, pc}
.L104:
	.align	2
.L103:
	.word	1072693248
	.size	RM_schedule, .-RM_schedule
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu1) 5.2.1 20151010"
	.section	.note.GNU-stack,"",%progbits
