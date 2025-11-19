	.text
	.file	"halide_buffer_t.cpp"
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4                               # -- Begin function random_pipeline_par_for_repeat_edge__6_s0__0
.LCPI0_0:
	.quad	3                               # 0x3
	.quad	2                               # 0x2
.LCPI0_2:
	.quad	1                               # 0x1
	.quad	2                               # 0x2
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5
.LCPI0_1:
	.quad	7                               # 0x7
	.quad	6                               # 0x6
	.quad	5                               # 0x5
	.quad	4                               # 0x4
.LCPI0_3:
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	4294967295                      # 0xffffffff
	.long	0                               # 0x0
	.section	.text.random_pipeline_par_for_repeat_edge__6_s0__0,"ax",@progbits
	.globl	random_pipeline_par_for_repeat_edge__6_s0__0
	.p2align	4, 0x90
	.type	random_pipeline_par_for_repeat_edge__6_s0__0,@function
random_pipeline_par_for_repeat_edge__6_s0__0: # @random_pipeline_par_for_repeat_edge__6_s0__0
# %bb.0:                                # %entry
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	(%rdx), %r15
	movq	8(%rdx), %r8
	movslq	20(%rdx), %rcx
	movslq	24(%rdx), %r10
	movslq	36(%rdx), %rax
	movslq	40(%rdx), %r14
	cmpl	%esi, 28(%rdx)
	jg	.LBB0_3
# %bb.1:                                # %entry
	cmpl	%esi, 32(%rdx)
	jle	.LBB0_3
# %bb.2:                                # %then_bb
	movslq	%esi, %r13
	vmovq	%rax, %xmm0
	vpbroadcastq	%xmm0, %ymm0
	vmovdqa	.LCPI0_2(%rip), %xmm1           # xmm1 = [1,2]
	vpcmpgtq	%xmm0, %xmm1, %xmm2
	vblendvpd	%xmm2, %xmm0, %xmm1, %xmm1
	addq	%r13, %r14
	vpcmpeqd	%xmm2, %xmm2, %xmm2
	vpaddq	%xmm2, %xmm1, %xmm2
	vmovq	%rcx, %xmm1
	vpbroadcastq	%xmm1, %ymm1
	vpcmpgtq	%xmm1, %xmm2, %xmm3
	vblendvpd	%xmm3, %xmm2, %xmm1, %xmm2
	vmovq	%r10, %xmm3
	vpbroadcastq	%xmm3, %xmm3
	vpsrlq	$32, %xmm3, %xmm4
	vpmuludq	%xmm4, %xmm2, %xmm4
	vpsrlq	$32, %xmm2, %xmm5
	vpmuludq	%xmm3, %xmm5, %xmm5
	vpaddq	%xmm5, %xmm4, %xmm4
	vpsllq	$32, %xmm4, %xmm4
	vpmuludq	%xmm3, %xmm2, %xmm2
	vmovq	%r14, %xmm3
	vpbroadcastq	%xmm3, %xmm3
	vpaddq	%xmm3, %xmm2, %xmm2
	vpaddq	%xmm2, %xmm4, %xmm2
	vmovq	%xmm2, %rdx
	vpextrq	$1, %xmm2, %rdi
	leaq	(%r15,%rdx,4), %r9
	leaq	(%r15,%rdi,4), %r11
	cmpq	$3, %rax
	movl	$3, %edx
	cmovlq	%rax, %rdx
	decq	%rdx
	cmpq	%rcx, %rdx
	cmovleq	%rcx, %rdx
	imulq	%r10, %rdx
	addq	%r14, %rdx
	vmovdqa	.LCPI0_1(%rip), %ymm2           # ymm2 = [7,6,5,4]
	vpcmpgtq	%ymm0, %ymm2, %ymm3
	vblendvpd	%ymm3, %ymm0, %ymm2, %ymm0
	leaq	(%r15,%rdx,4), %r12
	vpcmpeqd	%ymm2, %ymm2, %ymm2
	vpaddq	%ymm2, %ymm0, %ymm0
	vpcmpgtq	%ymm1, %ymm0, %ymm1
	vmovmskpd	%ymm1, %edi
	vextracti128	$1, %ymm0, %xmm1
	vpextrq	$1, %xmm1, %rax
	testb	$8, %dil
	cmoveq	%rcx, %rax
	imulq	%r10, %rax
	addq	%r14, %rax
	leaq	(%r15,%rax,4), %rax
	vmovq	%xmm1, %rbx
	testb	$4, %dil
	cmoveq	%rcx, %rbx
	imulq	%r10, %rbx
	addq	%r14, %rbx
	leaq	(%r15,%rbx,4), %rbx
	vpextrq	$1, %xmm0, %rdx
	testb	$2, %dil
	cmoveq	%rcx, %rdx
	imulq	%r10, %rdx
	addq	%r14, %rdx
	vmovq	%xmm0, %rsi
	testb	$1, %dil
	cmoveq	%rcx, %rsi
	leaq	(%r15,%rdx,4), %rcx
	imulq	%r10, %rsi
	addq	%r14, %rsi
	leaq	(%r15,%rsi,4), %rdi
	jmp	.LBB0_4
.LBB0_3:                                # %next_bb
	movslq	44(%rdx), %rbx
	testq	%rax, %rax
	movl	$1, %edi
	cmovleq	%rax, %rdi
	decq	%rdi
	cmpq	%rcx, %rdi
	cmovleq	%rcx, %rdi
	imulq	%r10, %rdi
	decq	%rbx
	movslq	%esi, %r13
	cmpq	%r13, %rbx
	cmovgeq	%r13, %rbx
	movslq	16(%rdx), %rdx
	cmpq	%rdx, %rbx
	cmovleq	%rdx, %rbx
	addq	%r14, %rbx
	vmovq	%rax, %xmm0
	vpbroadcastq	%xmm0, %ymm0
	vmovdqa	.LCPI0_0(%rip), %xmm1           # xmm1 = [3,2]
	vpcmpgtq	%xmm0, %xmm1, %xmm2
	vblendvpd	%xmm2, %xmm0, %xmm1, %xmm1
	addq	%rbx, %rdi
	vpcmpeqd	%xmm2, %xmm2, %xmm2
	vpaddq	%xmm2, %xmm1, %xmm1
	vmovq	%rcx, %xmm2
	vpbroadcastq	%xmm2, %ymm2
	vpcmpgtq	%xmm2, %xmm1, %xmm3
	vpextrq	$1, %xmm1, %rax
	vmovmskpd	%xmm3, %edx
	testb	$2, %dl
	cmoveq	%rcx, %rax
	leaq	(%r15,%rdi,4), %r9
	imulq	%r10, %rax
	addq	%rbx, %rax
	leaq	(%r15,%rax,4), %r11
	vmovq	%xmm1, %rax
	testb	$1, %dl
	cmoveq	%rcx, %rax
	imulq	%r10, %rax
	addq	%rbx, %rax
	leaq	(%r15,%rax,4), %r12
	vmovdqa	.LCPI0_1(%rip), %ymm1           # ymm1 = [7,6,5,4]
	vpcmpgtq	%ymm0, %ymm1, %ymm3
	vblendvpd	%ymm3, %ymm0, %ymm1, %ymm0
	vpcmpeqd	%ymm1, %ymm1, %ymm1
	vpaddq	%ymm1, %ymm0, %ymm0
	vpcmpgtq	%ymm2, %ymm0, %ymm1
	vblendvpd	%ymm1, %ymm0, %ymm2, %ymm0
	vmovq	%r10, %xmm1
	vpbroadcastq	%xmm1, %ymm1
	vpsrlq	$32, %ymm1, %ymm2
	vpmuludq	%ymm2, %ymm0, %ymm2
	vpsrlq	$32, %ymm0, %ymm3
	vpmuludq	%ymm1, %ymm3, %ymm3
	vpaddq	%ymm3, %ymm2, %ymm2
	vpsllq	$32, %ymm2, %ymm2
	vpmuludq	%ymm1, %ymm0, %ymm0
	vmovq	%rbx, %xmm1
	vpbroadcastq	%xmm1, %ymm1
	vpaddq	%ymm1, %ymm0, %ymm0
	vpaddq	%ymm0, %ymm2, %ymm0
	vextracti128	$1, %ymm0, %xmm1
	vpextrq	$1, %xmm1, %rax
	leaq	(%r15,%rax,4), %rax
	vmovq	%xmm1, %rcx
	vpextrq	$1, %xmm0, %rdx
	leaq	(%r15,%rcx,4), %rbx
	leaq	(%r15,%rdx,4), %rcx
	vmovq	%xmm0, %rdx
	leaq	(%r15,%rdx,4), %rdi
.LBB0_4:                                # %destructor_block
	vmovd	(%rbx), %xmm0                   # xmm0 = mem[0],zero,zero,zero
	vpinsrd	$1, (%rcx), %xmm0, %xmm0
	vpinsrd	$2, (%rdi), %xmm0, %xmm0
	vmovd	(%r9), %xmm1                    # xmm1 = mem[0],zero,zero,zero
	vpinsrd	$1, (%r11), %xmm1, %xmm1
	vpinsrd	$2, (%r12), %xmm1, %xmm1
	vpinsrd	$3, (%rax), %xmm1, %xmm1
	vinserti128	$1, %xmm0, %ymm1, %ymm0
	leaq	(,%r13,8), %rax
	addq	%r13, %rax
	leaq	(%rax,%rax,2), %rax
	addq	%r13, %rax
	vmovdqa	.LCPI0_3(%rip), %ymm1           # ymm1 = [4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,4294967295,0]
	vpmaskmovd	%ymm0, %ymm1, (%r8,%rax)
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	vzeroupper
	retq
.Lfunc_end0:
	.size	random_pipeline_par_for_repeat_edge__6_s0__0, .Lfunc_end0-random_pipeline_par_for_repeat_edge__6_s0__0
                                        # -- End function
	.section	.text.random_pipeline_par_for_sum__3_s0__1__1,"ax",@progbits
	.globl	random_pipeline_par_for_sum__3_s0__1__1 # -- Begin function random_pipeline_par_for_sum__3_s0__1__1
	.p2align	4, 0x90
	.type	random_pipeline_par_for_sum__3_s0__1__1,@function
random_pipeline_par_for_sum__3_s0__1__1: # @random_pipeline_par_for_sum__3_s0__1__1
# %bb.0:                                # %entry
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movl	12(%rdx), %r14d
	testl	%r14d, %r14d
	jle	.LBB1_5
# %bb.1:                                # %"for sum$3.s0._2.us.preheader"
	movq	(%rdx), %rax
	movl	16(%rdx), %ecx
	addl	$8, %ecx
	movslq	8(%rdx), %rdi
	imull	%ecx, %esi
	shll	$3, %esi
	movslq	%esi, %rdx
	movslq	%ecx, %r12
	shlq	$5, %r14
	leaq	(%rax,%rdx,4), %r13
	shlq	$2, %rdi
	movq	%rdi, (%rsp)                    # 8-byte Spill
	shlq	$2, %r12
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB1_2:                                # %"for sum$3.s0._2.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_3 Depth 2
	movl	$8, %r15d
	movq	%r13, %rbx
	.p2align	4, 0x90
.LBB1_3:                                # %"for sum$3.s0._1._1i.us.us"
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
	addq	%r12, %rbx
	decq	%r15
	jne	.LBB1_3
# %bb.4:                                # %"end for sum$3.s0._1._1i.split.us.us"
                                        #   in Loop: Header=BB1_2 Depth=1
	incq	%rbp
	addq	(%rsp), %r13                    # 8-byte Folded Reload
	cmpq	$4, %rbp
	jne	.LBB1_2
.LBB1_5:                                # %destructor_block
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end1:
	.size	random_pipeline_par_for_sum__3_s0__1__1, .Lfunc_end1-random_pipeline_par_for_sum__3_s0__1__1
                                        # -- End function
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5                               # -- Begin function random_pipeline_par_for_sum__3_s1__1__1
.LCPI2_0:
	.long	0                               # 0x0
	.long	1                               # 0x1
	.long	2                               # 0x2
	.long	3                               # 0x3
	.long	4                               # 0x4
	.long	5                               # 0x5
	.long	6                               # 0x6
	.long	7                               # 0x7
.LCPI2_3:
	.byte	0                               # 0x0
	.byte	1                               # 0x1
	.byte	4                               # 0x4
	.byte	5                               # 0x5
	.byte	8                               # 0x8
	.byte	9                               # 0x9
	.byte	12                              # 0xc
	.byte	13                              # 0xd
	.byte	8                               # 0x8
	.byte	9                               # 0x9
	.byte	12                              # 0xc
	.byte	13                              # 0xd
	.byte	12                              # 0xc
	.byte	13                              # 0xd
	.byte	14                              # 0xe
	.byte	15                              # 0xf
	.byte	16                              # 0x10
	.byte	17                              # 0x11
	.byte	20                              # 0x14
	.byte	21                              # 0x15
	.byte	24                              # 0x18
	.byte	25                              # 0x19
	.byte	28                              # 0x1c
	.byte	29                              # 0x1d
	.byte	24                              # 0x18
	.byte	25                              # 0x19
	.byte	28                              # 0x1c
	.byte	29                              # 0x1d
	.byte	28                              # 0x1c
	.byte	29                              # 0x1d
	.byte	30                              # 0x1e
	.byte	31                              # 0x1f
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI2_1:
	.long	7                               # 0x7
.LCPI2_2:
	.long	255                             # 0xff
	.section	.text.random_pipeline_par_for_sum__3_s1__1__1,"ax",@progbits
	.globl	random_pipeline_par_for_sum__3_s1__1__1
	.p2align	4, 0x90
	.type	random_pipeline_par_for_sum__3_s1__1__1,@function
random_pipeline_par_for_sum__3_s1__1__1: # @random_pipeline_par_for_sum__3_s1__1__1
# %bb.0:                                # %entry
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$488, %rsp                      # imm = 0x1E8
                                        # kill: def $esi killed $esi def $rsi
	movq	%rdi, (%rsp)                    # 8-byte Spill
	movl	$2147483648, %r9d               # imm = 0x80000000
	movq	(%rdx), %rbp
	movl	28(%rdx), %ecx
	movl	144(%rdx), %eax
	leal	(,%rsi,8), %edi
	movq	%rcx, 248(%rsp)                 # 8-byte Spill
	movl	%ecx, %ebx
	movq	%rdi, %rcx
	movq	%rdi, 224(%rsp)                 # 8-byte Spill
	subl	%edi, %ebx
	cmpl	$8, %ebx
	movl	$8, %edi
	cmovll	%ebx, %edi
	leal	8(%rax), %ecx
	movl	%ecx, 136(%rsp)                 # 4-byte Spill
	imull	%edi, %ecx
	movl	%ecx, 172(%rsp)                 # 4-byte Spill
	cmpl	$-7, %eax
	movl	$-8, %ecx
	cmovgel	%eax, %ecx
	xorl	%r8d, %r8d
	movl	%ebx, 20(%rsp)                  # 4-byte Spill
	testl	%ebx, %ebx
	movl	%edi, 76(%rsp)                  # 4-byte Spill
	cmovgl	%edi, %r8d
	leal	8(%rcx), %ebx
	movq	%rbx, %r13
	imulq	%r8, %r13
	leal	32(,%rcx,4), %eax
	imulq	%r8, %rax
	shrq	$32, %rax
	shrq	$30, %rbx
	imulq	%r8, %rbx
	addq	%rax, %rbx
	leaq	(,%r13,4), %rax
	leaq	(%rax,%rax,2), %r10
	movq	8(%rdx), %rcx
	movq	%rcx, 432(%rsp)                 # 8-byte Spill
	movq	16(%rdx), %rcx
	movq	%rcx, 336(%rsp)                 # 8-byte Spill
	movl	24(%rdx), %r12d
	movl	32(%rdx), %eax
	movq	%rax, 96(%rsp)                  # 8-byte Spill
	movl	36(%rdx), %eax
	movq	%rax, 240(%rsp)                 # 8-byte Spill
	movl	40(%rdx), %eax
	movl	%eax, 204(%rsp)                 # 4-byte Spill
	movslq	44(%rdx), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movslq	48(%rdx), %rax
	movq	%rax, 232(%rsp)                 # 8-byte Spill
	movslq	52(%rdx), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movslq	56(%rdx), %rax
	movq	%rax, 216(%rsp)                 # 8-byte Spill
	movslq	60(%rdx), %rcx
	movq	%rcx, 440(%rsp)                 # 8-byte Spill
	movslq	68(%rdx), %rax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movl	84(%rdx), %r14d
	movslq	88(%rdx), %r15
	movl	92(%rdx), %eax
	movq	%rax, 384(%rsp)                 # 8-byte Spill
	movslq	96(%rdx), %rcx
	movq	%rcx, 192(%rsp)                 # 8-byte Spill
	movl	100(%rdx), %eax
	movl	104(%rdx), %r11d
	movl	108(%rdx), %ecx
	movq	%rcx, 104(%rsp)                 # 8-byte Spill
	movl	112(%rdx), %ecx
	movq	%rcx, 272(%rsp)                 # 8-byte Spill
	movl	120(%rdx), %ecx
	movl	124(%rdx), %edi
	movq	%rdi, 264(%rsp)                 # 8-byte Spill
	movslq	128(%rdx), %rdi
	movq	%rdi, 152(%rsp)                 # 8-byte Spill
	movl	132(%rdx), %edi
	movl	%edi, 176(%rsp)                 # 4-byte Spill
	movl	148(%rdx), %edi
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
	leal	(,%r13,4), %edi
	movq	%rdi, 360(%rsp)                 # 8-byte Spill
	cmpl	%esi, 64(%rdx)
	movq	%r8, 160(%rsp)                  # 8-byte Spill
	movl	%ecx, 260(%rsp)                 # 4-byte Spill
	movq	%r11, 400(%rsp)                 # 8-byte Spill
	movq	%r15, 208(%rsp)                 # 8-byte Spill
	movq	%rax, 392(%rsp)                 # 8-byte Spill
	movq	%r14, 376(%rsp)                 # 8-byte Spill
	movq	%rbx, 368(%rsp)                 # 8-byte Spill
	movq	%r13, 296(%rsp)                 # 8-byte Spill
	jle	.LBB2_202
# %bb.1:                                # %then_bb
	cmpq	%r9, %r10
	jae	.LBB2_389
# %bb.2:                                # %"assert succeeded"
	movl	72(%rdx), %eax
	movq	%rax, 408(%rsp)                 # 8-byte Spill
	movl	76(%rdx), %eax
	movq	%rax, 320(%rsp)                 # 8-byte Spill
	movl	80(%rdx), %eax
	movq	%rax, 416(%rsp)                 # 8-byte Spill
	movl	116(%rdx), %eax
	movl	%eax, 344(%rsp)                 # 4-byte Spill
	movl	136(%rdx), %eax
	movq	%rax, 184(%rsp)                 # 8-byte Spill
	movl	140(%rdx), %eax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movl	152(%rdx), %eax
	movl	%eax, 40(%rsp)                  # 4-byte Spill
	movb	156(%rdx), %al
	movb	%al, 183(%rsp)                  # 1-byte Spill
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r10, %rsi
	callq	halide_malloc@PLT
	movq	%rax, %r13
	cmpq	$0, 296(%rsp)                   # 8-byte Folded Reload
	je	.LBB2_4
# %bb.3:                                # %"assert succeeded"
	testq	%r13, %r13
	je	.LBB2_393
.LBB2_4:                                # %"assert succeeded2"
	movq	224(%rsp), %rax                 # 8-byte Reload
	movq	240(%rsp), %rcx                 # 8-byte Reload
	addl	%ecx, %eax
	movl	%eax, 312(%rsp)                 # 4-byte Spill
	cltq
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	cmpl	$0, 184(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_13
# %bb.5:                                # %"for constant_exterior.s0._2.preheader"
	movq	152(%rsp), %rax                 # 8-byte Reload
	decq	%rax
	movq	%rax, 288(%rsp)                 # 8-byte Spill
	movq	264(%rsp), %rcx                 # 8-byte Reload
	vmovd	%ecx, %xmm0
	vpbroadcastd	%xmm0, %ymm11
	movq	96(%rsp), %rax                  # 8-byte Reload
	leal	-6(%rax), %edx
	vmovd	204(%rsp), %xmm1                # 4-byte Folded Reload
                                        # xmm1 = mem[0],zero,zero,zero
	vpbroadcastd	%xmm1, %ymm1
	leal	-1(%rcx), %eax
	vmovd	%eax, %xmm2
	vpbroadcastd	%xmm2, %ymm12
	movq	8(%rsp), %rax                   # 8-byte Reload
	leaq	-1(%rax), %rsi
	movslq	136(%rsp), %rax                 # 4-byte Folded Reload
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movl	76(%rsp), %eax                  # 4-byte Reload
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movslq	172(%rsp), %rax                 # 4-byte Folded Reload
	movq	%rax, 328(%rsp)                 # 8-byte Spill
	xorl	%ecx, %ecx
	vmovdqa	.LCPI2_0(%rip), %ymm9           # ymm9 = [0,1,2,3,4,5,6,7]
	vpcmpeqd	%ymm10, %ymm10, %ymm10
	vbroadcastss	.LCPI2_1(%rip), %ymm13  # ymm13 = [7,7,7,7,7,7,7,7]
	.p2align	4, 0x90
.LBB2_6:                                # %"for constant_exterior.s0._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_9 Depth 2
                                        #       Child Loop BB2_10 Depth 3
	movq	288(%rsp), %rax                 # 8-byte Reload
	cmpq	%rax, %rcx
	movq	%rcx, 144(%rsp)                 # 8-byte Spill
	movl	%ecx, %r11d
	cmovgl	%eax, %r11d
	movq	232(%rsp), %rax                 # 8-byte Reload
	cmpl	%eax, %r11d
	cmovlel	%eax, %r11d
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_12
# %bb.7:                                # %"for constant_exterior.s0._1.rebased.preheader"
                                        #   in Loop: Header=BB2_6 Depth=1
	movq	144(%rsp), %rax                 # 8-byte Reload
	cmpq	232(%rsp), %rax                 # 8-byte Folded Reload
	setl	%bl
	cmpq	152(%rsp), %rax                 # 8-byte Folded Reload
	setge	56(%rsp)                        # 1-byte Folded Spill
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_12
# %bb.8:                                # %"for constant_exterior.s0._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_6 Depth=1
	movq	144(%rsp), %rax                 # 8-byte Reload
	imulq	328(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	imull	216(%rsp), %r11d                # 4-byte Folded Reload
	subl	176(%rsp), %r11d                # 4-byte Folded Reload
	orb	%bl, 56(%rsp)                   # 1-byte Folded Spill
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB2_9:                                # %"for constant_exterior.s0._1.rebased.us"
                                        #   Parent Loop BB2_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_10 Depth 3
	movq	%r9, %r14
	imulq	48(%rsp), %r14                  # 8-byte Folded Reload
	addq	80(%rsp), %r14                  # 8-byte Folded Reload
	movq	64(%rsp), %rax                  # 8-byte Reload
	leaq	(%r9,%rax), %rbx
	movq	24(%rsp), %rax                  # 8-byte Reload
	cmpq	%rax, %rbx
	setl	%dil
	cmpq	8(%rsp), %rbx                   # 8-byte Folded Reload
	setge	%cl
	orb	56(%rsp), %dil                  # 1-byte Folded Reload
	orb	%cl, %dil
	vmovd	%edi, %xmm6
	vpbroadcastb	%xmm6, %xmm6
	cmpq	%rsi, %rbx
	cmovgl	%esi, %ebx
	cmpl	%eax, %ebx
	cmovlel	%eax, %ebx
	imull	32(%rsp), %ebx                  # 4-byte Folded Reload
	addl	%r11d, %ebx
	vmovd	%ebx, %xmm7
	vpbroadcastd	%xmm7, %ymm7
	movl	$4, %r10d
	movq	112(%rsp), %rcx                 # 8-byte Reload
	movl	%ecx, %r8d
	.p2align	4, 0x90
.LBB2_10:                               # %"for constant_exterior.s0._0._0.us"
                                        #   Parent Loop BB2_6 Depth=1
                                        #     Parent Loop BB2_9 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpl	%r10d, %r12d
	movl	%r12d, %r15d
	cmovgl	%r10d, %r15d
	leal	(%rdx,%r15), %ecx
	vmovd	%ecx, %xmm3
	vpbroadcastd	%xmm3, %ymm3
	vpaddd	%ymm3, %ymm9, %ymm8
	vpminsd	%ymm8, %ymm12, %ymm3
	vpmaxsd	%ymm1, %ymm3, %ymm3
	vpaddd	%ymm7, %ymm3, %ymm3
	vextracti128	$1, %ymm3, %xmm4
	vpmovsxdq	%xmm4, %ymm4
	vpmovsxdq	%xmm3, %ymm3
	vmovq	%xmm4, %rcx
	vmovd	(%rbp,%rcx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm4, %rcx
	vextracti128	$1, %ymm4, %xmm4
	vpinsrd	$1, (%rbp,%rcx,4), %xmm0, %xmm0
	vmovq	%xmm4, %rcx
	vpinsrd	$2, (%rbp,%rcx,4), %xmm0, %xmm0
	vpextrq	$1, %xmm4, %rcx
	vpinsrd	$3, (%rbp,%rcx,4), %xmm0, %xmm0
	vmovq	%xmm3, %rcx
	vmovd	(%rbp,%rcx,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm3, %rcx
	vpinsrd	$1, (%rbp,%rcx,4), %xmm4, %xmm4
	vextracti128	$1, %ymm3, %xmm3
	vmovq	%xmm3, %rcx
	vpinsrd	$2, (%rbp,%rcx,4), %xmm4, %xmm4
	vpextrq	$1, %xmm3, %rcx
	vpinsrd	$3, (%rbp,%rcx,4), %xmm4, %xmm3
	vpcmpgtd	%ymm8, %ymm11, %ymm4
	vpxor	%ymm4, %ymm10, %ymm4
	vextracti128	$1, %ymm4, %xmm2
	vpackssdw	%xmm2, %xmm4, %xmm2
	vpcmpgtd	%ymm8, %ymm1, %ymm4
	vextracti128	$1, %ymm4, %xmm5
	vpackssdw	%xmm5, %xmm4, %xmm4
	vpor	%xmm6, %xmm4, %xmm4
	vpor	%xmm2, %xmm4, %xmm2
	vpmovzxwd	%xmm2, %ymm2            # ymm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero,xmm2[4],zero,xmm2[5],zero,xmm2[6],zero,xmm2[7],zero
	vpslld	$31, %ymm2, %ymm2
	vinserti128	$1, %xmm0, %ymm3, %ymm0
	vblendvps	%ymm2, %ymm13, %ymm0, %ymm0
	movslq	%r15d, %rcx
	addq	%r14, %rcx
	vmovups	%ymm0, -16(%r13,%rcx,4)
	addl	$8, %r10d
	decl	%r8d
	jne	.LBB2_10
# %bb.11:                               # %"end for constant_exterior.s0._0._0.loopexit.us"
                                        #   in Loop: Header=BB2_9 Depth=2
	incq	%r9
	cmpq	88(%rsp), %r9                   # 8-byte Folded Reload
	jne	.LBB2_9
.LBB2_12:                               # %"end for constant_exterior.s0._1.rebased"
                                        #   in Loop: Header=BB2_6 Depth=1
	movq	144(%rsp), %rcx                 # 8-byte Reload
	incq	%rcx
	cmpq	184(%rsp), %rcx                 # 8-byte Folded Reload
	jne	.LBB2_6
.LBB2_13:                               # %"end for constant_exterior.s0._2"
	movq	224(%rsp), %rdi                 # 8-byte Reload
	leal	8(%rdi), %eax
	movq	248(%rsp), %rcx                 # 8-byte Reload
	cmpl	%eax, %ecx
	cmovgl	%eax, %ecx
	movq	24(%rsp), %rax                  # 8-byte Reload
	movl	312(%rsp), %ebx                 # 4-byte Reload
	cmpl	%ebx, %eax
	movl	%ebx, %edx
	cmovgl	%eax, %edx
	movq	240(%rsp), %rax                 # 8-byte Reload
	leal	(%rax,%rcx), %r8d
	cmpl	%edx, %r8d
	movl	%r8d, %esi
	cmovgl	%edx, %esi
	movq	%rsi, 288(%rsp)                 # 8-byte Spill
	movq	8(%rsp), %rsi                   # 8-byte Reload
	cmpl	%edx, %esi
	cmovgl	%esi, %edx
                                        # kill: def $esi killed $esi killed $rsi
	subl	%eax, %esi
	cmpl	%edi, %esi
	cmovlel	%edi, %esi
	cmpl	$0, 408(%rsp)                   # 4-byte Folded Reload
	movl	136(%rsp), %r10d                # 4-byte Reload
	jle	.LBB2_40
# %bb.14:                               # %"for constant_exterior.s0._2.rebased.preheader"
	movslq	40(%rsp), %r9                   # 4-byte Folded Reload
	movq	24(%rsp), %rdi                  # 8-byte Reload
                                        # kill: def $edi killed $edi killed $rdi
	subl	%eax, %edi
	vmovd	8(%rsp), %xmm0                  # 4-byte Folded Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vpinsrd	$1, %edi, %xmm0, %xmm0
	vmovd	%ebx, %xmm1
	movq	224(%rsp), %rbx                 # 8-byte Reload
	vpinsrd	$1, %ebx, %xmm1, %xmm1
	vpmaxsd	%xmm1, %xmm0, %xmm0
	vmovd	%xmm0, %edi
	movl	%r8d, %eax
	subl	%edi, %eax
	vmovd	%r8d, %xmm1
	vpinsrd	$1, %ecx, %xmm1, %xmm1
	vpminsd	%xmm0, %xmm1, %xmm0
	movq	288(%rsp), %rdi                 # 8-byte Reload
	vmovd	%edi, %xmm1
	vpinsrd	$1, %ebx, %xmm1, %xmm1
	vpsubd	%xmm1, %xmm0, %xmm6
	cmpl	%esi, %ecx
	cmovgl	%esi, %ecx
	subl	%ebx, %ecx
	movq	%rcx, 248(%rsp)                 # 8-byte Spill
	cmpl	%edx, %r8d
	cmovgl	%edx, %r8d
	movl	%eax, %edx
	sarl	$31, %edx
	movl	%eax, 356(%rsp)                 # 4-byte Spill
	andnl	%eax, %edx, %eax
	movq	%rax, 472(%rsp)                 # 8-byte Spill
	movq	112(%rsp), %rdx                 # 8-byte Reload
	movl	%edx, %eax
	movq	320(%rsp), %r15                 # 8-byte Reload
	subl	%r15d, %eax
	movl	%eax, 56(%rsp)                  # 4-byte Spill
	vpxor	%xmm0, %xmm0, %xmm0
	vpcmpgtd	%xmm0, %xmm6, %xmm0
	vpmovsxdq	%xmm0, %xmm0
	vmovmskpd	%xmm0, %eax
	movl	%eax, 352(%rsp)                 # 4-byte Spill
                                        # kill: def $al killed $al killed $eax
	shrb	%al
	movb	%al, 182(%rsp)                  # 1-byte Spill
	movq	264(%rsp), %rdx                 # 8-byte Reload
	vmovd	%edx, %xmm0
	vpbroadcastd	%xmm0, %ymm11
	vmovd	204(%rsp), %xmm1                # 4-byte Folded Reload
                                        # xmm1 = mem[0],zero,zero,zero
	vpbroadcastd	%xmm1, %ymm1
	decl	%edx
	vmovd	%edx, %xmm2
	vpbroadcastd	%xmm2, %ymm12
	movl	%r15d, %edx
	subl	%r9d, %edx
	movq	96(%rsp), %rbx                  # 8-byte Reload
	movl	%ebx, %r11d
	subl	176(%rsp), %r11d                # 4-byte Folded Reload
	movslq	%edi, %rsi
	movslq	184(%rsp), %rax                 # 4-byte Folded Reload
	movslq	172(%rsp), %rcx                 # 4-byte Folded Reload
	movq	%rax, %rdi
	movq	216(%rsp), %r14                 # 8-byte Reload
	imulq	%r14, %rdi
	movq	32(%rsp), %rbx                  # 8-byte Reload
	imulq	%rbx, %rsi
	shlq	$2, %rsi
	leaq	(%rsi,%rdi,4), %rsi
	movq	%rax, %rdi
	movq	%rax, 464(%rsp)                 # 8-byte Spill
	movq	%rcx, 280(%rsp)                 # 8-byte Spill
	imulq	%rcx, %rdi
	leaq	(%rdi,%r9,8), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	shlq	$5, %r9
	addq	%rsi, %r9
	vpextrd	$1, %xmm6, %ecx
	movslq	248(%rsp), %rsi                 # 4-byte Folded Reload
	movslq	%r8d, %rax
	movq	%rax, 248(%rsp)                 # 8-byte Spill
	movslq	%r11d, %rax
	leaq	(%r9,%rax,4), %rax
	movq	%rdx, 328(%rsp)                 # 8-byte Spill
	movq	%rdx, %r8
	shlq	$5, %r8
	movq	%rcx, 80(%rsp)                  # 8-byte Spill
                                        # kill: def $ecx killed $ecx killed $rcx
	imull	%r10d, %ecx
	movl	%ecx, 348(%rsp)                 # 4-byte Spill
	addq	%rbp, %rax
	addq	$-8, %rax
	movq	%rax, 424(%rsp)                 # 8-byte Spill
	leal	4(,%r15,8), %eax
	movl	%eax, 240(%rsp)                 # 4-byte Spill
	vmovdqa	.LCPI2_0(%rip), %ymm9           # ymm9 = [0,1,2,3,4,5,6,7]
	vpcmpeqd	%ymm10, %ymm10, %ymm10
	vbroadcastss	.LCPI2_1(%rip), %ymm13  # ymm13 = [7,7,7,7,7,7,7,7]
	vmovd	%xmm6, %eax
	movq	%rax, 320(%rsp)                 # 8-byte Spill
	movq	96(%rsp), %rax                  # 8-byte Reload
	leal	-6(%rax), %r11d
	movq	%rsi, %r15
	movq	8(%rsp), %rax                   # 8-byte Reload
	decq	%rax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movslq	%r10d, %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	leaq	(,%r14,4), %rax
	movq	%rax, 448(%rsp)                 # 8-byte Spill
	leaq	(,%rbx,4), %rax
	movq	%rax, 312(%rsp)                 # 8-byte Spill
	xorl	%ecx, %ecx
	movq	%rsi, 456(%rsp)                 # 8-byte Spill
	.p2align	4, 0x90
.LBB2_15:                               # %"for constant_exterior.s0._2.rebased"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_18 Depth 2
                                        #       Child Loop BB2_19 Depth 3
                                        #     Child Loop BB2_23 Depth 2
                                        #       Child Loop BB2_25 Depth 3
                                        #       Child Loop BB2_28 Depth 3
                                        #       Child Loop BB2_31 Depth 3
                                        #     Child Loop BB2_36 Depth 2
                                        #       Child Loop BB2_37 Depth 3
	movq	464(%rsp), %rax                 # 8-byte Reload
	movq	%rcx, 480(%rsp)                 # 8-byte Spill
	addq	%rcx, %rax
	movq	%rax, 304(%rsp)                 # 8-byte Spill
	cmpb	$0, 182(%rsp)                   # 1-byte Folded Reload
	je	.LBB2_21
# %bb.16:                               # %"for constant_exterior.s0._1.rebased3.preheader"
                                        #   in Loop: Header=BB2_15 Depth=1
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_21
# %bb.17:                               # %"for constant_exterior.s0._1.rebased3.us.preheader"
                                        #   in Loop: Header=BB2_15 Depth=1
	movq	304(%rsp), %r9                  # 8-byte Reload
	movl	%r9d, %r14d
	imull	216(%rsp), %r14d                # 4-byte Folded Reload
	subl	176(%rsp), %r14d                # 4-byte Folded Reload
	imulq	280(%rsp), %r9                  # 8-byte Folded Reload
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_18:                               # %"for constant_exterior.s0._1.rebased3.us"
                                        #   Parent Loop BB2_15 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_19 Depth 3
	movq	%rcx, %rdi
	imulq	88(%rsp), %rdi                  # 8-byte Folded Reload
	addq	%r9, %rdi
	movq	64(%rsp), %rax                  # 8-byte Reload
	addq	%rcx, %rax
	movq	24(%rsp), %rbx                  # 8-byte Reload
	cmpq	%rbx, %rax
	setl	%dl
	cmpq	8(%rsp), %rax                   # 8-byte Folded Reload
	setge	%sil
	orb	%dl, %sil
	vmovd	%esi, %xmm6
	vpbroadcastb	%xmm6, %xmm6
	movq	48(%rsp), %rdx                  # 8-byte Reload
	cmpq	%rdx, %rax
	cmovgl	%edx, %eax
	cmpl	%ebx, %eax
	cmovlel	%ebx, %eax
	imull	32(%rsp), %eax                  # 4-byte Folded Reload
	addl	%r14d, %eax
	vmovd	%eax, %xmm7
	vpbroadcastd	%xmm7, %ymm7
	movl	$4, %esi
	movq	112(%rsp), %rax                 # 8-byte Reload
                                        # kill: def $eax killed $eax killed $rax
	.p2align	4, 0x90
.LBB2_19:                               # %"for constant_exterior.s0._0._06.us"
                                        #   Parent Loop BB2_15 Depth=1
                                        #     Parent Loop BB2_18 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpl	%esi, %r12d
	movl	%r12d, %edx
	cmovgl	%esi, %edx
	leal	(%r11,%rdx), %ebx
	vmovd	%ebx, %xmm3
	vpbroadcastd	%xmm3, %ymm3
	vpaddd	%ymm3, %ymm9, %ymm8
	vpminsd	%ymm8, %ymm12, %ymm3
	vpmaxsd	%ymm1, %ymm3, %ymm3
	vpaddd	%ymm7, %ymm3, %ymm3
	vextracti128	$1, %ymm3, %xmm4
	vpmovsxdq	%xmm4, %ymm4
	vpmovsxdq	%xmm3, %ymm3
	vmovq	%xmm4, %rbx
	vmovd	(%rbp,%rbx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm4, %rbx
	vextracti128	$1, %ymm4, %xmm4
	vpinsrd	$1, (%rbp,%rbx,4), %xmm0, %xmm0
	vmovq	%xmm4, %rbx
	vpinsrd	$2, (%rbp,%rbx,4), %xmm0, %xmm0
	vpextrq	$1, %xmm4, %rbx
	vpinsrd	$3, (%rbp,%rbx,4), %xmm0, %xmm0
	vmovq	%xmm3, %rbx
	vmovd	(%rbp,%rbx,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm3, %rbx
	vpinsrd	$1, (%rbp,%rbx,4), %xmm4, %xmm4
	vextracti128	$1, %ymm3, %xmm3
	vmovq	%xmm3, %rbx
	vpinsrd	$2, (%rbp,%rbx,4), %xmm4, %xmm4
	vpextrq	$1, %xmm3, %rbx
	vpinsrd	$3, (%rbp,%rbx,4), %xmm4, %xmm3
	vpcmpgtd	%ymm8, %ymm11, %ymm4
	vpxor	%ymm4, %ymm10, %ymm4
	vextracti128	$1, %ymm4, %xmm2
	vpackssdw	%xmm2, %xmm4, %xmm2
	vpcmpgtd	%ymm8, %ymm1, %ymm4
	vextracti128	$1, %ymm4, %xmm5
	vpackssdw	%xmm5, %xmm4, %xmm4
	vpor	%xmm6, %xmm4, %xmm4
	vpor	%xmm2, %xmm4, %xmm2
	vpmovzxwd	%xmm2, %ymm2            # ymm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero,xmm2[4],zero,xmm2[5],zero,xmm2[6],zero,xmm2[7],zero
	vpslld	$31, %ymm2, %ymm2
	vinserti128	$1, %xmm0, %ymm3, %ymm0
	vblendvps	%ymm2, %ymm13, %ymm0, %ymm0
	movslq	%edx, %rdx
	addq	%rdi, %rdx
	vmovups	%ymm0, -16(%r13,%rdx,4)
	addl	$8, %esi
	decl	%eax
	jne	.LBB2_19
# %bb.20:                               # %"end for constant_exterior.s0._0._07.loopexit.us"
                                        #   in Loop: Header=BB2_18 Depth=2
	incq	%rcx
	cmpq	80(%rsp), %rcx                  # 8-byte Folded Reload
	jne	.LBB2_18
.LBB2_21:                               # %"end for constant_exterior.s0._1.rebased4"
                                        #   in Loop: Header=BB2_15 Depth=1
	testb	$1, 352(%rsp)                   # 1-byte Folded Reload
	je	.LBB2_33
# %bb.22:                               # %"for constant_exterior.s0._1.rebased10.preheader"
                                        #   in Loop: Header=BB2_15 Depth=1
	movq	304(%rsp), %rax                 # 8-byte Reload
	movl	%eax, %r14d
	imull	216(%rsp), %r14d                # 4-byte Folded Reload
	imulq	280(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 184(%rsp)                 # 8-byte Spill
	subl	176(%rsp), %r14d                # 4-byte Folded Reload
	movq	424(%rsp), %r15                 # 8-byte Reload
	movl	348(%rsp), %r9d                 # 4-byte Reload
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB2_23:                               # %"for constant_exterior.s0._1.rebased10"
                                        #   Parent Loop BB2_15 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_25 Depth 3
                                        #       Child Loop BB2_28 Depth 3
                                        #       Child Loop BB2_31 Depth 3
	movq	288(%rsp), %rcx                 # 8-byte Reload
	addl	%eax, %ecx
	imull	32(%rsp), %ecx                  # 4-byte Folded Reload
	addl	%r14d, %ecx
	movq	80(%rsp), %rdx                  # 8-byte Reload
	addl	%eax, %edx
	imull	%r10d, %edx
	movslq	%edx, %rdi
	addq	184(%rsp), %rdi                 # 8-byte Folded Reload
	vmovd	%ecx, %xmm6
	cmpl	$0, 40(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_26
# %bb.24:                               # %"for constant_exterior.s0._0._013.preheader"
                                        #   in Loop: Header=BB2_23 Depth=2
	vpbroadcastd	%xmm6, %ymm7
	movl	$4, %ecx
	movl	40(%rsp), %r10d                 # 4-byte Reload
	.p2align	4, 0x90
.LBB2_25:                               # %"for constant_exterior.s0._0._013"
                                        #   Parent Loop BB2_15 Depth=1
                                        #     Parent Loop BB2_23 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpl	%ecx, %r12d
	movl	%r12d, %edx
	cmovgl	%ecx, %edx
	leal	(%r11,%rdx), %esi
	vmovd	%esi, %xmm0
	vpbroadcastd	%xmm0, %ymm0
	vpaddd	%ymm0, %ymm9, %ymm0
	vpminsd	%ymm0, %ymm12, %ymm2
	vpmaxsd	%ymm1, %ymm2, %ymm2
	vpaddd	%ymm7, %ymm2, %ymm2
	vextracti128	$1, %ymm2, %xmm3
	vpmovsxdq	%xmm3, %ymm3
	vpmovsxdq	%xmm2, %ymm2
	vmovq	%xmm3, %rsi
	vmovd	(%rbp,%rsi,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm3, %rsi
	vpinsrd	$1, (%rbp,%rsi,4), %xmm4, %xmm4
	vextracti128	$1, %ymm3, %xmm3
	vmovq	%xmm3, %rsi
	vpinsrd	$2, (%rbp,%rsi,4), %xmm4, %xmm4
	vpextrq	$1, %xmm3, %rsi
	vpinsrd	$3, (%rbp,%rsi,4), %xmm4, %xmm3
	vmovq	%xmm2, %rsi
	vmovd	(%rbp,%rsi,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm2, %rsi
	vextracti128	$1, %ymm2, %xmm2
	vpinsrd	$1, (%rbp,%rsi,4), %xmm4, %xmm4
	vmovq	%xmm2, %rsi
	vpinsrd	$2, (%rbp,%rsi,4), %xmm4, %xmm4
	vpextrq	$1, %xmm2, %rsi
	vpinsrd	$3, (%rbp,%rsi,4), %xmm4, %xmm2
	vpcmpgtd	%ymm0, %ymm11, %ymm4
	vpxor	%ymm4, %ymm10, %ymm4
	vpcmpgtd	%ymm0, %ymm1, %ymm0
	vpor	%ymm0, %ymm4, %ymm0
	vinserti128	$1, %xmm3, %ymm2, %ymm2
	vblendvps	%ymm0, %ymm13, %ymm2, %ymm0
	movslq	%edx, %rdx
	addq	%rdi, %rdx
	vmovups	%ymm0, -16(%r13,%rdx,4)
	addl	$8, %ecx
	decl	%r10d
	jne	.LBB2_25
.LBB2_26:                               # %"end for constant_exterior.s0._0._014"
                                        #   in Loop: Header=BB2_23 Depth=2
	cmpl	$0, 328(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_29
# %bb.27:                               # %"for constant_exterior.s0._0._0.rebased.preheader"
                                        #   in Loop: Header=BB2_23 Depth=2
	movslq	%r9d, %rcx
	addq	144(%rsp), %rcx                 # 8-byte Folded Reload
	leaq	(,%rcx,4), %rcx
	addq	%r13, %rcx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_28:                               # %"for constant_exterior.s0._0._0.rebased"
                                        #   Parent Loop BB2_15 Depth=1
                                        #     Parent Loop BB2_23 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqu	(%r15,%rdx), %ymm0
	vmovdqa	%ymm0, (%rcx,%rdx)
	addq	$32, %rdx
	cmpq	%rdx, %r8
	jne	.LBB2_28
.LBB2_29:                               # %"end for constant_exterior.s0._0._0.rebased"
                                        #   in Loop: Header=BB2_23 Depth=2
	cmpl	$0, 56(%rsp)                    # 4-byte Folded Reload
	movl	136(%rsp), %r10d                # 4-byte Reload
	jle	.LBB2_32
# %bb.30:                               # %"for constant_exterior.s0._0._0.rebased17.preheader"
                                        #   in Loop: Header=BB2_23 Depth=2
	vpbroadcastd	%xmm6, %ymm6
	movl	240(%rsp), %ecx                 # 4-byte Reload
	movl	56(%rsp), %esi                  # 4-byte Reload
	.p2align	4, 0x90
.LBB2_31:                               # %"for constant_exterior.s0._0._0.rebased17"
                                        #   Parent Loop BB2_15 Depth=1
                                        #     Parent Loop BB2_23 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpl	%ecx, %r12d
	movl	%r12d, %edx
	cmovgl	%ecx, %edx
	leal	(%r11,%rdx), %ebx
	vmovd	%ebx, %xmm0
	vpbroadcastd	%xmm0, %ymm0
	vpaddd	%ymm0, %ymm9, %ymm0
	vpminsd	%ymm0, %ymm12, %ymm2
	vpmaxsd	%ymm1, %ymm2, %ymm2
	vpaddd	%ymm6, %ymm2, %ymm2
	vextracti128	$1, %ymm2, %xmm3
	vpmovsxdq	%xmm3, %ymm3
	vpmovsxdq	%xmm2, %ymm2
	vmovq	%xmm3, %rbx
	vmovd	(%rbp,%rbx,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm3, %rbx
	vpinsrd	$1, (%rbp,%rbx,4), %xmm4, %xmm4
	vextracti128	$1, %ymm3, %xmm3
	vmovq	%xmm3, %rbx
	vpinsrd	$2, (%rbp,%rbx,4), %xmm4, %xmm4
	vpextrq	$1, %xmm3, %rbx
	vpinsrd	$3, (%rbp,%rbx,4), %xmm4, %xmm3
	vmovq	%xmm2, %rbx
	vmovd	(%rbp,%rbx,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm2, %rbx
	vextracti128	$1, %ymm2, %xmm2
	vpinsrd	$1, (%rbp,%rbx,4), %xmm4, %xmm4
	vmovq	%xmm2, %rbx
	vpinsrd	$2, (%rbp,%rbx,4), %xmm4, %xmm4
	vpextrq	$1, %xmm2, %rbx
	vpinsrd	$3, (%rbp,%rbx,4), %xmm4, %xmm2
	vpcmpgtd	%ymm0, %ymm11, %ymm4
	vpxor	%ymm4, %ymm10, %ymm4
	vpcmpgtd	%ymm0, %ymm1, %ymm0
	vpor	%ymm0, %ymm4, %ymm0
	vinserti128	$1, %xmm3, %ymm2, %ymm2
	vblendvps	%ymm0, %ymm13, %ymm2, %ymm0
	movslq	%edx, %rdx
	addq	%rdi, %rdx
	vmovups	%ymm0, -16(%r13,%rdx,4)
	addl	$8, %ecx
	decl	%esi
	jne	.LBB2_31
.LBB2_32:                               # %"end for constant_exterior.s0._0._0.rebased18"
                                        #   in Loop: Header=BB2_23 Depth=2
	incq	%rax
	addl	%r10d, %r9d
	addq	312(%rsp), %r15                 # 8-byte Folded Reload
	cmpq	320(%rsp), %rax                 # 8-byte Folded Reload
	jne	.LBB2_23
.LBB2_33:                               # %"end for constant_exterior.s0._1.rebased11"
                                        #   in Loop: Header=BB2_15 Depth=1
	cmpl	$0, 356(%rsp)                   # 4-byte Folded Reload
	movq	472(%rsp), %r14                 # 8-byte Reload
	movq	456(%rsp), %r15                 # 8-byte Reload
	jle	.LBB2_39
# %bb.34:                               # %"for constant_exterior.s0._1.rebased21.preheader"
                                        #   in Loop: Header=BB2_15 Depth=1
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_39
# %bb.35:                               # %"for constant_exterior.s0._1.rebased21.us.preheader"
                                        #   in Loop: Header=BB2_15 Depth=1
	movq	304(%rsp), %r10                 # 8-byte Reload
	movl	%r10d, %r9d
	imull	216(%rsp), %r9d                 # 4-byte Folded Reload
	subl	176(%rsp), %r9d                 # 4-byte Folded Reload
	imulq	280(%rsp), %r10                 # 8-byte Folded Reload
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB2_36:                               # %"for constant_exterior.s0._1.rebased21.us"
                                        #   Parent Loop BB2_15 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_37 Depth 3
	leaq	(%rsi,%r15), %rcx
	imulq	88(%rsp), %rcx                  # 8-byte Folded Reload
	addq	%r10, %rcx
	movq	248(%rsp), %rax                 # 8-byte Reload
	addq	%rsi, %rax
	cmpq	8(%rsp), %rax                   # 8-byte Folded Reload
	setge	%dl
	vmovd	%edx, %xmm0
	vpbroadcastb	%xmm0, %xmm6
	movq	48(%rsp), %rdx                  # 8-byte Reload
	cmpq	%rdx, %rax
	cmovgl	%edx, %eax
	movq	24(%rsp), %rdx                  # 8-byte Reload
	cmpl	%edx, %eax
	cmovlel	%edx, %eax
	imull	32(%rsp), %eax                  # 4-byte Folded Reload
	addl	%r9d, %eax
	vmovd	%eax, %xmm0
	vpbroadcastd	%xmm0, %ymm7
	movl	$4, %edi
	movq	112(%rsp), %rax                 # 8-byte Reload
                                        # kill: def $eax killed $eax killed $rax
	.p2align	4, 0x90
.LBB2_37:                               # %"for constant_exterior.s0._0._024.us"
                                        #   Parent Loop BB2_15 Depth=1
                                        #     Parent Loop BB2_36 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpl	%edi, %r12d
	movl	%r12d, %edx
	cmovgl	%edi, %edx
	leal	(%r11,%rdx), %ebx
	vmovd	%ebx, %xmm0
	vpbroadcastd	%xmm0, %ymm0
	vpaddd	%ymm0, %ymm9, %ymm8
	vpminsd	%ymm8, %ymm12, %ymm0
	vpmaxsd	%ymm1, %ymm0, %ymm0
	vpaddd	%ymm7, %ymm0, %ymm0
	vextracti128	$1, %ymm0, %xmm2
	vpmovsxdq	%xmm2, %ymm2
	vpmovsxdq	%xmm0, %ymm0
	vmovq	%xmm2, %rbx
	vmovd	(%rbp,%rbx,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm2, %rbx
	vextracti128	$1, %ymm2, %xmm2
	vpinsrd	$1, (%rbp,%rbx,4), %xmm3, %xmm3
	vmovq	%xmm2, %rbx
	vpinsrd	$2, (%rbp,%rbx,4), %xmm3, %xmm3
	vpextrq	$1, %xmm2, %rbx
	vpinsrd	$3, (%rbp,%rbx,4), %xmm3, %xmm2
	vmovq	%xmm0, %rbx
	vmovd	(%rbp,%rbx,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm0, %rbx
	vpinsrd	$1, (%rbp,%rbx,4), %xmm3, %xmm3
	vextracti128	$1, %ymm0, %xmm0
	vmovq	%xmm0, %rbx
	vpinsrd	$2, (%rbp,%rbx,4), %xmm3, %xmm3
	vpextrq	$1, %xmm0, %rbx
	vpinsrd	$3, (%rbp,%rbx,4), %xmm3, %xmm0
	vpcmpgtd	%ymm8, %ymm11, %ymm3
	vpxor	%ymm3, %ymm10, %ymm3
	vextracti128	$1, %ymm3, %xmm4
	vpackssdw	%xmm4, %xmm3, %xmm3
	vpcmpgtd	%ymm8, %ymm1, %ymm4
	vextracti128	$1, %ymm4, %xmm5
	vpackssdw	%xmm5, %xmm4, %xmm4
	vpor	%xmm6, %xmm4, %xmm4
	vpor	%xmm3, %xmm4, %xmm3
	vpmovzxwd	%xmm3, %ymm3            # ymm3 = xmm3[0],zero,xmm3[1],zero,xmm3[2],zero,xmm3[3],zero,xmm3[4],zero,xmm3[5],zero,xmm3[6],zero,xmm3[7],zero
	vpslld	$31, %ymm3, %ymm3
	vinserti128	$1, %xmm2, %ymm0, %ymm0
	vblendvps	%ymm3, %ymm13, %ymm0, %ymm0
	movslq	%edx, %rdx
	addq	%rcx, %rdx
	vmovups	%ymm0, -16(%r13,%rdx,4)
	addl	$8, %edi
	decl	%eax
	jne	.LBB2_37
# %bb.38:                               # %"end for constant_exterior.s0._0._025.loopexit.us"
                                        #   in Loop: Header=BB2_36 Depth=2
	incq	%rsi
	cmpq	%r14, %rsi
	jne	.LBB2_36
.LBB2_39:                               # %"end for constant_exterior.s0._1.rebased22"
                                        #   in Loop: Header=BB2_15 Depth=1
	movq	480(%rsp), %rcx                 # 8-byte Reload
	incq	%rcx
	movq	144(%rsp), %rax                 # 8-byte Reload
	addq	280(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movq	448(%rsp), %rax                 # 8-byte Reload
	addq	%rax, 424(%rsp)                 # 8-byte Folded Spill
	cmpq	408(%rsp), %rcx                 # 8-byte Folded Reload
	movl	136(%rsp), %r10d                # 4-byte Reload
	jne	.LBB2_15
.LBB2_40:                               # %"end for constant_exterior.s0._2.rebased"
	movq	152(%rsp), %rcx                 # 8-byte Reload
	cmpl	$3, %ecx
	movl	$3, %eax
	cmovll	%ecx, %eax
	cmpl	$0, 416(%rsp)                   # 4-byte Folded Reload
	movq	96(%rsp), %rbx                  # 8-byte Reload
	jle	.LBB2_49
# %bb.41:                               # %"for constant_exterior.s0._2.rebased28.preheader"
	movl	%eax, %ecx
	sarl	$31, %ecx
	andnl	%eax, %ecx, %eax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movq	152(%rsp), %rax                 # 8-byte Reload
	decl	%eax
	movq	264(%rsp), %rcx                 # 8-byte Reload
	vmovd	%ecx, %xmm0
	vpbroadcastd	%xmm0, %ymm11
	addl	$-6, %ebx
	vmovd	204(%rsp), %xmm1                # 4-byte Folded Reload
                                        # xmm1 = mem[0],zero,zero,zero
	vpbroadcastd	%xmm1, %ymm1
	decl	%ecx
	vmovd	%ecx, %xmm2
	vpbroadcastd	%xmm2, %ymm12
	movq	8(%rsp), %rcx                   # 8-byte Reload
                                        # kill: def $ecx killed $ecx killed $rcx
	decl	%ecx
	movslq	136(%rsp), %rdx                 # 4-byte Folded Reload
	movq	%rdx, 56(%rsp)                  # 8-byte Spill
	movslq	%ecx, %r14
	movl	76(%rsp), %ecx                  # 4-byte Reload
	movq	%rcx, 80(%rsp)                  # 8-byte Spill
	cltq
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movslq	172(%rsp), %rax                 # 4-byte Folded Reload
	movq	%rax, 184(%rsp)                 # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	vmovdqa	.LCPI2_0(%rip), %ymm9           # ymm9 = [0,1,2,3,4,5,6,7]
	vpcmpeqd	%ymm10, %ymm10, %ymm10
	vbroadcastss	.LCPI2_1(%rip), %ymm13  # ymm13 = [7,7,7,7,7,7,7,7]
	movq	24(%rsp), %rdx                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_42:                               # %"for constant_exterior.s0._2.rebased28"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_45 Depth 2
                                        #       Child Loop BB2_46 Depth 3
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_48
# %bb.43:                               # %"for constant_exterior.s0._1.rebased31.preheader"
                                        #   in Loop: Header=BB2_42 Depth=1
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	48(%rsp), %rcx                  # 8-byte Reload
	addq	%rax, %rcx
	movq	144(%rsp), %rax                 # 8-byte Reload
	cmpq	%rax, %rcx
	movl	%eax, %r15d
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	cmovlel	%ecx, %r15d
	movq	232(%rsp), %rax                 # 8-byte Reload
	cmpl	%eax, %r15d
	cmovlel	%eax, %r15d
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_48
# %bb.44:                               # %"for constant_exterior.s0._1.rebased31.us.preheader"
                                        #   in Loop: Header=BB2_42 Depth=1
	imull	216(%rsp), %r15d                # 4-byte Folded Reload
	subl	176(%rsp), %r15d                # 4-byte Folded Reload
	movq	96(%rsp), %rax                  # 8-byte Reload
	imulq	184(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB2_45:                               # %"for constant_exterior.s0._1.rebased31.us"
                                        #   Parent Loop BB2_42 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_46 Depth 3
	movq	96(%rsp), %rax                  # 8-byte Reload
	cmpq	152(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rbx, %r9
	setge	%bl
	movq	%r8, %rsi
	imulq	56(%rsp), %rsi                  # 8-byte Folded Reload
	addq	40(%rsp), %rsi                  # 8-byte Folded Reload
	movq	64(%rsp), %rax                  # 8-byte Reload
	leaq	(%r8,%rax), %rcx
	cmpq	%rdx, %rcx
	setl	%dil
	cmpq	8(%rsp), %rcx                   # 8-byte Folded Reload
	setge	%al
	orb	%bl, %dil
	movq	%r9, %rbx
	orb	%al, %dil
	vmovd	%edi, %xmm6
	vpbroadcastb	%xmm6, %xmm6
	cmpq	%r14, %rcx
	movl	%r14d, %eax
	cmovlel	%ecx, %eax
	cmpl	%edx, %eax
	cmovlel	%edx, %eax
	imull	32(%rsp), %eax                  # 4-byte Folded Reload
	addl	%r15d, %eax
	vmovd	%eax, %xmm7
	vpbroadcastd	%xmm7, %ymm7
	movl	$4, %r9d
	movq	112(%rsp), %rax                 # 8-byte Reload
	movl	%eax, %r10d
	.p2align	4, 0x90
.LBB2_46:                               # %"for constant_exterior.s0._0._034.us"
                                        #   Parent Loop BB2_42 Depth=1
                                        #     Parent Loop BB2_45 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpl	%r9d, %r12d
	movl	%r12d, %r11d
	cmovgl	%r9d, %r11d
	leal	(%rbx,%r11), %eax
	vmovd	%eax, %xmm3
	vpbroadcastd	%xmm3, %ymm3
	vpaddd	%ymm3, %ymm9, %ymm8
	vpminsd	%ymm8, %ymm12, %ymm3
	vpmaxsd	%ymm1, %ymm3, %ymm3
	vpaddd	%ymm7, %ymm3, %ymm3
	vextracti128	$1, %ymm3, %xmm4
	vpmovsxdq	%xmm4, %ymm4
	vpmovsxdq	%xmm3, %ymm3
	vmovq	%xmm4, %rax
	vmovd	(%rbp,%rax,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm4, %rax
	vextracti128	$1, %ymm4, %xmm4
	vpinsrd	$1, (%rbp,%rax,4), %xmm0, %xmm0
	vmovq	%xmm4, %rax
	vpinsrd	$2, (%rbp,%rax,4), %xmm0, %xmm0
	vpextrq	$1, %xmm4, %rax
	vpinsrd	$3, (%rbp,%rax,4), %xmm0, %xmm0
	vmovq	%xmm3, %rax
	vmovd	(%rbp,%rax,4), %xmm4            # xmm4 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm3, %rax
	vpinsrd	$1, (%rbp,%rax,4), %xmm4, %xmm4
	vextracti128	$1, %ymm3, %xmm3
	vmovq	%xmm3, %rax
	vpinsrd	$2, (%rbp,%rax,4), %xmm4, %xmm4
	vpextrq	$1, %xmm3, %rax
	vpinsrd	$3, (%rbp,%rax,4), %xmm4, %xmm3
	vpcmpgtd	%ymm8, %ymm11, %ymm4
	vpxor	%ymm4, %ymm10, %ymm4
	vextracti128	$1, %ymm4, %xmm2
	vpackssdw	%xmm2, %xmm4, %xmm2
	vpcmpgtd	%ymm8, %ymm1, %ymm4
	vextracti128	$1, %ymm4, %xmm5
	vpackssdw	%xmm5, %xmm4, %xmm4
	vpor	%xmm6, %xmm4, %xmm4
	vpor	%xmm2, %xmm4, %xmm2
	vpmovzxwd	%xmm2, %ymm2            # ymm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero,xmm2[4],zero,xmm2[5],zero,xmm2[6],zero,xmm2[7],zero
	vpslld	$31, %ymm2, %ymm2
	vinserti128	$1, %xmm0, %ymm3, %ymm0
	vblendvps	%ymm2, %ymm13, %ymm0, %ymm0
	movslq	%r11d, %rax
	addq	%rsi, %rax
	vmovups	%ymm0, -16(%r13,%rax,4)
	addl	$8, %r9d
	decl	%r10d
	jne	.LBB2_46
# %bb.47:                               # %"end for constant_exterior.s0._0._035.loopexit.us"
                                        #   in Loop: Header=BB2_45 Depth=2
	incq	%r8
	cmpq	80(%rsp), %r8                   # 8-byte Folded Reload
	jne	.LBB2_45
.LBB2_48:                               # %"end for constant_exterior.s0._1.rebased32"
                                        #   in Loop: Header=BB2_42 Depth=1
	movq	48(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	%rcx, %rax
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	cmpq	416(%rsp), %rcx                 # 8-byte Folded Reload
	jne	.LBB2_42
.LBB2_49:                               # %"end for constant_exterior.s0._2.rebased29"
	imulq	$100, 296(%rsp), %r12           # 8-byte Folded Reload
	movl	$2147483648, %eax               # imm = 0x80000000
	cmpq	%rax, %r12
	jae	.LBB2_367
# %bb.50:                               # %"end for constant_exterior.s0._2.rebased29"
	movq	360(%rsp), %rax                 # 8-byte Reload
	leaq	(%rax,%rax,4), %rax
	leaq	(%rax,%rax,4), %rax
	shrq	$32, %rax
	movq	368(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%rdx,4), %rcx
	leaq	(%rcx,%rcx,4), %rcx
	addq	%rax, %rcx
	orq	%rdx, %rcx
	shrq	$32, %rcx
	jne	.LBB2_367
# %bb.51:                               # %"assert succeeded39"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r12, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	movq	%rax, %r15
	testq	%r12, %r12
	je	.LBB2_53
# %bb.52:                               # %"assert succeeded39"
	testq	%r15, %r15
	je	.LBB2_395
.LBB2_53:                               # %"for sum.s0._2.preheader"
	movslq	128(%rsp), %rax                 # 4-byte Folded Reload
	movq	%rax, 152(%rsp)                 # 8-byte Spill
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setg	%al
	movq	112(%rsp), %rcx                 # 8-byte Reload
	testl	%ecx, %ecx
	setg	%bl
	movslq	136(%rsp), %r14                 # 4-byte Folded Reload
	leaq	(,%r14,4), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	shlq	$5, %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movl	76(%rsp), %ecx                  # 4-byte Reload
	movq	%rcx, 96(%rsp)                  # 8-byte Spill
	andb	%al, %bl
	movb	%bl, 64(%rsp)                   # 1-byte Spill
	xorl	%eax, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB2_54:                               # %"for sum.s0._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_56 Depth 2
	cmpb	$0, 64(%rsp)                    # 1-byte Folded Reload
	je	.LBB2_57
# %bb.55:                               # %"for sum.s0._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_54 Depth=1
	movslq	8(%rsp), %rax                   # 4-byte Folded Reload
	leaq	(%r15,%rax,4), %rbp
	movq	96(%rsp), %rbx                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_56:                               # %"for sum.s0._1.rebased.us"
                                        #   Parent Loop BB2_54 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbp, %rdi
	xorl	%esi, %esi
	movq	24(%rsp), %rdx                  # 8-byte Reload
	callq	memset@PLT
	addq	32(%rsp), %rbp                  # 8-byte Folded Reload
	decq	%rbx
	jne	.LBB2_56
.LBB2_57:                               # %"end for sum.s0._1.rebased"
                                        #   in Loop: Header=BB2_54 Depth=1
	incq	%r12
	movq	8(%rsp), %rax                   # 8-byte Reload
	addl	172(%rsp), %eax                 # 4-byte Folded Reload
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	cmpq	$25, %r12
	jne	.LBB2_54
# %bb.58:                               # %"for sum.s1._2.preheader"
	movslq	172(%rsp), %rax                 # 4-byte Folded Reload
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	leaq	(,%rax,4), %r12
	movl	$4, %ecx
	xorl	%eax, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	.p2align	4, 0x90
.LBB2_59:                               # %"for sum.s1._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_62 Depth 2
                                        #       Child Loop BB2_63 Depth 3
                                        #         Child Loop BB2_64 Depth 4
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_67
# %bb.60:                               # %"for sum.s1._1.rebased.preheader"
                                        #   in Loop: Header=BB2_59 Depth=1
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_67
# %bb.61:                               # %"for sum.s1._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_59 Depth=1
	movq	8(%rsp), %rsi                   # 8-byte Reload
	imulq	64(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%r13, %r8
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB2_62:                               # %"for sum.s1._1.rebased.us"
                                        #   Parent Loop BB2_59 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_63 Depth 3
                                        #         Child Loop BB2_64 Depth 4
	movq	%r11, %rbp
	imulq	%r14, %rbp
	movq	%r8, %r10
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_63:                               # %"for sum.s1._0._0.us"
                                        #   Parent Loop BB2_59 Depth=1
                                        #     Parent Loop BB2_62 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_64 Depth 4
	leaq	(,%rdx,8), %rax
	addq	%rbp, %rax
	addq	%rsi, %rax
	vmovdqa	(%r15,%rax,4), %ymm0
	movq	%r10, %rdi
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB2_64:                               # %"for sum.s1.r88$x.us"
                                        #   Parent Loop BB2_59 Depth=1
                                        #     Parent Loop BB2_62 Depth=2
                                        #       Parent Loop BB2_63 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rcx,%rbx), %r9d
	vmovd	%r9d, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpmulld	(%rdi), %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$3, %rbx
	addq	%r12, %rdi
	cmpq	$9, %rbx
	jne	.LBB2_64
# %bb.65:                               # %"end for sum.s1.r88$x.us"
                                        #   in Loop: Header=BB2_63 Depth=3
	vmovdqa	%ymm0, (%r15,%rax,4)
	incq	%rdx
	addq	$32, %r10
	cmpq	112(%rsp), %rdx                 # 8-byte Folded Reload
	jne	.LBB2_63
# %bb.66:                               # %"end for sum.s1._0._0.loopexit.us"
                                        #   in Loop: Header=BB2_62 Depth=2
	incq	%r11
	addq	32(%rsp), %r8                   # 8-byte Folded Reload
	cmpq	96(%rsp), %r11                  # 8-byte Folded Reload
	jne	.LBB2_62
.LBB2_67:                               # %"end for sum.s1._1.rebased"
                                        #   in Loop: Header=BB2_59 Depth=1
	movq	8(%rsp), %rdx                   # 8-byte Reload
	incq	%rdx
	incq	%rcx
	movq	%rdx, %rax
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	cmpq	$25, %rdx
	jne	.LBB2_59
# %bb.68:                               # %"end for sum.s1._2"
	testq	%r13, %r13
	je	.LBB2_70
# %bb.69:                               # %if.then.i520
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r13, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_70:                               # %call_destructor.exit521
	movq	376(%rsp), %rax                 # 8-byte Reload
	leal	8(%rax), %ebx
	cmpl	$-7, %eax
	movl	$-8, %edx
	cmovgel	%eax, %edx
	leal	8(%rdx), %eax
	movq	%rax, %rcx
	movq	160(%rsp), %rdi                 # 8-byte Reload
	imulq	%rdi, %rcx
	movq	%rcx, %rsi
	shlq	$6, %rsi
	leaq	(%rsi,%rcx,4), %rbp
	movl	$2147483648, %esi               # imm = 0x80000000
	cmpq	%rsi, %rbp
	jae	.LBB2_368
# %bb.71:                               # %call_destructor.exit521
	leal	32(,%rdx,4), %edx
	imulq	%rdi, %rdx
	shrq	$32, %rdx
	shrq	$30, %rax
	imulq	%rdi, %rax
	addq	%rdx, %rax
	shll	$2, %ecx
	movq	%rcx, %rdx
	shlq	$4, %rdx
	addq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rax, %rcx
	shlq	$4, %rcx
	addq	%rax, %rcx
	addq	%rdx, %rcx
	orq	%rax, %rcx
	shrq	$32, %rcx
	jne	.LBB2_368
# %bb.72:                               # %"assert succeeded43"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbp, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	movq	%rax, %r14
	testq	%rbp, %rbp
	je	.LBB2_74
# %bb.73:                               # %"assert succeeded43"
	testq	%r14, %r14
	je	.LBB2_398
.LBB2_74:                               # %"for all_r.s0._2.preheader"
	movslq	%ebx, %rcx
	imull	76(%rsp), %ebx                  # 4-byte Folded Reload
	movl	%ebx, 80(%rsp)                  # 4-byte Spill
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	setg	%al
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setg	%dl
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	leaq	(,%rcx,4), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	andb	%al, %dl
	movb	%dl, 48(%rsp)                   # 1-byte Spill
	xorl	%eax, %eax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	xorl	%ecx, %ecx
	movq	24(%rsp), %r13                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_75:                               # %"for all_r.s0._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_77 Depth 2
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	cmpb	$0, 48(%rsp)                    # 1-byte Folded Reload
	je	.LBB2_78
# %bb.76:                               # %"for all_r.s0._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_75 Depth=1
	movslq	40(%rsp), %rax                  # 4-byte Folded Reload
	leaq	(%r14,%rax,4), %rbp
	movq	96(%rsp), %rbx                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_77:                               # %"for all_r.s0._1.rebased.us"
                                        #   Parent Loop BB2_75 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbp, %rdi
	xorl	%esi, %esi
	movq	%r13, %rdx
	callq	memset@PLT
	addq	8(%rsp), %rbp                   # 8-byte Folded Reload
	decq	%rbx
	jne	.LBB2_77
.LBB2_78:                               # %"end for all_r.s0._1.rebased"
                                        #   in Loop: Header=BB2_75 Depth=1
	movq	56(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	40(%rsp), %rax                  # 8-byte Reload
	addl	80(%rsp), %eax                  # 4-byte Folded Reload
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	cmpq	$17, %rcx
	jne	.LBB2_75
# %bb.79:                               # %"for all_r.s1._2.preheader"
	movslq	80(%rsp), %rax                  # 4-byte Folded Reload
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movl	$26, %eax
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB2_80:                               # %"for all_r.s1._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_83 Depth 2
                                        #       Child Loop BB2_84 Depth 3
                                        #         Child Loop BB2_85 Depth 4
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_88
# %bb.81:                               # %"for all_r.s1._1.rebased.preheader"
                                        #   in Loop: Header=BB2_80 Depth=1
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_88
# %bb.82:                               # %"for all_r.s1._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_80 Depth=1
	movq	%r8, %r9
	imulq	24(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r15, %r10
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB2_83:                               # %"for all_r.s1._1.rebased.us"
                                        #   Parent Loop BB2_80 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_84 Depth 3
                                        #         Child Loop BB2_85 Depth 4
	movq	%r11, %r13
	imulq	64(%rsp), %r13                  # 8-byte Folded Reload
	addq	%r9, %r13
	movq	%r10, %rcx
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB2_84:                               # %"for all_r.s1._0._0.us"
                                        #   Parent Loop BB2_80 Depth=1
                                        #     Parent Loop BB2_83 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_85 Depth 4
	leaq	(,%rbx,8), %rdx
	addq	%r13, %rdx
	vmovdqu	(%r14,%rdx,4), %ymm0
	movq	%rcx, %rsi
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB2_85:                               # %"for all_r.s1.r110$x.us"
                                        #   Parent Loop BB2_80 Depth=1
                                        #     Parent Loop BB2_83 Depth=2
                                        #       Parent Loop BB2_84 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rax,%rbp), %edi
	vmovd	%edi, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpmulld	(%rsi), %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$25, %rbp
	addq	%r12, %rsi
	cmpq	$625, %rbp                      # imm = 0x271
	jne	.LBB2_85
# %bb.86:                               # %"end for all_r.s1.r110$x.us"
                                        #   in Loop: Header=BB2_84 Depth=3
	vmovdqu	%ymm0, (%r14,%rdx,4)
	incq	%rbx
	addq	$32, %rcx
	cmpq	112(%rsp), %rbx                 # 8-byte Folded Reload
	jne	.LBB2_84
# %bb.87:                               # %"end for all_r.s1._0._0.loopexit.us"
                                        #   in Loop: Header=BB2_83 Depth=2
	incq	%r11
	addq	32(%rsp), %r10                  # 8-byte Folded Reload
	cmpq	96(%rsp), %r11                  # 8-byte Folded Reload
	jne	.LBB2_83
.LBB2_88:                               # %"end for all_r.s1._1.rebased"
                                        #   in Loop: Header=BB2_80 Depth=1
	incq	%r8
	incq	%rax
	cmpq	$17, %r8
	jne	.LBB2_80
# %bb.89:                               # %"end for all_r.s1._2"
	testq	%r15, %r15
	je	.LBB2_91
# %bb.90:                               # %if.then.i523
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r15, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_91:                               # %call_destructor.exit524
	movq	208(%rsp), %r13                 # 8-byte Reload
	movl	%r13d, %eax
	movl	%r13d, %ecx
	addq	$10, %r13
	cmpl	$-9, %eax
	movl	$-10, %edx
	cmovgel	%ecx, %edx
	leal	10(%rdx), %eax
	movq	%rax, %rcx
	movq	160(%rsp), %rdi                 # 8-byte Reload
	imulq	%rdi, %rcx
	movq	%rcx, %rsi
	shlq	$6, %rsi
	leaq	(%rsi,%rcx,4), %rbp
	movl	$2147483648, %esi               # imm = 0x80000000
	cmpq	%rsi, %rbp
	jae	.LBB2_369
# %bb.92:                               # %call_destructor.exit524
	leal	40(,%rdx,4), %edx
	imulq	%rdi, %rdx
	shrq	$32, %rdx
	shrq	$30, %rax
	imulq	%rdi, %rax
	addq	%rdx, %rax
	shll	$2, %ecx
	movq	%rcx, %rdx
	shlq	$4, %rdx
	addq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rax, %rcx
	shlq	$4, %rcx
	addq	%rax, %rcx
	addq	%rdx, %rcx
	orq	%rax, %rcx
	shrq	$32, %rcx
	jne	.LBB2_369
# %bb.93:                               # %"assert succeeded47"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbp, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	testq	%rbp, %rbp
	je	.LBB2_95
# %bb.94:                               # %"assert succeeded47"
	testq	%rax, %rax
	je	.LBB2_409
.LBB2_95:                               # %"for conv__0.s0._2.preheader"
	movl	%r13d, %edx
	imull	76(%rsp), %edx                  # 4-byte Folded Reload
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setle	%cl
	movq	384(%rsp), %r10                 # 8-byte Reload
	testl	%r10d, %r10d
	setle	%bl
	movslq	%edx, %r12
	orb	%cl, %bl
	movb	%bl, 80(%rsp)                   # 1-byte Spill
	shlq	$7, %r10
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	addq	$96, %rax
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	shlq	$2, %r12
	shlq	$2, %r13
	leaq	104(%r14), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	shlq	$2, 24(%rsp)                    # 8-byte Folded Spill
	xorl	%ecx, %ecx
	vpbroadcastd	.LCPI2_2(%rip), %ymm8   # ymm8 = [255,255,255,255,255,255,255,255]
	vpxor	%xmm0, %xmm0, %xmm0
	movq	%r12, 56(%rsp)                  # 8-byte Spill
	vpxor	%xmm12, %xmm12, %xmm12
	.p2align	4, 0x90
.LBB2_96:                               # %"for conv__0.s0._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_98 Depth 2
                                        #       Child Loop BB2_99 Depth 3
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	cmpb	$0, 80(%rsp)                    # 1-byte Folded Reload
	jne	.LBB2_101
# %bb.97:                               # %"for conv__0.s0._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_96 Depth=1
	movq	32(%rsp), %r11                  # 8-byte Reload
	movq	64(%rsp), %r9                   # 8-byte Reload
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB2_98:                               # %"for conv__0.s0._1.rebased.us"
                                        #   Parent Loop BB2_96 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_99 Depth 3
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB2_99:                               # %"for conv__0.s0._0._0.us"
                                        #   Parent Loop BB2_96 Depth=1
                                        #     Parent Loop BB2_98 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqu	-40(%r11,%rbx), %ymm2
	vmovdqu	-8(%r11,%rbx), %ymm4
	vmovdqu	-104(%r11,%rbx), %ymm1
	vmovdqu	-100(%r11,%rbx), %ymm6
	vmovdqu	-72(%r11,%rbx), %ymm5
	vmovdqu	-68(%r11,%rbx), %ymm3
	vpsubd	-96(%r11,%rbx), %ymm1, %ymm7
	vpsubd	-64(%r11,%rbx), %ymm5, %ymm1
	vpsubd	-32(%r11,%rbx), %ymm2, %ymm9
	vpsubd	(%r11,%rbx), %ymm4, %ymm14
	vpand	%ymm7, %ymm8, %ymm5
	vpcmpeqd	%ymm0, %ymm6, %ymm15
	vpor	%ymm6, %ymm15, %ymm7
	vextracti128	$1, %ymm7, %xmm4
	vpextrd	$1, %xmm4, %ecx
	vmovdqu	-36(%r11,%rbx), %ymm11
	vextracti128	$1, %ymm5, %xmm2
	vpextrd	$1, %xmm2, %eax
	vmovdqu	-4(%r11,%rbx), %ymm6
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vmovd	%xmm4, %esi
	vmovd	%xmm2, %eax
	cltd
	idivl	%esi
	vpextrd	$2, %xmm4, %esi
	vpextrd	$2, %xmm2, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%esi
	vpinsrd	$1, %ecx, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm4, %ecx
	vpextrd	$3, %xmm2, %eax
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpextrd	$1, %xmm7, %esi
	vpextrd	$1, %xmm5, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm0
	vmovdqa	%xmm0, 112(%rsp)                # 16-byte Spill
	vmovd	%xmm7, %ecx
	vmovd	%xmm5, %eax
	cltd
	idivl	%ecx
	vpextrd	$2, %xmm7, %ecx
	vpextrd	$2, %xmm5, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%ecx
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm7, %ecx
	vpextrd	$3, %xmm5, %eax
	vpcmpeqd	%ymm3, %ymm12, %ymm5
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpor	%ymm3, %ymm5, %ymm3
	vextracti128	$1, %ymm3, %xmm2
	vpextrd	$1, %xmm2, %esi
	vpand	%ymm1, %ymm8, %ymm10
	vextracti128	$1, %ymm10, %xmm1
	vpextrd	$1, %xmm1, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm7
	vmovd	%xmm2, %ecx
	vmovd	%xmm1, %eax
	cltd
	idivl	%ecx
	vpextrd	$2, %xmm2, %ecx
	vpextrd	$2, %xmm1, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%ecx
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm2, %ecx
	vpextrd	$3, %xmm1, %eax
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpextrd	$1, %xmm3, %esi
	vpextrd	$1, %xmm10, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm1
	vmovd	%xmm3, %ecx
	vmovd	%xmm10, %eax
	cltd
	idivl	%ecx
	vpextrd	$2, %xmm3, %ecx
	vpextrd	$2, %xmm10, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%ecx
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm3, %ecx
	vpextrd	$3, %xmm10, %eax
	vpcmpeqd	%ymm12, %ymm11, %ymm10
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpor	%ymm11, %ymm10, %ymm11
	vextracti128	$1, %ymm11, %xmm2
	vpextrd	$1, %xmm2, %esi
	vpand	%ymm8, %ymm9, %ymm13
	vextracti128	$1, %ymm13, %xmm3
	vpextrd	$1, %xmm3, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm9
	vmovd	%xmm2, %ecx
	vmovd	%xmm3, %eax
	cltd
	idivl	%ecx
	vpextrd	$2, %xmm2, %ecx
	vpextrd	$2, %xmm3, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%ecx
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm2, %ecx
	vpextrd	$3, %xmm3, %eax
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpextrd	$1, %xmm11, %esi
	vpextrd	$1, %xmm13, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm3
	vmovd	%xmm11, %ecx
	vmovd	%xmm13, %eax
	cltd
	idivl	%ecx
	vmovd	%edx, %xmm0
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpextrd	$2, %xmm11, %ecx
	vpextrd	$2, %xmm13, %eax
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpextrd	$3, %xmm11, %esi
	vpextrd	$3, %xmm13, %eax
	vpcmpeqd	%ymm6, %ymm12, %ymm11
	cltd
	idivl	%esi
	vpinsrd	$2, %ecx, %xmm0, %xmm0
	vpinsrd	$3, %edx, %xmm0, %xmm13
	vpor	%ymm6, %ymm11, %ymm6
	vextracti128	$1, %ymm6, %xmm0
	vpextrd	$1, %xmm0, %ecx
	vpand	%ymm8, %ymm14, %ymm4
	vextracti128	$1, %ymm4, %xmm2
	vpextrd	$1, %xmm2, %eax
	vpextrd	$2, %xmm0, %r15d
	vpextrd	$3, %xmm0, %r8d
	vmovd	%xmm0, %esi
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vmovd	%xmm2, %eax
	cltd
	idivl	%esi
	vpextrd	$2, %xmm2, %eax
	vpextrd	$3, %xmm2, %esi
	vmovd	%edx, %xmm0
	vpinsrd	$1, %ecx, %xmm0, %xmm0
	cltd
	idivl	%r15d
	movl	%edx, %ecx
	movl	%esi, %eax
	cltd
	idivl	%r8d
	vpinsrd	$2, %ecx, %xmm0, %xmm0
	vpinsrd	$3, %edx, %xmm0, %xmm0
	vpextrd	$1, %xmm6, %ecx
	vpextrd	$1, %xmm4, %eax
	vpextrd	$2, %xmm6, %edi
	vpextrd	$3, %xmm6, %ebp
	vmovd	%xmm6, %esi
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vmovd	%xmm4, %eax
	cltd
	idivl	%esi
	vpextrd	$2, %xmm4, %eax
	vpextrd	$3, %xmm4, %esi
	vmovd	%edx, %xmm2
	vpinsrd	$1, %ecx, %xmm2, %xmm2
	vinserti128	$1, 112(%rsp), %ymm7, %ymm4 # 16-byte Folded Reload
	cltd
	idivl	%edi
	movl	%edx, %ecx
	vinserti128	$1, %xmm1, %ymm9, %ymm1
	movl	%esi, %eax
	cltd
	idivl	%ebp
	vpinsrd	$2, %ecx, %xmm2, %xmm2
	vpinsrd	$3, %edx, %xmm2, %xmm2
	vinserti128	$1, %xmm3, %ymm13, %ymm3
	vinserti128	$1, %xmm0, %ymm2, %ymm0
	vpandn	%ymm0, %ymm11, %ymm0
	vpandn	%ymm3, %ymm10, %ymm2
	vpandn	%ymm1, %ymm5, %ymm1
	vpandn	%ymm4, %ymm15, %ymm3
	vmovdqu	%ymm3, -96(%r9,%rbx)
	vmovdqu	%ymm1, -64(%r9,%rbx)
	vmovdqu	%ymm2, -32(%r9,%rbx)
	vmovdqu	%ymm0, (%r9,%rbx)
	vpxor	%xmm0, %xmm0, %xmm0
	subq	$-128, %rbx
	cmpq	%rbx, %r10
	jne	.LBB2_99
# %bb.100:                              # %"end for conv__0.s0._0._0.loopexit.us"
                                        #   in Loop: Header=BB2_98 Depth=2
	incq	%r12
	addq	%r13, %r9
	addq	8(%rsp), %r11                   # 8-byte Folded Reload
	cmpq	96(%rsp), %r12                  # 8-byte Folded Reload
	jne	.LBB2_98
.LBB2_101:                              # %"end for conv__0.s0._1.rebased"
                                        #   in Loop: Header=BB2_96 Depth=1
	movq	40(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	56(%rsp), %r12                  # 8-byte Reload
	addq	%r12, 64(%rsp)                  # 8-byte Folded Spill
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	24(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	cmpq	$17, %rcx
	jne	.LBB2_96
# %bb.102:                              # %"end for conv__0.s0._2"
	testq	%r14, %r14
	je	.LBB2_104
# %bb.103:                              # %if.then.i526
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r14, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_104:                              # %call_destructor.exit527
	movq	192(%rsp), %rdx                 # 8-byte Reload
	movl	%edx, %eax
	movl	%edx, %ecx
	addq	$8, %rdx
	movq	%rdx, 192(%rsp)                 # 8-byte Spill
	cmpl	$-7, %eax
	movl	$-8, %edx
	cmovgel	%ecx, %edx
	leal	8(%rdx), %eax
	movq	%rax, %rcx
	movq	160(%rsp), %r14                 # 8-byte Reload
	imulq	%r14, %rcx
	movq	%rcx, %rsi
	shlq	$6, %rsi
	leaq	(%rsi,%rcx,4), %rbx
	movl	$2147483648, %r15d              # imm = 0x80000000
	cmpq	%r15, %rbx
	jae	.LBB2_370
# %bb.105:                              # %call_destructor.exit527
	leal	32(,%rdx,4), %edx
	imulq	%r14, %rdx
	shrq	$32, %rdx
	shrq	$30, %rax
	imulq	%r14, %rax
	addq	%rdx, %rax
	shll	$2, %ecx
	movq	%rcx, %rdx
	shlq	$4, %rdx
	addq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rax, %rcx
	shlq	$4, %rcx
	addq	%rax, %rcx
	addq	%rdx, %rcx
	orq	%rax, %rcx
	shrq	$32, %rcx
	jne	.LBB2_370
# %bb.106:                              # %"assert succeeded51"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	testq	%rbx, %rbx
	je	.LBB2_108
# %bb.107:                              # %"assert succeeded51"
	testq	%rax, %rax
	je	.LBB2_385
.LBB2_108:                              # %"for upsampled_linear__0.s0._2.preheader"
	movq	192(%rsp), %rsi                 # 8-byte Reload
	movl	%esi, %edi
	imull	76(%rsp), %edi                  # 4-byte Folded Reload
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setle	%cl
	movq	392(%rsp), %rdx                 # 8-byte Reload
	testl	%edx, %edx
	setle	%r8b
	movslq	%edi, %rbp
	orb	%cl, %r8b
	shlq	$5, %rdx
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	leaq	32(%rax), %r9
	shlq	$2, %rbp
	leaq	(,%rsi,4), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %rsi                  # 8-byte Reload
	leaq	4(%rsi), %r11
	xorl	%r10d, %r10d
	vmovdqa	.LCPI2_3(%rip), %ymm0           # ymm0 = [0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15,16,17,20,21,24,25,28,29,24,25,28,29,28,29,30,31]
	.p2align	4, 0x90
.LBB2_109:                              # %"for upsampled_linear__0.s0._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_111 Depth 2
                                        #       Child Loop BB2_112 Depth 3
	testb	%r8b, %r8b
	jne	.LBB2_114
# %bb.110:                              # %"for upsampled_linear__0.s0._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_109 Depth=1
	movq	%r11, %rdi
	movq	%r9, %rcx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB2_111:                              # %"for upsampled_linear__0.s0._1.rebased.us"
                                        #   Parent Loop BB2_109 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_112 Depth 3
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB2_112:                              # %"for upsampled_linear__0.s0._0._0.us"
                                        #   Parent Loop BB2_109 Depth=1
                                        #     Parent Loop BB2_111 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqu	(%rdi,%rbx), %ymm1
	vpaddd	-4(%rdi,%rbx), %ymm1, %ymm2
	vpshufb	%ymm0, %ymm2, %ymm2
	vpermq	$232, %ymm2, %ymm2              # ymm2 = ymm2[0,2,2,3]
	vpsraw	$2, %xmm2, %xmm2
	vpmovsxwd	%xmm2, %ymm2
	vpshufb	%ymm0, %ymm1, %ymm1
	vpermq	$232, %ymm1, %ymm1              # ymm1 = ymm1[0,2,2,3]
	vpaddw	%xmm1, %xmm1, %xmm1
	vpsraw	$2, %xmm1, %xmm1
	vpmovsxwd	%xmm1, %ymm1
	vextracti128	$1, %ymm1, %xmm3
	vextracti128	$1, %ymm2, %xmm4
	vpunpckldq	%xmm3, %xmm4, %xmm5     # xmm5 = xmm4[0],xmm3[0],xmm4[1],xmm3[1]
	vpunpckhdq	%xmm3, %xmm4, %xmm3     # xmm3 = xmm4[2],xmm3[2],xmm4[3],xmm3[3]
	vpunpckldq	%xmm1, %xmm2, %xmm4     # xmm4 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	vpunpckhdq	%xmm1, %xmm2, %xmm1     # xmm1 = xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	vmovdqa	%xmm1, -16(%rcx,%rbx,2)
	vmovdqa	%xmm4, -32(%rcx,%rbx,2)
	vmovdqa	%xmm3, 16(%rcx,%rbx,2)
	vmovdqa	%xmm5, (%rcx,%rbx,2)
	addq	$32, %rbx
	cmpq	%rbx, %rdx
	jne	.LBB2_112
# %bb.113:                              # %"end for upsampled_linear__0.s0._0._0.loopexit.us"
                                        #   in Loop: Header=BB2_111 Depth=2
	incq	%rax
	addq	32(%rsp), %rcx                  # 8-byte Folded Reload
	addq	%r13, %rdi
	cmpq	96(%rsp), %rax                  # 8-byte Folded Reload
	jne	.LBB2_111
.LBB2_114:                              # %"end for upsampled_linear__0.s0._1.rebased"
                                        #   in Loop: Header=BB2_109 Depth=1
	incq	%r10
	addq	%rbp, %r9
	addq	%r12, %r11
	cmpq	$17, %r10
	jne	.LBB2_109
# %bb.115:                              # %"end for upsampled_linear__0.s0._2"
	testq	%rsi, %rsi
	je	.LBB2_117
# %bb.116:                              # %if.then.i529
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_free@PLT
.LBB2_117:                              # %call_destructor.exit530
	movq	400(%rsp), %rcx                 # 8-byte Reload
	leal	8(%rcx), %eax
	movl	%eax, 56(%rsp)                  # 4-byte Spill
	cmpl	$-7, %ecx
	movl	$-8, %eax
	cmovgel	%ecx, %eax
	leal	8(%rax), %esi
	movq	%rsi, %r12
	imulq	%r14, %r12
	movq	%r12, %rbx
	shlq	$4, %rbx
	cmpq	%r15, %rbx
	jae	.LBB2_371
# %bb.118:                              # %call_destructor.exit530
	leal	32(,%rax,4), %eax
	imulq	%r14, %rax
	shrq	$32, %rax
	movq	%rsi, %rcx
	shrq	$30, %rcx
	imulq	%r14, %rcx
	addq	%rax, %rcx
	movq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rcx, 144(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	shrq	$30, %rax
	movq	%rdx, 136(%rsp)                 # 8-byte Spill
	orq	%rdx, %rax
	jne	.LBB2_371
# %bb.119:                              # %"assert succeeded55"
	movq	%rsi, 48(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	movq	%rax, %r15
	testq	%rbx, %rbx
	je	.LBB2_121
# %bb.120:                              # %"assert succeeded55"
	testq	%r15, %r15
	je	.LBB2_413
.LBB2_121:                              # %"for all_r$1.s0._2.preheader"
	movl	76(%rsp), %eax                  # 4-byte Reload
	movl	56(%rsp), %ecx                  # 4-byte Reload
	imull	%ecx, %eax
	movl	%eax, 76(%rsp)                  # 4-byte Spill
	movq	%r12, 88(%rsp)                  # 8-byte Spill
	leal	(,%r12,4), %eax
	movq	%rax, 184(%rsp)                 # 8-byte Spill
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setg	%al
	movq	104(%rsp), %r14                 # 8-byte Reload
	testl	%r14d, %r14d
	setg	%dl
	movslq	%ecx, %rcx
	movq	%rcx, 112(%rsp)                 # 8-byte Spill
	leaq	(,%rcx,4), %r13
	shlq	$5, %r14
	andb	%al, %dl
	movb	%dl, 40(%rsp)                   # 1-byte Spill
	xorl	%eax, %eax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_122:                              # %"for all_r$1.s0._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_124 Depth 2
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	cmpb	$0, 40(%rsp)                    # 1-byte Folded Reload
	je	.LBB2_125
# %bb.123:                              # %"for all_r$1.s0._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_122 Depth=1
	movslq	24(%rsp), %rax                  # 4-byte Folded Reload
	leaq	(%r15,%rax,4), %rbx
	movq	96(%rsp), %r12                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_124:                              # %"for all_r$1.s0._1.rebased.us"
                                        #   Parent Loop BB2_122 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
	addq	%r13, %rbx
	decq	%r12
	jne	.LBB2_124
.LBB2_125:                              # %"end for all_r$1.s0._1.rebased"
                                        #   in Loop: Header=BB2_122 Depth=1
	movq	64(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	24(%rsp), %rax                  # 8-byte Reload
	addl	76(%rsp), %eax                  # 4-byte Folded Reload
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	cmpq	$4, %rcx
	jne	.LBB2_122
# %bb.126:                              # %"for all_r$1.s1._2.preheader"
	movslq	76(%rsp), %rax                  # 4-byte Folded Reload
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movl	$18, %eax
	xorl	%ecx, %ecx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	.p2align	4, 0x90
.LBB2_127:                              # %"for all_r$1.s1._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_130 Depth 2
                                        #       Child Loop BB2_131 Depth 3
                                        #         Child Loop BB2_132 Depth 4
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_135
# %bb.128:                              # %"for all_r$1.s1._1.rebased.preheader"
                                        #   in Loop: Header=BB2_127 Depth=1
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_135
# %bb.129:                              # %"for all_r$1.s1._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_127 Depth=1
	movq	24(%rsp), %r9                   # 8-byte Reload
	imulq	40(%rsp), %r9                   # 8-byte Folded Reload
	movq	80(%rsp), %r10                  # 8-byte Reload
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB2_130:                              # %"for all_r$1.s1._1.rebased.us"
                                        #   Parent Loop BB2_127 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_131 Depth 3
                                        #         Child Loop BB2_132 Depth 4
	movq	%r11, %r12
	imulq	112(%rsp), %r12                 # 8-byte Folded Reload
	addq	%r9, %r12
	movq	%r10, %rbx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_131:                              # %"for all_r$1.s1._0._0.us"
                                        #   Parent Loop BB2_127 Depth=1
                                        #     Parent Loop BB2_130 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_132 Depth 4
	leaq	(%r12,%rdx,8), %rcx
	vmovdqa	(%r15,%rcx,4), %ymm0
	movq	%rbx, %rsi
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB2_132:                              # %"for all_r$1.s1.r127$x.us"
                                        #   Parent Loop BB2_127 Depth=1
                                        #     Parent Loop BB2_130 Depth=2
                                        #       Parent Loop BB2_131 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rax,%r8), %edi
	vmovd	%edi, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpmulld	(%rsi), %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$17, %r8
	addq	%rbp, %rsi
	cmpq	$289, %r8                       # imm = 0x121
	jne	.LBB2_132
# %bb.133:                              # %"end for all_r$1.s1.r127$x.us"
                                        #   in Loop: Header=BB2_131 Depth=3
	vmovdqa	%ymm0, (%r15,%rcx,4)
	incq	%rdx
	addq	$32, %rbx
	cmpq	104(%rsp), %rdx                 # 8-byte Folded Reload
	jne	.LBB2_131
# %bb.134:                              # %"end for all_r$1.s1._0._0.loopexit.us"
                                        #   in Loop: Header=BB2_130 Depth=2
	incq	%r11
	addq	32(%rsp), %r10                  # 8-byte Folded Reload
	cmpq	96(%rsp), %r11                  # 8-byte Folded Reload
	jne	.LBB2_130
.LBB2_135:                              # %"end for all_r$1.s1._1.rebased"
                                        #   in Loop: Header=BB2_127 Depth=1
	movq	24(%rsp), %rdx                  # 8-byte Reload
	incq	%rdx
	incq	%rax
	movq	%rdx, %rcx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	cmpq	$4, %rdx
	jne	.LBB2_127
# %bb.136:                              # %"end for all_r$1.s1._2"
	movq	80(%rsp), %rsi                  # 8-byte Reload
	testq	%rsi, %rsi
	je	.LBB2_138
# %bb.137:                              # %if.then.i532
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_free@PLT
.LBB2_138:                              # %call_destructor.exit533
	movq	88(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rax,%rax,2), %rbp
	addq	%rcx, %rbp
	movl	$2147483648, %eax               # imm = 0x80000000
	cmpq	%rax, %rbp
	jae	.LBB2_372
# %bb.139:                              # %call_destructor.exit533
	movq	48(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rcx, %rax
	movl	%eax, %ecx
	shrq	$32, %rax
	movq	160(%rsp), %rdx                 # 8-byte Reload
	imulq	%rdx, %rcx
	shrq	$32, %rcx
	imulq	%rdx, %rax
	addq	%rcx, %rax
	shrq	$32, %rax
	jne	.LBB2_372
# %bb.140:                              # %"assert succeeded59"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbp, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	movq	%rax, %rbx
	movq	%rbp, 48(%rsp)                  # 8-byte Spill
	testq	%rbp, %rbp
	je	.LBB2_142
# %bb.141:                              # %"assert succeeded59"
	testq	%rbx, %rbx
	je	.LBB2_398
.LBB2_142:                              # %"assert succeeded61"
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_157
# %bb.143:                              # %"for sum$1.s0._1.rebased.preheader"
	movq	272(%rsp), %rax                 # 8-byte Reload
	addl	$56, %eax
	movl	%eax, 64(%rsp)                  # 4-byte Spill
	xorl	%eax, %eax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_144:                              # %"for sum$1.s0._1.rebased"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_146 Depth 2
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_147
# %bb.145:                              # %"for sum$1.s0._2.us.preheader"
                                        #   in Loop: Header=BB2_144 Depth=1
	movslq	32(%rsp), %rax                  # 4-byte Folded Reload
	leaq	(%rbx,%rax,4), %rbp
	movl	$7, %r12d
	.p2align	4, 0x90
.LBB2_146:                              # %"for sum$1.s0._2.us"
                                        #   Parent Loop BB2_144 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbp, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
	addq	%r13, %rbp
	decq	%r12
	jne	.LBB2_146
.LBB2_147:                              # %"end for sum$1.s0._2"
                                        #   in Loop: Header=BB2_144 Depth=1
	movq	24(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	32(%rsp), %rax                  # 8-byte Reload
	addl	64(%rsp), %eax                  # 4-byte Folded Reload
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	cmpq	96(%rsp), %rcx                  # 8-byte Folded Reload
	jne	.LBB2_144
# %bb.148:                              # %"for sum$1.s1._1.rebased.preheader"
	movslq	64(%rsp), %rax                  # 4-byte Folded Reload
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	movq	40(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rcx
	xorl	%eax, %eax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	%r15, %r8
	.p2align	4, 0x90
.LBB2_149:                              # %"for sum$1.s1._1.rebased"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_151 Depth 2
                                        #       Child Loop BB2_152 Depth 3
                                        #         Child Loop BB2_153 Depth 4
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_156
# %bb.150:                              # %"for sum$1.s1._2.us.preheader"
                                        #   in Loop: Header=BB2_149 Depth=1
	movq	32(%rsp), %r11                  # 8-byte Reload
	imulq	24(%rsp), %r11                  # 8-byte Folded Reload
	movq	432(%rsp), %rbp                 # 8-byte Reload
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB2_151:                              # %"for sum$1.s1._2.us"
                                        #   Parent Loop BB2_149 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_152 Depth 3
                                        #         Child Loop BB2_153 Depth 4
	movq	%r12, %rax
	imulq	112(%rsp), %rax                 # 8-byte Folded Reload
	addq	%r11, %rax
	movq	%r8, %r10
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB2_152:                              # %"for sum$1.s1._0._0.us"
                                        #   Parent Loop BB2_149 Depth=1
                                        #     Parent Loop BB2_151 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_153 Depth 4
	leaq	(%rax,%rdi,8), %rdx
	vmovdqa	(%rbx,%rdx,4), %ymm0
	movq	%r10, %rsi
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB2_153:                              # %"for sum$1.s1.r141$z.us"
                                        #   Parent Loop BB2_149 Depth=1
                                        #     Parent Loop BB2_151 Depth=2
                                        #       Parent Loop BB2_152 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	vpbroadcastd	(%rbp,%r9), %ymm1
	vpmulld	(%rsi), %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$28, %r9
	addq	%rcx, %rsi
	cmpq	$112, %r9
	jne	.LBB2_153
# %bb.154:                              # %"end for sum$1.s1.r141$z.us"
                                        #   in Loop: Header=BB2_152 Depth=3
	vmovdqa	%ymm0, (%rbx,%rdx,4)
	incq	%rdi
	addq	$32, %r10
	cmpq	104(%rsp), %rdi                 # 8-byte Folded Reload
	jne	.LBB2_152
# %bb.155:                              # %"end for sum$1.s1._0._0.loopexit.us"
                                        #   in Loop: Header=BB2_151 Depth=2
	incq	%r12
	addq	$4, %rbp
	cmpq	$7, %r12
	jne	.LBB2_151
.LBB2_156:                              # %"end for sum$1.s1._2"
                                        #   in Loop: Header=BB2_149 Depth=1
	movq	32(%rsp), %rdx                  # 8-byte Reload
	incq	%rdx
	addq	%r13, %r8
	movq	%rdx, %rax
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	cmpq	96(%rsp), %rdx                  # 8-byte Folded Reload
	jne	.LBB2_149
.LBB2_157:                              # %"end for sum$1.s1._1.rebased"
	testq	%r15, %r15
	je	.LBB2_159
# %bb.158:                              # %if.then.i535
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r15, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_159:                              # %call_destructor.exit536
	movq	184(%rsp), %rcx                 # 8-byte Reload
	leaq	(,%rcx,8), %rax
	subq	%rcx, %rax
	shrq	$32, %rax
	movq	144(%rsp), %rdx                 # 8-byte Reload
	leaq	(,%rdx,8), %rcx
	subq	%rdx, %rcx
	addq	%rax, %rcx
	shrq	$32, %rcx
	orq	136(%rsp), %rcx                 # 8-byte Folded Reload
	movq	48(%rsp), %rbp                  # 8-byte Reload
	jne	.LBB2_390
# %bb.160:                              # %"assert succeeded63"
	movq	%r14, 80(%rsp)                  # 8-byte Spill
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbp, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	testq	%rbp, %rbp
	je	.LBB2_162
# %bb.161:                              # %"assert succeeded63"
	testq	%rax, %rax
	je	.LBB2_405
.LBB2_162:                              # %"for conv2D_w__0_1.s0._2.preheader"
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	setg	%al
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setg	%dl
	movq	272(%rsp), %rcx                 # 8-byte Reload
	addl	$56, %ecx
	movslq	%ecx, %rsi
	shlq	$2, %rsi
	andb	%al, %dl
	movb	%dl, 48(%rsp)                   # 1-byte Spill
	xorl	%eax, %eax
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	movl	$0, 32(%rsp)                    # 4-byte Folded Spill
	xorl	%ecx, %ecx
	movq	%r13, 8(%rsp)                   # 8-byte Spill
	movq	80(%rsp), %r14                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_163:                              # %"for conv2D_w__0_1.s0._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_165 Depth 2
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	cmpb	$0, 48(%rsp)                    # 1-byte Folded Reload
	je	.LBB2_166
# %bb.164:                              # %"for conv2D_w__0_1.s0._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_163 Depth=1
	movslq	32(%rsp), %rax                  # 4-byte Folded Reload
	leaq	(%rbx,%rax,4), %r12
	movslq	112(%rsp), %rax                 # 4-byte Folded Reload
	movq	24(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%rax,4), %rbp
	movq	96(%rsp), %r15                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_165:                              # %"for conv2D_w__0_1.s0._1.rebased.us"
                                        #   Parent Loop BB2_163 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbp, %rdi
	movq	%rsi, %r13
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
	movq	%r13, %rsi
	movq	8(%rsp), %r13                   # 8-byte Reload
	addq	%rsi, %r12
	addq	%r13, %rbp
	decq	%r15
	jne	.LBB2_165
.LBB2_166:                              # %"end for conv2D_w__0_1.s0._1.rebased"
                                        #   in Loop: Header=BB2_163 Depth=1
	movq	64(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movl	32(%rsp), %eax                  # 4-byte Reload
	addl	56(%rsp), %eax                  # 4-byte Folded Reload
	movl	%eax, 32(%rsp)                  # 4-byte Spill
	movq	112(%rsp), %rax                 # 8-byte Reload
	addl	76(%rsp), %eax                  # 4-byte Folded Reload
	movq	%rax, 112(%rsp)                 # 8-byte Spill
	cmpq	$7, %rcx
	jne	.LBB2_163
# %bb.167:                              # %"end for conv2D_w__0_1.s0._2"
	testq	%rbx, %rbx
	je	.LBB2_169
# %bb.168:                              # %if.then.i538
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	callq	halide_free@PLT
.LBB2_169:                              # %call_destructor.exit539
	imulq	$44, 88(%rsp), %rbx             # 8-byte Folded Reload
	movl	$2147483648, %eax               # imm = 0x80000000
	cmpq	%rax, %rbx
	movq	80(%rsp), %r14                  # 8-byte Reload
	jae	.LBB2_373
# %bb.170:                              # %call_destructor.exit539
	movq	184(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rcx,4), %rax
	leaq	(%rcx,%rax,2), %rax
	shrq	$32, %rax
	movq	144(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%rdx,4), %rcx
	leaq	(%rdx,%rcx,2), %rcx
	addq	%rax, %rcx
	shrq	$32, %rcx
	orq	136(%rsp), %rcx                 # 8-byte Folded Reload
	jne	.LBB2_373
# %bb.171:                              # %"assert succeeded67"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	callq	halide_malloc@PLT
	testq	%rbx, %rbx
	je	.LBB2_173
# %bb.172:                              # %"assert succeeded67"
	testq	%rax, %rax
	je	.LBB2_417
.LBB2_173:                              # %"for relu.s0._2.preheader"
	movq	40(%rsp), %rcx                  # 8-byte Reload
	leaq	(,%rcx,4), %rbx
	leaq	(%rcx,%rcx,4), %rdx
	movq	24(%rsp), %rsi                  # 8-byte Reload
	leaq	(%rsi,%rdx,4), %rdx
	movq	%rdx, 112(%rsp)                 # 8-byte Spill
	leaq	(%rcx,%rcx,2), %rdx
	leaq	(%rsi,%rdx,8), %rdi
	movq	%rdi, 32(%rsp)                  # 8-byte Spill
	movq	%rcx, %rdi
	shlq	$4, %rdi
	addq	%rsi, %rdi
	movq	%rdi, 56(%rsp)                  # 8-byte Spill
	leaq	(%rsi,%rdx,4), %rdx
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	leaq	(%rsi,%rcx,8), %rdx
	movq	%rdx, 88(%rsp)                  # 8-byte Spill
	leaq	(%rsi,%rcx,4), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	xorl	%esi, %esi
	vpxor	%xmm0, %xmm0, %xmm0
	movq	%rax, 64(%rsp)                  # 8-byte Spill
	.p2align	4, 0x90
.LBB2_174:                              # %"for relu.s0._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_177 Depth 2
                                        #       Child Loop BB2_178 Depth 3
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_180
# %bb.175:                              # %"for relu.s0._1.rebased.preheader"
                                        #   in Loop: Header=BB2_174 Depth=1
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_180
# %bb.176:                              # %"for relu.s0._1.rebased.us.preheader"
                                        #   in Loop: Header=BB2_174 Depth=1
	leal	15(%rsi), %ecx
	leal	8(%rsi), %edx
	leal	22(%rsi), %edi
	leal	29(%rsi), %ebp
	movq	%rax, %r10
	leal	36(%rsi), %eax
	leal	50(%rsi), %r8d
	leal	43(%rsi), %r9d
	vmovd	%ecx, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vmovd	%edx, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vmovd	%edi, %xmm3
	vpbroadcastd	%xmm3, %ymm3
	vmovd	%ebp, %xmm4
	vpbroadcastd	%xmm4, %ymm4
	vmovd	%eax, %xmm5
	movq	%r10, %rax
	vpbroadcastd	%xmm5, %ymm5
	vmovd	%r8d, %xmm6
	vpbroadcastd	%xmm6, %ymm6
	vmovd	%r9d, %xmm7
	vpbroadcastd	%xmm7, %ymm7
	movq	40(%rsp), %rbp                  # 8-byte Reload
	movq	24(%rsp), %rdi                  # 8-byte Reload
	movq	88(%rsp), %r11                  # 8-byte Reload
	movq	48(%rsp), %r10                  # 8-byte Reload
	movq	56(%rsp), %rdx                  # 8-byte Reload
	movq	32(%rsp), %r8                   # 8-byte Reload
	movq	112(%rsp), %r12                 # 8-byte Reload
	movq	%rax, %rcx
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB2_177:                              # %"for relu.s0._1.rebased.us"
                                        #   Parent Loop BB2_174 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_178 Depth 3
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB2_178:                              # %"for relu.s0._0._0.us"
                                        #   Parent Loop BB2_174 Depth=1
                                        #     Parent Loop BB2_177 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vpmulld	(%rbp,%r9), %ymm1, %ymm8
	vpmulld	(%rdi,%r9), %ymm2, %ymm9
	vpmulld	(%r11,%r9), %ymm3, %ymm10
	vpmulld	(%r10,%r9), %ymm4, %ymm11
	vpaddd	%ymm8, %ymm9, %ymm8
	vpmulld	(%rdx,%r9), %ymm5, %ymm9
	vpaddd	%ymm11, %ymm10, %ymm10
	vpmulld	(%r8,%r9), %ymm6, %ymm11
	vpaddd	%ymm10, %ymm8, %ymm8
	vpmulld	(%r12,%r9), %ymm7, %ymm10
	vpaddd	%ymm11, %ymm9, %ymm9
	vpaddd	%ymm10, %ymm9, %ymm9
	vpaddd	%ymm9, %ymm8, %ymm8
	vpmaxsd	%ymm0, %ymm8, %ymm8
	vmovdqa	%ymm8, (%rcx,%r9)
	addq	$32, %r9
	cmpq	%r9, %r14
	jne	.LBB2_178
# %bb.179:                              # %"end for relu.s0._0._0.loopexit.us"
                                        #   in Loop: Header=BB2_177 Depth=2
	incq	%r15
	addq	%r13, %rcx
	addq	%r13, %r12
	addq	%r13, %r8
	addq	%r13, %rdx
	addq	%r13, %r10
	addq	%r13, %r11
	addq	%r13, %rdi
	addq	%r13, %rbp
	cmpq	96(%rsp), %r15                  # 8-byte Folded Reload
	jne	.LBB2_177
.LBB2_180:                              # %"end for relu.s0._1.rebased"
                                        #   in Loop: Header=BB2_174 Depth=1
	incq	%rsi
	addq	%rbx, %rax
	cmpq	$11, %rsi
	jne	.LBB2_174
# %bb.181:                              # %"end for relu.s0._2"
	movq	24(%rsp), %rsi                  # 8-byte Reload
	testq	%rsi, %rsi
	je	.LBB2_183
# %bb.182:                              # %if.then.i541
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_free@PLT
.LBB2_183:                              # %call_destructor.exit542
	movq	152(%rsp), %rcx                 # 8-byte Reload
	leal	(,%rcx,8), %eax
	movl	%eax, 112(%rsp)                 # 4-byte Spill
	movl	344(%rsp), %eax                 # 4-byte Reload
	incl	%eax
	vmovd	%eax, %xmm0
	vpbroadcastd	%xmm0, %ymm0
	vpaddd	.LCPI2_0(%rip), %ymm0, %ymm0
	vmovd	260(%rsp), %xmm1                # 4-byte Folded Reload
                                        # xmm1 = mem[0],zero,zero,zero
	vpbroadcastd	%xmm1, %ymm1
	vpcmpgtd	%ymm1, %ymm0, %ymm0
	movslq	224(%rsp), %r11                 # 4-byte Folded Reload
	shlq	$5, %rcx
	addq	64(%rsp), %rcx                  # 8-byte Folded Reload
	movq	%rcx, 152(%rsp)                 # 8-byte Spill
	movl	$12, %edx
	xorl	%eax, %eax
	vpcmpeqd	%ymm1, %ymm1, %ymm1
	vpxor	%ymm1, %ymm0, %ymm0
	movq	336(%rsp), %r15                 # 8-byte Reload
	movq	%r11, 96(%rsp)                  # 8-byte Spill
	jmp	.LBB2_185
	.p2align	4, 0x90
.LBB2_184:                              # %"end for sum$3.s1._1._1i"
                                        #   in Loop: Header=BB2_185 Depth=1
	movq	32(%rsp), %rax                  # 8-byte Reload
	incq	%rax
	incq	%rdx
	cmpq	$4, %rax
	je	.LBB2_361
.LBB2_185:                              # %"for sum$3.s1._2"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_197 Depth 2
                                        #       Child Loop BB2_198 Depth 3
                                        #         Child Loop BB2_199 Depth 4
                                        #     Child Loop BB2_187 Depth 2
                                        #       Child Loop BB2_189 Depth 3
                                        #         Child Loop BB2_190 Depth 4
                                        #       Child Loop BB2_193 Depth 3
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	imulq	440(%rsp), %rax                 # 8-byte Folded Reload
	movq	%rax, 104(%rsp)                 # 8-byte Spill
	testb	$1, 183(%rsp)                   # 1-byte Folded Reload
	je	.LBB2_195
# %bb.186:                              # %"for sum$3.s1._1._1i.us.preheader"
                                        #   in Loop: Header=BB2_185 Depth=1
	movq	152(%rsp), %r14                 # 8-byte Reload
	movq	64(%rsp), %r8                   # 8-byte Reload
	xorl	%r12d, %r12d
	.p2align	4, 0x90
.LBB2_187:                              # %"for sum$3.s1._1._1i.us"
                                        #   Parent Loop BB2_185 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_189 Depth 3
                                        #         Child Loop BB2_190 Depth 4
                                        #       Child Loop BB2_193 Depth 3
	leaq	(%r12,%r11), %rcx
	imulq	192(%rsp), %rcx                 # 8-byte Folded Reload
	cmpl	$0, 128(%rsp)                   # 4-byte Folded Reload
	movq	%r15, %rdi
	jle	.LBB2_192
# %bb.188:                              # %"for sum$3.s1._0._0.us.preheader"
                                        #   in Loop: Header=BB2_187 Depth=2
	movq	104(%rsp), %rax                 # 8-byte Reload
	leaq	(%rcx,%rax), %r11
	movq	%r8, %r15
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB2_189:                              # %"for sum$3.s1._0._0.us"
                                        #   Parent Loop BB2_185 Depth=1
                                        #     Parent Loop BB2_187 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_190 Depth 4
	leaq	(%r11,%rbp,8), %rax
	vmovdqa	(%rdi,%rax,4), %ymm1
	movq	%r15, %rsi
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB2_190:                              # %"for sum$3.s1.r242$x.us"
                                        #   Parent Loop BB2_185 Depth=1
                                        #     Parent Loop BB2_187 Depth=2
                                        #       Parent Loop BB2_189 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rdx,%r9), %r10d
	vmovd	%r10d, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vpmulld	(%rsi), %ymm2, %ymm2
	vpaddd	%ymm1, %ymm2, %ymm1
	addq	$11, %r9
	addq	%rbx, %rsi
	cmpq	$121, %r9
	jne	.LBB2_190
# %bb.191:                              # %"end for sum$3.s1.r242$x.us"
                                        #   in Loop: Header=BB2_189 Depth=3
	movq	336(%rsp), %rdi                 # 8-byte Reload
	vmovdqa	%ymm1, (%rdi,%rax,4)
	incq	%rbp
	addq	$32, %r15
	cmpq	128(%rsp), %rbp                 # 8-byte Folded Reload
	jne	.LBB2_189
.LBB2_192:                              # %"end for sum$3.s1._0._0.us"
                                        #   in Loop: Header=BB2_187 Depth=2
	addl	104(%rsp), %ecx                 # 4-byte Folded Reload
	addl	112(%rsp), %ecx                 # 4-byte Folded Reload
	movslq	%ecx, %rax
	leaq	(%rdi,%rax,4), %rax
	movq	%r14, %rcx
	xorl	%esi, %esi
	movq	%rdi, %r15
	.p2align	4, 0x90
.LBB2_193:                              # %"for sum$3.s1.r242$x73.us"
                                        #   Parent Loop BB2_185 Depth=1
                                        #     Parent Loop BB2_187 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vpmaskmovd	(%rax), %ymm0, %ymm1
	vpmaskmovd	(%rcx), %ymm0, %ymm2
	leal	(%rdx,%rsi), %edi
	vmovd	%edi, %xmm3
	vpbroadcastd	%xmm3, %ymm3
	vpmulld	%ymm2, %ymm3, %ymm2
	vpaddd	%ymm1, %ymm2, %ymm1
	vpmaskmovd	%ymm1, %ymm0, (%rax)
	addq	$11, %rsi
	addq	%rbx, %rcx
	cmpq	$121, %rsi
	jne	.LBB2_193
# %bb.194:                              # %after_bb70.loopexit.us
                                        #   in Loop: Header=BB2_187 Depth=2
	incq	%r12
	addq	%r13, %r8
	addq	%r13, %r14
	cmpq	$8, %r12
	movq	96(%rsp), %r11                  # 8-byte Reload
	jne	.LBB2_187
	jmp	.LBB2_184
	.p2align	4, 0x90
.LBB2_195:                              # %"for sum$3.s1._2.split"
                                        #   in Loop: Header=BB2_185 Depth=1
	cmpl	$0, 128(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_184
# %bb.196:                              # %"for sum$3.s1._1._1i.us1132.preheader"
                                        #   in Loop: Header=BB2_185 Depth=1
	movq	64(%rsp), %r14                  # 8-byte Reload
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB2_197:                              # %"for sum$3.s1._1._1i.us1132"
                                        #   Parent Loop BB2_185 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_198 Depth 3
                                        #         Child Loop BB2_199 Depth 4
	leaq	(%r8,%r11), %r9
	imulq	192(%rsp), %r9                  # 8-byte Folded Reload
	addq	104(%rsp), %r9                  # 8-byte Folded Reload
	movq	%r14, %rsi
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB2_198:                              # %"for sum$3.s1._0._0.us1136"
                                        #   Parent Loop BB2_185 Depth=1
                                        #     Parent Loop BB2_197 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_199 Depth 4
	leaq	(%r9,%rbp,8), %r10
	vmovdqa	(%r15,%r10,4), %ymm1
	movq	%rsi, %rdi
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_199:                              # %"for sum$3.s1.r242$x.us1142"
                                        #   Parent Loop BB2_185 Depth=1
                                        #     Parent Loop BB2_197 Depth=2
                                        #       Parent Loop BB2_198 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rdx,%rcx), %eax
	vmovd	%eax, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vpmulld	(%rdi), %ymm2, %ymm2
	vpaddd	%ymm1, %ymm2, %ymm1
	addq	$11, %rcx
	addq	%rbx, %rdi
	cmpq	$121, %rcx
	jne	.LBB2_199
# %bb.200:                              # %"end for sum$3.s1.r242$x.us1145"
                                        #   in Loop: Header=BB2_198 Depth=3
	vmovdqa	%ymm1, (%r15,%r10,4)
	incq	%rbp
	addq	$32, %rsi
	cmpq	128(%rsp), %rbp                 # 8-byte Folded Reload
	jne	.LBB2_198
# %bb.201:                              # %"end for sum$3.s1._0._0.loopexit.us1151"
                                        #   in Loop: Header=BB2_197 Depth=2
	incq	%r8
	addq	%r13, %r14
	cmpq	$8, %r8
	jne	.LBB2_197
	jmp	.LBB2_184
.LBB2_202:                              # %next_bb
	cmpq	%r9, %r10
	jae	.LBB2_391
# %bb.203:                              # %"assert succeeded78"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r10, %rsi
	callq	halide_malloc@PLT
	movq	%rax, %r15
	testq	%r13, %r13
	je	.LBB2_205
# %bb.204:                              # %"assert succeeded78"
	testq	%r15, %r15
	je	.LBB2_393
.LBB2_205:                              # %"assert succeeded80"
	movq	240(%rsp), %rdi                 # 8-byte Reload
	addl	224(%rsp), %edi                 # 4-byte Folded Reload
	movq	152(%rsp), %rax                 # 8-byte Reload
	leal	-1(%rax), %ecx
	movq	264(%rsp), %rdx                 # 8-byte Reload
	vmovd	%edx, %xmm0
	vpbroadcastd	%xmm0, %ymm10
	movq	96(%rsp), %rax                  # 8-byte Reload
	addl	$-6, %eax
	vmovd	204(%rsp), %xmm1                # 4-byte Folded Reload
                                        # xmm1 = mem[0],zero,zero,zero
	vpbroadcastd	%xmm1, %ymm1
	decl	%edx
	vmovd	%edx, %xmm2
	vpbroadcastd	%xmm2, %ymm11
	movq	8(%rsp), %rdx                   # 8-byte Reload
	decl	%edx
	movslq	136(%rsp), %rsi                 # 4-byte Folded Reload
	movq	%rsi, 64(%rsp)                  # 8-byte Spill
	movslq	%edi, %rsi
	movq	%rsi, 56(%rsp)                  # 8-byte Spill
	movslq	%edx, %r10
	movl	76(%rsp), %edx                  # 4-byte Reload
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	movslq	172(%rsp), %rdx                 # 4-byte Folded Reload
	movq	%rdx, 48(%rsp)                  # 8-byte Spill
	movslq	%ecx, %rcx
	movq	%rcx, 88(%rsp)                  # 8-byte Spill
	xorl	%edx, %edx
	vpcmpeqd	%ymm9, %ymm9, %ymm9
	vbroadcastss	.LCPI2_1(%rip), %ymm12  # ymm12 = [7,7,7,7,7,7,7,7]
	.p2align	4, 0x90
.LBB2_206:                              # %"for constant_exterior.s0._283"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_209 Depth 2
                                        #       Child Loop BB2_210 Depth 3
	movq	88(%rsp), %rcx                  # 8-byte Reload
	cmpq	%rcx, %rdx
	movl	%ecx, %r13d
	movq	%rdx, 80(%rsp)                  # 8-byte Spill
	cmovlel	%edx, %r13d
	movq	232(%rsp), %rcx                 # 8-byte Reload
	cmpl	%ecx, %r13d
	cmovlel	%ecx, %r13d
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_212
# %bb.207:                              # %"for constant_exterior.s0._1.rebased85.preheader"
                                        #   in Loop: Header=BB2_206 Depth=1
	movq	80(%rsp), %rdx                  # 8-byte Reload
	cmpq	232(%rsp), %rdx                 # 8-byte Folded Reload
	setl	%cl
	cmpq	152(%rsp), %rdx                 # 8-byte Folded Reload
	setge	40(%rsp)                        # 1-byte Folded Spill
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_212
# %bb.208:                              # %"for constant_exterior.s0._1.rebased85.us.preheader"
                                        #   in Loop: Header=BB2_206 Depth=1
	movq	80(%rsp), %r14                  # 8-byte Reload
	imulq	48(%rsp), %r14                  # 8-byte Folded Reload
	imull	216(%rsp), %r13d                # 4-byte Folded Reload
	subl	176(%rsp), %r13d                # 4-byte Folded Reload
	orb	%cl, 40(%rsp)                   # 1-byte Folded Spill
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB2_209:                              # %"for constant_exterior.s0._1.rebased85.us"
                                        #   Parent Loop BB2_206 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_210 Depth 3
	movq	%r11, %rsi
	imulq	64(%rsp), %rsi                  # 8-byte Folded Reload
	addq	%r14, %rsi
	movq	56(%rsp), %rcx                  # 8-byte Reload
	leaq	(%r11,%rcx), %rdi
	movq	24(%rsp), %rcx                  # 8-byte Reload
	cmpq	%rcx, %rdi
	setl	%bl
	cmpq	8(%rsp), %rdi                   # 8-byte Folded Reload
	setge	%dl
	orb	40(%rsp), %bl                   # 1-byte Folded Reload
	orb	%dl, %bl
	vmovd	%ebx, %xmm5
	vpbroadcastb	%xmm5, %xmm5
	cmpq	%r10, %rdi
	movl	%r10d, %edx
	cmovlel	%edi, %edx
	cmpl	%ecx, %edx
	cmovlel	%ecx, %edx
	imull	32(%rsp), %edx                  # 4-byte Folded Reload
	addl	%r13d, %edx
	vmovd	%edx, %xmm6
	vpbroadcastd	%xmm6, %ymm6
	movl	$4, %edi
	movq	112(%rsp), %rdx                 # 8-byte Reload
	movl	%edx, %r8d
	.p2align	4, 0x90
.LBB2_210:                              # %"for constant_exterior.s0._0._088.us"
                                        #   Parent Loop BB2_206 Depth=1
                                        #     Parent Loop BB2_209 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	cmpl	%edi, %r12d
	movl	%r12d, %r9d
	cmovgl	%edi, %r9d
	leal	(%rax,%r9), %edx
	vmovd	%edx, %xmm7
	vpbroadcastd	%xmm7, %ymm7
	vpaddd	.LCPI2_0(%rip), %ymm7, %ymm7
	vpminsd	%ymm7, %ymm11, %ymm8
	vpmaxsd	%ymm1, %ymm8, %ymm8
	vpaddd	%ymm6, %ymm8, %ymm8
	vextracti128	$1, %ymm8, %xmm3
	vpmovsxdq	%xmm3, %ymm3
	vpmovsxdq	%xmm8, %ymm8
	vmovq	%xmm3, %rdx
	vmovd	(%rbp,%rdx,4), %xmm0            # xmm0 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm3, %rdx
	vextracti128	$1, %ymm3, %xmm3
	vpinsrd	$1, (%rbp,%rdx,4), %xmm0, %xmm0
	vmovq	%xmm3, %rdx
	vpinsrd	$2, (%rbp,%rdx,4), %xmm0, %xmm0
	vpextrq	$1, %xmm3, %rdx
	vpinsrd	$3, (%rbp,%rdx,4), %xmm0, %xmm0
	vmovq	%xmm8, %rdx
	vmovd	(%rbp,%rdx,4), %xmm3            # xmm3 = mem[0],zero,zero,zero
	vpextrq	$1, %xmm8, %rdx
	vpinsrd	$1, (%rbp,%rdx,4), %xmm3, %xmm3
	vextracti128	$1, %ymm8, %xmm2
	vmovq	%xmm2, %rdx
	vpinsrd	$2, (%rbp,%rdx,4), %xmm3, %xmm3
	vpextrq	$1, %xmm2, %rdx
	vpinsrd	$3, (%rbp,%rdx,4), %xmm3, %xmm2
	vpcmpgtd	%ymm7, %ymm10, %ymm3
	vpxor	%ymm3, %ymm9, %ymm3
	vextracti128	$1, %ymm3, %xmm4
	vpackssdw	%xmm4, %xmm3, %xmm3
	vpcmpgtd	%ymm7, %ymm1, %ymm4
	vextracti128	$1, %ymm4, %xmm7
	vpackssdw	%xmm7, %xmm4, %xmm4
	vpor	%xmm5, %xmm4, %xmm4
	vpor	%xmm3, %xmm4, %xmm3
	vpmovzxwd	%xmm3, %ymm3            # ymm3 = xmm3[0],zero,xmm3[1],zero,xmm3[2],zero,xmm3[3],zero,xmm3[4],zero,xmm3[5],zero,xmm3[6],zero,xmm3[7],zero
	vpslld	$31, %ymm3, %ymm3
	vinserti128	$1, %xmm0, %ymm2, %ymm0
	vblendvps	%ymm3, %ymm12, %ymm0, %ymm0
	movslq	%r9d, %rdx
	addq	%rsi, %rdx
	vmovups	%ymm0, -16(%r15,%rdx,4)
	addl	$8, %edi
	decl	%r8d
	jne	.LBB2_210
# %bb.211:                              # %"end for constant_exterior.s0._0._089.loopexit.us"
                                        #   in Loop: Header=BB2_209 Depth=2
	incq	%r11
	cmpq	128(%rsp), %r11                 # 8-byte Folded Reload
	jne	.LBB2_209
.LBB2_212:                              # %"end for constant_exterior.s0._1.rebased86"
                                        #   in Loop: Header=BB2_206 Depth=1
	movq	80(%rsp), %rdx                  # 8-byte Reload
	incq	%rdx
	cmpq	$3, %rdx
	jne	.LBB2_206
# %bb.213:                              # %"end for constant_exterior.s0._284"
	imulq	$100, 296(%rsp), %rbx           # 8-byte Folded Reload
	movl	$2147483648, %eax               # imm = 0x80000000
	cmpq	%rax, %rbx
	jae	.LBB2_374
# %bb.214:                              # %"end for constant_exterior.s0._284"
	movq	360(%rsp), %rax                 # 8-byte Reload
	leaq	(%rax,%rax,4), %rax
	leaq	(%rax,%rax,4), %rax
	shrq	$32, %rax
	movq	368(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%rdx,4), %rcx
	leaq	(%rcx,%rcx,4), %rcx
	addq	%rax, %rcx
	orq	%rdx, %rcx
	shrq	$32, %rcx
	jne	.LBB2_374
# %bb.215:                              # %"assert succeeded94"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	movq	%rax, %r13
	testq	%rbx, %rbx
	je	.LBB2_217
# %bb.216:                              # %"assert succeeded94"
	testq	%r13, %r13
	je	.LBB2_398
.LBB2_217:                              # %"for sum.s0._299.preheader"
	movq	112(%rsp), %rcx                 # 8-byte Reload
	testl	%ecx, %ecx
	setg	%al
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setg	%bl
	movq	64(%rsp), %rdx                  # 8-byte Reload
	leaq	(,%rdx,4), %rdx
	movq	%rdx, 32(%rsp)                  # 8-byte Spill
	shlq	$5, %rcx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	andb	%al, %bl
	movb	%bl, 40(%rsp)                   # 1-byte Spill
	xorl	%eax, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB2_218:                              # %"for sum.s0._299"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_220 Depth 2
	cmpb	$0, 40(%rsp)                    # 1-byte Folded Reload
	je	.LBB2_221
# %bb.219:                              # %"for sum.s0._1.rebased102.us.preheader"
                                        #   in Loop: Header=BB2_218 Depth=1
	movslq	8(%rsp), %rax                   # 4-byte Folded Reload
	leaq	(,%rax,4), %rbx
	addq	%r13, %rbx
	movq	128(%rsp), %rbp                 # 8-byte Reload
	.p2align	4, 0x90
.LBB2_220:                              # %"for sum.s0._1.rebased102.us"
                                        #   Parent Loop BB2_218 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	24(%rsp), %rdx                  # 8-byte Reload
	callq	memset@PLT
	addq	32(%rsp), %rbx                  # 8-byte Folded Reload
	decq	%rbp
	jne	.LBB2_220
.LBB2_221:                              # %"end for sum.s0._1.rebased103"
                                        #   in Loop: Header=BB2_218 Depth=1
	incq	%r14
	movq	8(%rsp), %rax                   # 8-byte Reload
	addl	172(%rsp), %eax                 # 4-byte Folded Reload
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	cmpq	$25, %r14
	jne	.LBB2_218
# %bb.222:                              # %"for sum.s1._2109.preheader"
	movq	48(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %r14
	movl	$4, %eax
	xorl	%ecx, %ecx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	.p2align	4, 0x90
.LBB2_223:                              # %"for sum.s1._2109"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_226 Depth 2
                                        #       Child Loop BB2_227 Depth 3
                                        #         Child Loop BB2_228 Depth 4
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_231
# %bb.224:                              # %"for sum.s1._1.rebased112.preheader"
                                        #   in Loop: Header=BB2_223 Depth=1
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_231
# %bb.225:                              # %"for sum.s1._1.rebased112.us.preheader"
                                        #   in Loop: Header=BB2_223 Depth=1
	movq	8(%rsp), %r11                   # 8-byte Reload
	imulq	48(%rsp), %r11                  # 8-byte Folded Reload
	movq	%r15, %r9
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB2_226:                              # %"for sum.s1._1.rebased112.us"
                                        #   Parent Loop BB2_223 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_227 Depth 3
                                        #         Child Loop BB2_228 Depth 4
	movq	%r10, %rdi
	imulq	64(%rsp), %rdi                  # 8-byte Folded Reload
	movq	%r9, %rbp
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_227:                              # %"for sum.s1._0._0115.us"
                                        #   Parent Loop BB2_223 Depth=1
                                        #     Parent Loop BB2_226 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_228 Depth 4
	leaq	(%rdi,%rcx,8), %rbx
	addq	%r11, %rbx
	vmovdqa	(%r13,%rbx,4), %ymm0
	movq	%rbp, %rsi
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_228:                              # %"for sum.s1.r88$x118.us"
                                        #   Parent Loop BB2_223 Depth=1
                                        #     Parent Loop BB2_226 Depth=2
                                        #       Parent Loop BB2_227 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rax,%rdx), %r8d
	vmovd	%r8d, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpmulld	(%rsi), %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$3, %rdx
	addq	%r14, %rsi
	cmpq	$9, %rdx
	jne	.LBB2_228
# %bb.229:                              # %"end for sum.s1.r88$x119.us"
                                        #   in Loop: Header=BB2_227 Depth=3
	vmovdqa	%ymm0, (%r13,%rbx,4)
	incq	%rcx
	addq	$32, %rbp
	cmpq	112(%rsp), %rcx                 # 8-byte Folded Reload
	jne	.LBB2_227
# %bb.230:                              # %"end for sum.s1._0._0116.loopexit.us"
                                        #   in Loop: Header=BB2_226 Depth=2
	incq	%r10
	addq	32(%rsp), %r9                   # 8-byte Folded Reload
	cmpq	128(%rsp), %r10                 # 8-byte Folded Reload
	jne	.LBB2_226
.LBB2_231:                              # %"end for sum.s1._1.rebased113"
                                        #   in Loop: Header=BB2_223 Depth=1
	movq	8(%rsp), %rdx                   # 8-byte Reload
	incq	%rdx
	incq	%rax
	movq	%rdx, %rcx
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	cmpq	$25, %rdx
	jne	.LBB2_223
# %bb.232:                              # %"end for sum.s1._2110"
	testq	%r15, %r15
	je	.LBB2_234
# %bb.233:                              # %if.then.i547
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r15, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_234:                              # %call_destructor.exit548
	movq	376(%rsp), %rax                 # 8-byte Reload
	leal	8(%rax), %ebp
	cmpl	$-7, %eax
	movl	$-8, %edx
	cmovgel	%eax, %edx
	leal	8(%rdx), %eax
	movq	%rax, %rcx
	movq	160(%rsp), %rdi                 # 8-byte Reload
	imulq	%rdi, %rcx
	movq	%rcx, %rsi
	shlq	$6, %rsi
	leaq	(%rsi,%rcx,4), %rbx
	movl	$2147483648, %esi               # imm = 0x80000000
	cmpq	%rsi, %rbx
	jae	.LBB2_376
# %bb.235:                              # %call_destructor.exit548
	leal	32(,%rdx,4), %edx
	imulq	%rdi, %rdx
	shrq	$32, %rdx
	shrq	$30, %rax
	imulq	%rdi, %rax
	addq	%rdx, %rax
	shll	$2, %ecx
	movq	%rcx, %rdx
	shlq	$4, %rdx
	addq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rax, %rcx
	shlq	$4, %rcx
	addq	%rax, %rcx
	addq	%rdx, %rcx
	orq	%rax, %rcx
	shrq	$32, %rcx
	jne	.LBB2_376
# %bb.236:                              # %"assert succeeded123"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	testq	%rbx, %rbx
	je	.LBB2_238
# %bb.237:                              # %"assert succeeded123"
	testq	%rax, %rax
	je	.LBB2_395
.LBB2_238:                              # %"for all_r.s0._2128.preheader"
	movq	%rax, 48(%rsp)                  # 8-byte Spill
	movslq	%ebp, %rcx
	imull	76(%rsp), %ebp                  # 4-byte Folded Reload
	movl	%ebp, 80(%rsp)                  # 4-byte Spill
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	setg	%al
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setg	%dl
	movq	%rcx, 64(%rsp)                  # 8-byte Spill
	leaq	(,%rcx,4), %rcx
	movq	%rcx, 8(%rsp)                   # 8-byte Spill
	andb	%al, %dl
	movb	%dl, 88(%rsp)                   # 1-byte Spill
	xorl	%eax, %eax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	xorl	%ecx, %ecx
	movq	24(%rsp), %r15                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_239:                              # %"for all_r.s0._2128"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_241 Depth 2
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	cmpb	$0, 88(%rsp)                    # 1-byte Folded Reload
	je	.LBB2_242
# %bb.240:                              # %"for all_r.s0._1.rebased131.us.preheader"
                                        #   in Loop: Header=BB2_239 Depth=1
	movslq	40(%rsp), %rax                  # 4-byte Folded Reload
	movq	48(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%rax,4), %rbx
	movq	128(%rsp), %rbp                 # 8-byte Reload
	.p2align	4, 0x90
.LBB2_241:                              # %"for all_r.s0._1.rebased131.us"
                                        #   Parent Loop BB2_239 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r15, %rdx
	callq	memset@PLT
	addq	8(%rsp), %rbx                   # 8-byte Folded Reload
	decq	%rbp
	jne	.LBB2_241
.LBB2_242:                              # %"end for all_r.s0._1.rebased132"
                                        #   in Loop: Header=BB2_239 Depth=1
	movq	56(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	40(%rsp), %rax                  # 8-byte Reload
	addl	80(%rsp), %eax                  # 4-byte Folded Reload
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	cmpq	$17, %rcx
	jne	.LBB2_239
# %bb.243:                              # %"for all_r.s1._2138.preheader"
	movslq	80(%rsp), %rax                  # 4-byte Folded Reload
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movl	$26, %eax
	xorl	%ecx, %ecx
	movq	%rcx, 24(%rsp)                  # 8-byte Spill
	movq	48(%rsp), %r15                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_244:                              # %"for all_r.s1._2138"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_247 Depth 2
                                        #       Child Loop BB2_248 Depth 3
                                        #         Child Loop BB2_249 Depth 4
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_252
# %bb.245:                              # %"for all_r.s1._1.rebased141.preheader"
                                        #   in Loop: Header=BB2_244 Depth=1
	cmpl	$0, 112(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_252
# %bb.246:                              # %"for all_r.s1._1.rebased141.us.preheader"
                                        #   in Loop: Header=BB2_244 Depth=1
	movq	24(%rsp), %r9                   # 8-byte Reload
	imulq	40(%rsp), %r9                   # 8-byte Folded Reload
	movq	%r13, %r10
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB2_247:                              # %"for all_r.s1._1.rebased141.us"
                                        #   Parent Loop BB2_244 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_248 Depth 3
                                        #         Child Loop BB2_249 Depth 4
	movq	%r11, %rdi
	imulq	64(%rsp), %rdi                  # 8-byte Folded Reload
	addq	%r9, %rdi
	movq	%r10, %rbp
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_248:                              # %"for all_r.s1._0._0144.us"
                                        #   Parent Loop BB2_244 Depth=1
                                        #     Parent Loop BB2_247 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_249 Depth 4
	leaq	(%rdi,%rdx,8), %rcx
	vmovdqu	(%r15,%rcx,4), %ymm0
	movq	%rbp, %rsi
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB2_249:                              # %"for all_r.s1.r110$x147.us"
                                        #   Parent Loop BB2_244 Depth=1
                                        #     Parent Loop BB2_247 Depth=2
                                        #       Parent Loop BB2_248 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rax,%rbx), %r8d
	vmovd	%r8d, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpmulld	(%rsi), %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$25, %rbx
	addq	%r14, %rsi
	cmpq	$625, %rbx                      # imm = 0x271
	jne	.LBB2_249
# %bb.250:                              # %"end for all_r.s1.r110$x148.us"
                                        #   in Loop: Header=BB2_248 Depth=3
	vmovdqu	%ymm0, (%r15,%rcx,4)
	incq	%rdx
	addq	$32, %rbp
	cmpq	112(%rsp), %rdx                 # 8-byte Folded Reload
	jne	.LBB2_248
# %bb.251:                              # %"end for all_r.s1._0._0145.loopexit.us"
                                        #   in Loop: Header=BB2_247 Depth=2
	incq	%r11
	addq	32(%rsp), %r10                  # 8-byte Folded Reload
	cmpq	128(%rsp), %r11                 # 8-byte Folded Reload
	jne	.LBB2_247
.LBB2_252:                              # %"end for all_r.s1._1.rebased142"
                                        #   in Loop: Header=BB2_244 Depth=1
	movq	24(%rsp), %rdx                  # 8-byte Reload
	incq	%rdx
	incq	%rax
	movq	%rdx, %rcx
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	cmpq	$17, %rdx
	jne	.LBB2_244
# %bb.253:                              # %"end for all_r.s1._2139"
	testq	%r13, %r13
	je	.LBB2_255
# %bb.254:                              # %if.then.i550
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r13, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_255:                              # %call_destructor.exit551
	movq	208(%rsp), %rbx                 # 8-byte Reload
	movl	%ebx, %eax
	movl	%ebx, %ecx
	addq	$10, %rbx
	cmpl	$-9, %eax
	movl	$-10, %edx
	cmovgel	%ecx, %edx
	leal	10(%rdx), %eax
	movq	%rax, %rcx
	movq	160(%rsp), %rdi                 # 8-byte Reload
	imulq	%rdi, %rcx
	movq	%rcx, %rsi
	shlq	$6, %rsi
	leaq	(%rsi,%rcx,4), %rbp
	movl	$2147483648, %esi               # imm = 0x80000000
	cmpq	%rsi, %rbp
	jae	.LBB2_378
# %bb.256:                              # %call_destructor.exit551
	leal	40(,%rdx,4), %edx
	imulq	%rdi, %rdx
	shrq	$32, %rdx
	shrq	$30, %rax
	imulq	%rdi, %rax
	addq	%rdx, %rax
	shll	$2, %ecx
	movq	%rcx, %rdx
	shlq	$4, %rdx
	addq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rax, %rcx
	shlq	$4, %rcx
	addq	%rax, %rcx
	addq	%rdx, %rcx
	orq	%rax, %rcx
	shrq	$32, %rcx
	jne	.LBB2_378
# %bb.257:                              # %"assert succeeded152"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbp, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	testq	%rbp, %rbp
	je	.LBB2_259
# %bb.258:                              # %"assert succeeded152"
	testq	%rax, %rax
	je	.LBB2_385
.LBB2_259:                              # %"for conv__0.s0._2158.preheader"
	movl	%ebx, %edx
	imull	76(%rsp), %edx                  # 4-byte Folded Reload
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setle	%sil
	movq	384(%rsp), %r10                 # 8-byte Reload
	testl	%r10d, %r10d
	setle	%cl
	movslq	%edx, %rdx
	orb	%sil, %cl
	movb	%cl, 80(%rsp)                   # 1-byte Spill
	shlq	$7, %r10
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	addq	$96, %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	shlq	$2, %rdx
	movq	%rdx, 64(%rsp)                  # 8-byte Spill
	shlq	$2, %rbx
	movq	%rbx, 208(%rsp)                 # 8-byte Spill
	leaq	104(%r15), %rax
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	shlq	$2, 40(%rsp)                    # 8-byte Folded Spill
	xorl	%ecx, %ecx
	vpbroadcastd	.LCPI2_2(%rip), %ymm8   # ymm8 = [255,255,255,255,255,255,255,255]
	vpxor	%xmm0, %xmm0, %xmm0
	vxorps	%xmm12, %xmm12, %xmm12
	.p2align	4, 0x90
.LBB2_260:                              # %"for conv__0.s0._2158"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_262 Depth 2
                                        #       Child Loop BB2_263 Depth 3
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	cmpb	$0, 80(%rsp)                    # 1-byte Folded Reload
	jne	.LBB2_265
# %bb.261:                              # %"for conv__0.s0._1.rebased161.us.preheader"
                                        #   in Loop: Header=BB2_260 Depth=1
	movq	24(%rsp), %r11                  # 8-byte Reload
	movq	32(%rsp), %r9                   # 8-byte Reload
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB2_262:                              # %"for conv__0.s0._1.rebased161.us"
                                        #   Parent Loop BB2_260 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_263 Depth 3
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB2_263:                              # %"for conv__0.s0._0._0164.us"
                                        #   Parent Loop BB2_260 Depth=1
                                        #     Parent Loop BB2_262 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqu	-40(%r11,%rbp), %ymm2
	vmovdqu	-8(%r11,%rbp), %ymm4
	vmovdqu	-104(%r11,%rbp), %ymm1
	vmovdqu	-100(%r11,%rbp), %ymm6
	vmovdqu	-72(%r11,%rbp), %ymm5
	vmovdqu	-68(%r11,%rbp), %ymm3
	vpsubd	-96(%r11,%rbp), %ymm1, %ymm7
	vpsubd	-64(%r11,%rbp), %ymm5, %ymm1
	vpsubd	-32(%r11,%rbp), %ymm2, %ymm9
	vpsubd	(%r11,%rbp), %ymm4, %ymm14
	vpand	%ymm7, %ymm8, %ymm5
	vpcmpeqd	%ymm0, %ymm6, %ymm15
	vpor	%ymm6, %ymm15, %ymm7
	vextracti128	$1, %ymm7, %xmm4
	vpextrd	$1, %xmm4, %ecx
	vmovdqu	-36(%r11,%rbp), %ymm11
	vextracti128	$1, %ymm5, %xmm2
	vpextrd	$1, %xmm2, %eax
	vmovdqu	-4(%r11,%rbp), %ymm6
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vmovd	%xmm4, %esi
	vmovd	%xmm2, %eax
	cltd
	idivl	%esi
	vpextrd	$2, %xmm4, %esi
	vpextrd	$2, %xmm2, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%esi
	vpinsrd	$1, %ecx, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm4, %ecx
	vpextrd	$3, %xmm2, %eax
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpextrd	$1, %xmm7, %esi
	vpextrd	$1, %xmm5, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm0
	vmovdqa	%xmm0, 112(%rsp)                # 16-byte Spill
	vmovd	%xmm7, %ecx
	vmovd	%xmm5, %eax
	cltd
	idivl	%ecx
	vpextrd	$2, %xmm7, %ecx
	vpextrd	$2, %xmm5, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%ecx
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm7, %ecx
	vpextrd	$3, %xmm5, %eax
	vpcmpeqd	%ymm3, %ymm12, %ymm5
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpor	%ymm3, %ymm5, %ymm3
	vextracti128	$1, %ymm3, %xmm2
	vpextrd	$1, %xmm2, %esi
	vpand	%ymm1, %ymm8, %ymm10
	vextracti128	$1, %ymm10, %xmm1
	vpextrd	$1, %xmm1, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm7
	vmovd	%xmm2, %ecx
	vmovd	%xmm1, %eax
	cltd
	idivl	%ecx
	vpextrd	$2, %xmm2, %ecx
	vpextrd	$2, %xmm1, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%ecx
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm2, %ecx
	vpextrd	$3, %xmm1, %eax
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpextrd	$1, %xmm3, %esi
	vpextrd	$1, %xmm10, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm1
	vmovd	%xmm3, %ecx
	vmovd	%xmm10, %eax
	cltd
	idivl	%ecx
	vpextrd	$2, %xmm3, %ecx
	vpextrd	$2, %xmm10, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%ecx
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm3, %ecx
	vpextrd	$3, %xmm10, %eax
	vpcmpeqd	%ymm12, %ymm11, %ymm10
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpor	%ymm11, %ymm10, %ymm11
	vextracti128	$1, %ymm11, %xmm2
	vpextrd	$1, %xmm2, %esi
	vpand	%ymm8, %ymm9, %ymm13
	vextracti128	$1, %ymm13, %xmm3
	vpextrd	$1, %xmm3, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm9
	vmovd	%xmm2, %ecx
	vmovd	%xmm3, %eax
	cltd
	idivl	%ecx
	vpextrd	$2, %xmm2, %ecx
	vpextrd	$2, %xmm3, %eax
	vmovd	%edx, %xmm0
	cltd
	idivl	%ecx
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpinsrd	$2, %edx, %xmm0, %xmm0
	vpextrd	$3, %xmm2, %ecx
	vpextrd	$3, %xmm3, %eax
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpextrd	$1, %xmm11, %esi
	vpextrd	$1, %xmm13, %eax
	cltd
	idivl	%esi
	movl	%edx, %esi
	vpinsrd	$3, %ecx, %xmm0, %xmm3
	vmovd	%xmm11, %ecx
	vmovd	%xmm13, %eax
	cltd
	idivl	%ecx
	vmovd	%edx, %xmm0
	vpinsrd	$1, %esi, %xmm0, %xmm0
	vpextrd	$2, %xmm11, %ecx
	vpextrd	$2, %xmm13, %eax
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vpextrd	$3, %xmm11, %esi
	vpextrd	$3, %xmm13, %eax
	vpcmpeqd	%ymm6, %ymm12, %ymm11
	cltd
	idivl	%esi
	vpinsrd	$2, %ecx, %xmm0, %xmm0
	vpinsrd	$3, %edx, %xmm0, %xmm13
	vpor	%ymm6, %ymm11, %ymm6
	vextracti128	$1, %ymm6, %xmm0
	vpextrd	$1, %xmm0, %ecx
	vpand	%ymm8, %ymm14, %ymm4
	vextracti128	$1, %ymm4, %xmm2
	vpextrd	$1, %xmm2, %eax
	vpextrd	$2, %xmm0, %r8d
	vpextrd	$3, %xmm0, %r14d
	vmovd	%xmm0, %esi
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vmovd	%xmm2, %eax
	cltd
	idivl	%esi
	vpextrd	$2, %xmm2, %eax
	vpextrd	$3, %xmm2, %esi
	vmovd	%edx, %xmm0
	vpinsrd	$1, %ecx, %xmm0, %xmm0
	cltd
	idivl	%r8d
	movl	%edx, %ecx
	movl	%esi, %eax
	cltd
	idivl	%r14d
	vpinsrd	$2, %ecx, %xmm0, %xmm0
	vpinsrd	$3, %edx, %xmm0, %xmm0
	vpextrd	$1, %xmm6, %ecx
	vpextrd	$1, %xmm4, %eax
	vpextrd	$2, %xmm6, %ebx
	vpextrd	$3, %xmm6, %edi
	vmovd	%xmm6, %esi
	cltd
	idivl	%ecx
	movl	%edx, %ecx
	vmovd	%xmm4, %eax
	cltd
	idivl	%esi
	vpextrd	$2, %xmm4, %eax
	vpextrd	$3, %xmm4, %esi
	vmovd	%edx, %xmm2
	vpinsrd	$1, %ecx, %xmm2, %xmm2
	vinserti128	$1, 112(%rsp), %ymm7, %ymm4 # 16-byte Folded Reload
	cltd
	idivl	%ebx
	movl	%edx, %ecx
	vinserti128	$1, %xmm1, %ymm9, %ymm1
	movl	%esi, %eax
	cltd
	idivl	%edi
	vpinsrd	$2, %ecx, %xmm2, %xmm2
	vpinsrd	$3, %edx, %xmm2, %xmm2
	vinserti128	$1, %xmm3, %ymm13, %ymm3
	vinserti128	$1, %xmm0, %ymm2, %ymm0
	vpandn	%ymm0, %ymm11, %ymm0
	vpandn	%ymm3, %ymm10, %ymm2
	vpandn	%ymm1, %ymm5, %ymm1
	vpandn	%ymm4, %ymm15, %ymm3
	vmovdqu	%ymm3, -96(%r9,%rbp)
	vmovdqu	%ymm1, -64(%r9,%rbp)
	vmovdqu	%ymm2, -32(%r9,%rbp)
	vmovdqu	%ymm0, (%r9,%rbp)
	vpxor	%xmm0, %xmm0, %xmm0
	subq	$-128, %rbp
	cmpq	%rbp, %r10
	jne	.LBB2_263
# %bb.264:                              # %"end for conv__0.s0._0._0165.loopexit.us"
                                        #   in Loop: Header=BB2_262 Depth=2
	incq	%r13
	addq	208(%rsp), %r9                  # 8-byte Folded Reload
	addq	8(%rsp), %r11                   # 8-byte Folded Reload
	cmpq	128(%rsp), %r13                 # 8-byte Folded Reload
	jne	.LBB2_262
.LBB2_265:                              # %"end for conv__0.s0._1.rebased162"
                                        #   in Loop: Header=BB2_260 Depth=1
	movq	56(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	32(%rsp), %rax                  # 8-byte Reload
	addq	64(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	addq	40(%rsp), %rax                  # 8-byte Folded Reload
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	cmpq	$17, %rcx
	jne	.LBB2_260
# %bb.266:                              # %"end for conv__0.s0._2159"
	testq	%r15, %r15
	je	.LBB2_268
# %bb.267:                              # %if.then.i553
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r15, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_268:                              # %call_destructor.exit554
	movq	192(%rsp), %rdx                 # 8-byte Reload
	movl	%edx, %eax
	movl	%edx, %ecx
	addq	$8, %rdx
	movq	%rdx, 192(%rsp)                 # 8-byte Spill
	cmpl	$-7, %eax
	movl	$-8, %edx
	cmovgel	%ecx, %edx
	leal	8(%rdx), %eax
	movq	%rax, %rcx
	movq	160(%rsp), %r14                 # 8-byte Reload
	imulq	%r14, %rcx
	movq	%rcx, %rsi
	shlq	$6, %rsi
	leaq	(%rsi,%rcx,4), %rbx
	movl	$2147483648, %r15d              # imm = 0x80000000
	cmpq	%r15, %rbx
	movq	88(%rsp), %r13                  # 8-byte Reload
	jae	.LBB2_380
# %bb.269:                              # %call_destructor.exit554
	leal	32(,%rdx,4), %edx
	imulq	%r14, %rdx
	shrq	$32, %rdx
	shrq	$30, %rax
	imulq	%r14, %rax
	addq	%rdx, %rax
	shll	$2, %ecx
	movq	%rcx, %rdx
	shlq	$4, %rdx
	addq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rax, %rcx
	shlq	$4, %rcx
	addq	%rax, %rcx
	addq	%rdx, %rcx
	orq	%rax, %rcx
	shrq	$32, %rcx
	jne	.LBB2_380
# %bb.270:                              # %"assert succeeded169"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	movq	%rax, %rdi
	testq	%rbx, %rbx
	je	.LBB2_272
# %bb.271:                              # %"assert succeeded169"
	testq	%rdi, %rdi
	je	.LBB2_421
.LBB2_272:                              # %"for upsampled_linear__0.s0._2175.preheader"
	movq	192(%rsp), %rsi                 # 8-byte Reload
	movl	%esi, %eax
	imull	76(%rsp), %eax                  # 4-byte Folded Reload
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setle	%cl
	movq	392(%rsp), %rdx                 # 8-byte Reload
	testl	%edx, %edx
	setle	%r8b
	movslq	%eax, %rbp
	orb	%cl, %r8b
	shlq	$5, %rdx
	movq	%rdi, 48(%rsp)                  # 8-byte Spill
	leaq	32(%rdi), %r9
	shlq	$2, %rbp
	shlq	$2, %rsi
	movq	%rsi, 8(%rsp)                   # 8-byte Spill
	leaq	4(%r13), %r11
	xorl	%r10d, %r10d
	vmovdqa	.LCPI2_3(%rip), %ymm0           # ymm0 = [0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15,16,17,20,21,24,25,28,29,24,25,28,29,28,29,30,31]
	movq	208(%rsp), %rsi                 # 8-byte Reload
	.p2align	4, 0x90
.LBB2_273:                              # %"for upsampled_linear__0.s0._2175"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_275 Depth 2
                                        #       Child Loop BB2_276 Depth 3
	testb	%r8b, %r8b
	jne	.LBB2_278
# %bb.274:                              # %"for upsampled_linear__0.s0._1.rebased178.us.preheader"
                                        #   in Loop: Header=BB2_273 Depth=1
	movq	%r11, %rdi
	movq	%r9, %rcx
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB2_275:                              # %"for upsampled_linear__0.s0._1.rebased178.us"
                                        #   Parent Loop BB2_273 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_276 Depth 3
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB2_276:                              # %"for upsampled_linear__0.s0._0._0181.us"
                                        #   Parent Loop BB2_273 Depth=1
                                        #     Parent Loop BB2_275 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqu	(%rdi,%rbx), %ymm1
	vpaddd	-4(%rdi,%rbx), %ymm1, %ymm2
	vpshufb	%ymm0, %ymm2, %ymm2
	vpermq	$232, %ymm2, %ymm2              # ymm2 = ymm2[0,2,2,3]
	vpsraw	$2, %xmm2, %xmm2
	vpmovsxwd	%xmm2, %ymm2
	vpshufb	%ymm0, %ymm1, %ymm1
	vpermq	$232, %ymm1, %ymm1              # ymm1 = ymm1[0,2,2,3]
	vpaddw	%xmm1, %xmm1, %xmm1
	vpsraw	$2, %xmm1, %xmm1
	vpmovsxwd	%xmm1, %ymm1
	vextracti128	$1, %ymm1, %xmm3
	vextracti128	$1, %ymm2, %xmm4
	vpunpckldq	%xmm3, %xmm4, %xmm5     # xmm5 = xmm4[0],xmm3[0],xmm4[1],xmm3[1]
	vpunpckhdq	%xmm3, %xmm4, %xmm3     # xmm3 = xmm4[2],xmm3[2],xmm4[3],xmm3[3]
	vpunpckldq	%xmm1, %xmm2, %xmm4     # xmm4 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
	vpunpckhdq	%xmm1, %xmm2, %xmm1     # xmm1 = xmm2[2],xmm1[2],xmm2[3],xmm1[3]
	vmovdqa	%xmm1, -16(%rcx,%rbx,2)
	vmovdqa	%xmm4, -32(%rcx,%rbx,2)
	vmovdqa	%xmm3, 16(%rcx,%rbx,2)
	vmovdqa	%xmm5, (%rcx,%rbx,2)
	addq	$32, %rbx
	cmpq	%rbx, %rdx
	jne	.LBB2_276
# %bb.277:                              # %"end for upsampled_linear__0.s0._0._0182.loopexit.us"
                                        #   in Loop: Header=BB2_275 Depth=2
	incq	%rax
	addq	8(%rsp), %rcx                   # 8-byte Folded Reload
	addq	%rsi, %rdi
	cmpq	128(%rsp), %rax                 # 8-byte Folded Reload
	jne	.LBB2_275
.LBB2_278:                              # %"end for upsampled_linear__0.s0._1.rebased179"
                                        #   in Loop: Header=BB2_273 Depth=1
	incq	%r10
	addq	%rbp, %r9
	addq	64(%rsp), %r11                  # 8-byte Folded Reload
	cmpq	$17, %r10
	jne	.LBB2_273
# %bb.279:                              # %"end for upsampled_linear__0.s0._2176"
	testq	%r13, %r13
	je	.LBB2_281
# %bb.280:                              # %if.then.i556
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r13, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_281:                              # %call_destructor.exit557
	movq	400(%rsp), %rcx                 # 8-byte Reload
	leal	8(%rcx), %eax
	movl	%eax, 24(%rsp)                  # 4-byte Spill
	cmpl	$-7, %ecx
	movl	$-8, %eax
	cmovgel	%ecx, %eax
	leal	8(%rax), %esi
	movq	%rsi, %r13
	imulq	%r14, %r13
	movq	%r13, %rbx
	shlq	$4, %rbx
	cmpq	%r15, %rbx
	jae	.LBB2_381
# %bb.282:                              # %call_destructor.exit557
	leal	32(,%rax,4), %eax
	imulq	%r14, %rax
	shrq	$32, %rax
	movq	%rsi, %rcx
	shrq	$30, %rcx
	imulq	%r14, %rcx
	addq	%rax, %rcx
	movq	%rcx, %rdx
	shrq	$32, %rdx
	movq	%rcx, 136(%rsp)                 # 8-byte Spill
	movq	%rcx, %rax
	shrq	$30, %rax
	movq	%rdx, 184(%rsp)                 # 8-byte Spill
	orq	%rdx, %rax
	jne	.LBB2_381
# %bb.283:                              # %"assert succeeded186"
	movq	%rsi, 152(%rsp)                 # 8-byte Spill
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	movq	%rax, %r15
	testq	%rbx, %rbx
	je	.LBB2_285
# %bb.284:                              # %"assert succeeded186"
	testq	%r15, %r15
	je	.LBB2_385
.LBB2_285:                              # %"for all_r$1.s0._2191.preheader"
	movl	24(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %eax
	imull	76(%rsp), %eax                  # 4-byte Folded Reload
	movl	%eax, 80(%rsp)                  # 4-byte Spill
	movq	%r13, 144(%rsp)                 # 8-byte Spill
	leal	(,%r13,4), %eax
	movq	%rax, 208(%rsp)                 # 8-byte Spill
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setg	%al
	movq	104(%rsp), %r14                 # 8-byte Reload
	testl	%r14d, %r14d
	setg	%dl
	movslq	%ecx, %rcx
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	leaq	(,%rcx,4), %rcx
	movq	%rcx, 112(%rsp)                 # 8-byte Spill
	shlq	$5, %r14
	andb	%al, %dl
	movb	%dl, 88(%rsp)                   # 1-byte Spill
	xorl	%eax, %eax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_286:                              # %"for all_r$1.s0._2191"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_288 Depth 2
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	cmpb	$0, 88(%rsp)                    # 1-byte Folded Reload
	je	.LBB2_289
# %bb.287:                              # %"for all_r$1.s0._1.rebased194.us.preheader"
                                        #   in Loop: Header=BB2_286 Depth=1
	movslq	40(%rsp), %rax                  # 4-byte Folded Reload
	leaq	(%r15,%rax,4), %rbx
	movq	128(%rsp), %r13                 # 8-byte Reload
	.p2align	4, 0x90
.LBB2_288:                              # %"for all_r$1.s0._1.rebased194.us"
                                        #   Parent Loop BB2_286 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	memset@PLT
	addq	112(%rsp), %rbx                 # 8-byte Folded Reload
	decq	%r13
	jne	.LBB2_288
.LBB2_289:                              # %"end for all_r$1.s0._1.rebased195"
                                        #   in Loop: Header=BB2_286 Depth=1
	movq	56(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	40(%rsp), %rax                  # 8-byte Reload
	addl	80(%rsp), %eax                  # 4-byte Folded Reload
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	cmpq	$4, %rcx
	jne	.LBB2_286
# %bb.290:                              # %"for all_r$1.s1._2201.preheader"
	movslq	80(%rsp), %rax                  # 4-byte Folded Reload
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movl	$18, %eax
	xorl	%ecx, %ecx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	.p2align	4, 0x90
.LBB2_291:                              # %"for all_r$1.s1._2201"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_294 Depth 2
                                        #       Child Loop BB2_295 Depth 3
                                        #         Child Loop BB2_296 Depth 4
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_299
# %bb.292:                              # %"for all_r$1.s1._1.rebased204.preheader"
                                        #   in Loop: Header=BB2_291 Depth=1
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_299
# %bb.293:                              # %"for all_r$1.s1._1.rebased204.us.preheader"
                                        #   in Loop: Header=BB2_291 Depth=1
	movq	40(%rsp), %r9                   # 8-byte Reload
	imulq	88(%rsp), %r9                   # 8-byte Folded Reload
	movq	48(%rsp), %r10                  # 8-byte Reload
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB2_294:                              # %"for all_r$1.s1._1.rebased204.us"
                                        #   Parent Loop BB2_291 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_295 Depth 3
                                        #         Child Loop BB2_296 Depth 4
	movq	%r11, %r13
	imulq	32(%rsp), %r13                  # 8-byte Folded Reload
	addq	%r9, %r13
	movq	%r10, %rbx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_295:                              # %"for all_r$1.s1._0._0207.us"
                                        #   Parent Loop BB2_291 Depth=1
                                        #     Parent Loop BB2_294 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_296 Depth 4
	leaq	(,%rdx,8), %rcx
	addq	%r13, %rcx
	vmovdqa	(%r15,%rcx,4), %ymm0
	movq	%rbx, %rsi
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB2_296:                              # %"for all_r$1.s1.r127$x210.us"
                                        #   Parent Loop BB2_291 Depth=1
                                        #     Parent Loop BB2_294 Depth=2
                                        #       Parent Loop BB2_295 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rax,%r8), %edi
	vmovd	%edi, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vpmulld	(%rsi), %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$17, %r8
	addq	%rbp, %rsi
	cmpq	$289, %r8                       # imm = 0x121
	jne	.LBB2_296
# %bb.297:                              # %"end for all_r$1.s1.r127$x211.us"
                                        #   in Loop: Header=BB2_295 Depth=3
	vmovdqa	%ymm0, (%r15,%rcx,4)
	incq	%rdx
	addq	$32, %rbx
	cmpq	104(%rsp), %rdx                 # 8-byte Folded Reload
	jne	.LBB2_295
# %bb.298:                              # %"end for all_r$1.s1._0._0208.loopexit.us"
                                        #   in Loop: Header=BB2_294 Depth=2
	incq	%r11
	addq	8(%rsp), %r10                   # 8-byte Folded Reload
	cmpq	128(%rsp), %r11                 # 8-byte Folded Reload
	jne	.LBB2_294
.LBB2_299:                              # %"end for all_r$1.s1._1.rebased205"
                                        #   in Loop: Header=BB2_291 Depth=1
	movq	40(%rsp), %rdx                  # 8-byte Reload
	incq	%rdx
	incq	%rax
	movq	%rdx, %rcx
	movq	%rdx, 40(%rsp)                  # 8-byte Spill
	cmpq	$4, %rdx
	jne	.LBB2_291
# %bb.300:                              # %"end for all_r$1.s1._2202"
	movq	48(%rsp), %rsi                  # 8-byte Reload
	testq	%rsi, %rsi
	je	.LBB2_302
# %bb.301:                              # %if.then.i559
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_free@PLT
.LBB2_302:                              # %call_destructor.exit560
	movq	144(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rax,%rax,2), %rbp
	addq	%rcx, %rbp
	movl	$2147483648, %eax               # imm = 0x80000000
	cmpq	%rax, %rbp
	movq	160(%rsp), %rsi                 # 8-byte Reload
	jae	.LBB2_382
# %bb.303:                              # %call_destructor.exit560
	movq	152(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rax,%rax,2), %rax
	addq	%rcx, %rax
	movl	%eax, %ecx
	shrq	$32, %rax
	imulq	%rsi, %rcx
	shrq	$32, %rcx
	imulq	%rsi, %rax
	addq	%rcx, %rax
	shrq	$32, %rax
	jne	.LBB2_382
# %bb.304:                              # %"assert succeeded214"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbp, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	movq	%rax, %rbx
	movq	%rbp, 48(%rsp)                  # 8-byte Spill
	testq	%rbp, %rbp
	je	.LBB2_306
# %bb.305:                              # %"assert succeeded214"
	testq	%rbx, %rbx
	je	.LBB2_398
.LBB2_306:                              # %"assert succeeded216"
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	movq	%r14, 64(%rsp)                  # 8-byte Spill
	jle	.LBB2_321
# %bb.307:                              # %"for sum$1.s0._1.rebased219.preheader"
	movq	272(%rsp), %rax                 # 8-byte Reload
	addl	$56, %eax
	movl	%eax, 56(%rsp)                  # 4-byte Spill
	xorl	%eax, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_308:                              # %"for sum$1.s0._1.rebased219"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_310 Depth 2
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	movq	112(%rsp), %rcx                 # 8-byte Reload
	jle	.LBB2_311
# %bb.309:                              # %"for sum$1.s0._2222.us.preheader"
                                        #   in Loop: Header=BB2_308 Depth=1
	movslq	8(%rsp), %rax                   # 4-byte Folded Reload
	leaq	(%rbx,%rax,4), %rbp
	movl	$7, %r13d
	.p2align	4, 0x90
.LBB2_310:                              # %"for sum$1.s0._2222.us"
                                        #   Parent Loop BB2_308 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbp, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	movq	%rcx, %r14
	callq	memset@PLT
	movq	%r14, %rcx
	movq	64(%rsp), %r14                  # 8-byte Reload
	addq	%rcx, %rbp
	decq	%r13
	jne	.LBB2_310
.LBB2_311:                              # %"end for sum$1.s0._2223"
                                        #   in Loop: Header=BB2_308 Depth=1
	movq	40(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	8(%rsp), %rax                   # 8-byte Reload
	addl	56(%rsp), %eax                  # 4-byte Folded Reload
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	cmpq	128(%rsp), %rcx                 # 8-byte Folded Reload
	jne	.LBB2_308
# %bb.312:                              # %"for sum$1.s1._1.rebased229.preheader"
	movslq	56(%rsp), %rax                  # 4-byte Folded Reload
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	movq	88(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rcx
	xorl	%eax, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movq	%r15, %r8
	.p2align	4, 0x90
.LBB2_313:                              # %"for sum$1.s1._1.rebased229"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_315 Depth 2
                                        #       Child Loop BB2_316 Depth 3
                                        #         Child Loop BB2_317 Depth 4
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_320
# %bb.314:                              # %"for sum$1.s1._2232.us.preheader"
                                        #   in Loop: Header=BB2_313 Depth=1
	movq	8(%rsp), %r11                   # 8-byte Reload
	imulq	40(%rsp), %r11                  # 8-byte Folded Reload
	movq	432(%rsp), %rbp                 # 8-byte Reload
	xorl	%r13d, %r13d
	.p2align	4, 0x90
.LBB2_315:                              # %"for sum$1.s1._2232.us"
                                        #   Parent Loop BB2_313 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_316 Depth 3
                                        #         Child Loop BB2_317 Depth 4
	movq	%r13, %rax
	imulq	32(%rsp), %rax                  # 8-byte Folded Reload
	addq	%r11, %rax
	movq	%r8, %r10
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB2_316:                              # %"for sum$1.s1._0._0235.us"
                                        #   Parent Loop BB2_313 Depth=1
                                        #     Parent Loop BB2_315 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_317 Depth 4
	leaq	(%rax,%rdi,8), %rdx
	vmovdqa	(%rbx,%rdx,4), %ymm0
	movq	%r10, %rsi
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB2_317:                              # %"for sum$1.s1.r141$z238.us"
                                        #   Parent Loop BB2_313 Depth=1
                                        #     Parent Loop BB2_315 Depth=2
                                        #       Parent Loop BB2_316 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	vpbroadcastd	(%rbp,%r9), %ymm1
	vpmulld	(%rsi), %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$28, %r9
	addq	%rcx, %rsi
	cmpq	$112, %r9
	jne	.LBB2_317
# %bb.318:                              # %"end for sum$1.s1.r141$z239.us"
                                        #   in Loop: Header=BB2_316 Depth=3
	vmovdqa	%ymm0, (%rbx,%rdx,4)
	incq	%rdi
	addq	$32, %r10
	cmpq	104(%rsp), %rdi                 # 8-byte Folded Reload
	jne	.LBB2_316
# %bb.319:                              # %"end for sum$1.s1._0._0236.loopexit.us"
                                        #   in Loop: Header=BB2_315 Depth=2
	incq	%r13
	addq	$4, %rbp
	cmpq	$7, %r13
	jne	.LBB2_315
.LBB2_320:                              # %"end for sum$1.s1._2233"
                                        #   in Loop: Header=BB2_313 Depth=1
	movq	8(%rsp), %rdx                   # 8-byte Reload
	incq	%rdx
	addq	112(%rsp), %r8                  # 8-byte Folded Reload
	movq	%rdx, %rax
	movq	%rdx, 8(%rsp)                   # 8-byte Spill
	cmpq	128(%rsp), %rdx                 # 8-byte Folded Reload
	jne	.LBB2_313
.LBB2_321:                              # %"end for sum$1.s1._1.rebased230"
	testq	%r15, %r15
	je	.LBB2_323
# %bb.322:                              # %if.then.i562
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r15, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB2_323:                              # %call_destructor.exit563
	movq	208(%rsp), %rcx                 # 8-byte Reload
	leaq	(,%rcx,8), %rax
	subq	%rcx, %rax
	shrq	$32, %rax
	movq	136(%rsp), %rdx                 # 8-byte Reload
	leaq	(,%rdx,8), %rcx
	subq	%rdx, %rcx
	addq	%rax, %rcx
	shrq	$32, %rcx
	orq	184(%rsp), %rcx                 # 8-byte Folded Reload
	movq	48(%rsp), %rbp                  # 8-byte Reload
	jne	.LBB2_403
# %bb.324:                              # %"assert succeeded242"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbp, %rsi
	vzeroupper
	callq	halide_malloc@PLT
	testq	%rbp, %rbp
	je	.LBB2_326
# %bb.325:                              # %"assert succeeded242"
	testq	%rax, %rax
	je	.LBB2_405
.LBB2_326:                              # %"for conv2D_w__0_1.s0._2248.preheader"
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	setg	%al
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	setg	%dl
	movq	272(%rsp), %rcx                 # 8-byte Reload
	addl	$56, %ecx
	movslq	%ecx, %rsi
	shlq	$2, %rsi
	andb	%al, %dl
	movb	%dl, 152(%rsp)                  # 1-byte Spill
	xorl	%eax, %eax
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	movl	$0, 40(%rsp)                    # 4-byte Folded Spill
	xorl	%ecx, %ecx
	movq	%rsi, 32(%rsp)                  # 8-byte Spill
	movq	64(%rsp), %r14                  # 8-byte Reload
	.p2align	4, 0x90
.LBB2_327:                              # %"for conv2D_w__0_1.s0._2248"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_329 Depth 2
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	cmpb	$0, 152(%rsp)                   # 1-byte Folded Reload
	je	.LBB2_330
# %bb.328:                              # %"for conv2D_w__0_1.s0._1.rebased251.us.preheader"
                                        #   in Loop: Header=BB2_327 Depth=1
	movslq	40(%rsp), %rax                  # 4-byte Folded Reload
	leaq	(%rbx,%rax,4), %r13
	movslq	8(%rsp), %rax                   # 4-byte Folded Reload
	movq	56(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%rax,4), %rbp
	movq	128(%rsp), %r15                 # 8-byte Reload
	.p2align	4, 0x90
.LBB2_329:                              # %"for conv2D_w__0_1.s0._1.rebased251.us"
                                        #   Parent Loop BB2_327 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbp, %rdi
	movq	%r13, %rsi
	movq	%r14, %rdx
	callq	memcpy@PLT
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	32(%rsp), %rsi                  # 8-byte Reload
	addq	%rsi, %r13
	addq	%rdi, %rbp
	decq	%r15
	jne	.LBB2_329
.LBB2_330:                              # %"end for conv2D_w__0_1.s0._1.rebased252"
                                        #   in Loop: Header=BB2_327 Depth=1
	movq	48(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movl	40(%rsp), %eax                  # 4-byte Reload
	addl	24(%rsp), %eax                  # 4-byte Folded Reload
	movl	%eax, 40(%rsp)                  # 4-byte Spill
	movq	8(%rsp), %rax                   # 8-byte Reload
	addl	80(%rsp), %eax                  # 4-byte Folded Reload
	movq	%rax, 8(%rsp)                   # 8-byte Spill
	cmpq	$7, %rcx
	jne	.LBB2_327
# %bb.331:                              # %"end for conv2D_w__0_1.s0._2249"
	testq	%rbx, %rbx
	je	.LBB2_333
# %bb.332:                              # %if.then.i565
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	callq	halide_free@PLT
.LBB2_333:                              # %call_destructor.exit566
	imulq	$44, 144(%rsp), %rbx            # 8-byte Folded Reload
	movl	$2147483648, %eax               # imm = 0x80000000
	cmpq	%rax, %rbx
	movq	64(%rsp), %r14                  # 8-byte Reload
	jae	.LBB2_384
# %bb.334:                              # %call_destructor.exit566
	movq	208(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rcx,4), %rax
	leaq	(%rcx,%rax,2), %rax
	shrq	$32, %rax
	movq	136(%rsp), %rdx                 # 8-byte Reload
	leaq	(%rdx,%rdx,4), %rcx
	leaq	(%rdx,%rcx,2), %rcx
	addq	%rax, %rcx
	shrq	$32, %rcx
	orq	184(%rsp), %rcx                 # 8-byte Folded Reload
	jne	.LBB2_384
# %bb.335:                              # %"assert succeeded258"
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	callq	halide_malloc@PLT
	movq	%rax, %r13
	testq	%rbx, %rbx
	je	.LBB2_337
# %bb.336:                              # %"assert succeeded258"
	testq	%r13, %r13
	je	.LBB2_425
.LBB2_337:                              # %"for relu.s0._2264.preheader"
	movq	88(%rsp), %rcx                  # 8-byte Reload
	leaq	(,%rcx,4), %rbx
	leaq	(%rcx,%rcx,4), %rax
	movq	56(%rsp), %rdx                  # 8-byte Reload
	leaq	(%rdx,%rax,4), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	leaq	(%rcx,%rcx,2), %rax
	leaq	(%rdx,%rax,8), %rsi
	movq	%rsi, 80(%rsp)                  # 8-byte Spill
	movq	%rcx, %rsi
	shlq	$4, %rsi
	addq	%rdx, %rsi
	movq	%rsi, 48(%rsp)                  # 8-byte Spill
	leaq	(%rdx,%rax,4), %rax
	movq	%rax, 152(%rsp)                 # 8-byte Spill
	leaq	(%rdx,%rcx,8), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	leaq	(%rdx,%rcx,4), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	vpxor	%xmm0, %xmm0, %xmm0
	movq	%r13, 8(%rsp)                   # 8-byte Spill
	vmovdqa	.LCPI2_0(%rip), %ymm12          # ymm12 = [0,1,2,3,4,5,6,7]
	.p2align	4, 0x90
.LBB2_338:                              # %"for relu.s0._2264"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_341 Depth 2
                                        #       Child Loop BB2_342 Depth 3
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_344
# %bb.339:                              # %"for relu.s0._1.rebased267.preheader"
                                        #   in Loop: Header=BB2_338 Depth=1
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_344
# %bb.340:                              # %"for relu.s0._1.rebased267.us.preheader"
                                        #   in Loop: Header=BB2_338 Depth=1
	movq	32(%rsp), %rcx                  # 8-byte Reload
	leal	15(%rcx), %eax
	leal	8(%rcx), %edx
	leal	22(%rcx), %esi
	leal	29(%rcx), %edi
	leal	36(%rcx), %ebp
	leal	50(%rcx), %r8d
	leal	43(%rcx), %r9d
	vmovd	%eax, %xmm1
	vpbroadcastd	%xmm1, %ymm1
	vmovd	%edx, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vmovd	%esi, %xmm3
	vpbroadcastd	%xmm3, %ymm3
	vmovd	%edi, %xmm4
	vpbroadcastd	%xmm4, %ymm4
	vmovd	%ebp, %xmm5
	vpbroadcastd	%xmm5, %ymm5
	vmovd	%r8d, %xmm6
	vpbroadcastd	%xmm6, %ymm6
	vmovd	%r9d, %xmm7
	vpbroadcastd	%xmm7, %ymm7
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	56(%rsp), %rdi                  # 8-byte Reload
	movq	144(%rsp), %r11                 # 8-byte Reload
	movq	152(%rsp), %r10                 # 8-byte Reload
	movq	48(%rsp), %rdx                  # 8-byte Reload
	movq	80(%rsp), %r8                   # 8-byte Reload
	movq	40(%rsp), %rbp                  # 8-byte Reload
	movq	8(%rsp), %rsi                   # 8-byte Reload
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB2_341:                              # %"for relu.s0._1.rebased267.us"
                                        #   Parent Loop BB2_338 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_342 Depth 3
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB2_342:                              # %"for relu.s0._0._0270.us"
                                        #   Parent Loop BB2_338 Depth=1
                                        #     Parent Loop BB2_341 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vpmulld	(%rax,%r15), %ymm1, %ymm8
	vpmulld	(%rdi,%r15), %ymm2, %ymm9
	vpmulld	(%r11,%r15), %ymm3, %ymm10
	vpmulld	(%r10,%r15), %ymm4, %ymm11
	vpaddd	%ymm8, %ymm9, %ymm8
	vpmulld	(%rdx,%r15), %ymm5, %ymm9
	vpaddd	%ymm11, %ymm10, %ymm10
	vpmulld	(%r8,%r15), %ymm6, %ymm11
	vpaddd	%ymm10, %ymm8, %ymm8
	vpmulld	(%rbp,%r15), %ymm7, %ymm10
	vpaddd	%ymm11, %ymm9, %ymm9
	vpaddd	%ymm10, %ymm9, %ymm9
	vpaddd	%ymm9, %ymm8, %ymm8
	vpmaxsd	%ymm0, %ymm8, %ymm8
	vmovdqa	%ymm8, (%rsi,%r15)
	addq	$32, %r15
	cmpq	%r15, %r14
	jne	.LBB2_342
# %bb.343:                              # %"end for relu.s0._0._0271.loopexit.us"
                                        #   in Loop: Header=BB2_341 Depth=2
	incq	%r9
	movq	112(%rsp), %rcx                 # 8-byte Reload
	addq	%rcx, %rsi
	addq	%rcx, %rbp
	addq	%rcx, %r8
	addq	%rcx, %rdx
	addq	%rcx, %r10
	addq	%rcx, %r11
	addq	%rcx, %rdi
	addq	%rcx, %rax
	cmpq	128(%rsp), %r9                  # 8-byte Folded Reload
	jne	.LBB2_341
.LBB2_344:                              # %"end for relu.s0._1.rebased268"
                                        #   in Loop: Header=BB2_338 Depth=1
	movq	32(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	addq	%rbx, 8(%rsp)                   # 8-byte Folded Spill
	movq	%rcx, %rax
	movq	%rcx, 32(%rsp)                  # 8-byte Spill
	cmpq	$11, %rcx
	jne	.LBB2_338
# %bb.345:                              # %"end for relu.s0._2265"
	movq	56(%rsp), %rsi                  # 8-byte Reload
	testq	%rsi, %rsi
	je	.LBB2_347
# %bb.346:                              # %if.then.i568
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_free@PLT
	vmovdqa	.LCPI2_0(%rip), %ymm12          # ymm12 = [0,1,2,3,4,5,6,7]
.LBB2_347:                              # %call_destructor.exit569
	vmovd	260(%rsp), %xmm0                # 4-byte Folded Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vpbroadcastd	%xmm0, %ymm0
	movl	$12, %eax
	xorl	%r8d, %r8d
	vpcmpeqd	%ymm1, %ymm1, %ymm1
	jmp	.LBB2_349
	.p2align	4, 0x90
.LBB2_348:                              # %"end for sum$3.s1._1._1i278"
                                        #   in Loop: Header=BB2_349 Depth=1
	incq	%r8
	incq	%rax
	cmpq	$4, %r8
	je	.LBB2_363
.LBB2_349:                              # %"for sum$3.s1._2274"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_353 Depth 2
                                        #       Child Loop BB2_355 Depth 3
                                        #         Child Loop BB2_359 Depth 4
                                        #         Child Loop BB2_357 Depth 4
	cmpl	$0, 20(%rsp)                    # 4-byte Folded Reload
	jle	.LBB2_348
# %bb.350:                              # %"for sum$3.s1._1._1i277.preheader"
                                        #   in Loop: Header=BB2_349 Depth=1
	cmpl	$0, 104(%rsp)                   # 4-byte Folded Reload
	jle	.LBB2_348
# %bb.351:                              # %"for sum$3.s1._1._1i277.us.preheader"
                                        #   in Loop: Header=BB2_349 Depth=1
	movl	%r8d, %r9d
	imull	440(%rsp), %r9d                 # 4-byte Folded Reload
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	jmp	.LBB2_353
	.p2align	4, 0x90
.LBB2_352:                              # %"end for sum$3.s1._0._0281.loopexit.us"
                                        #   in Loop: Header=BB2_353 Depth=2
	incl	%r11d
	addl	24(%rsp), %r10d                 # 4-byte Folded Reload
	cmpl	76(%rsp), %r11d                 # 4-byte Folded Reload
	je	.LBB2_348
.LBB2_353:                              # %"for sum$3.s1._1._1i277.us"
                                        #   Parent Loop BB2_349 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_355 Depth 3
                                        #         Child Loop BB2_359 Depth 4
                                        #         Child Loop BB2_357 Depth 4
	movq	224(%rsp), %rcx                 # 8-byte Reload
	leal	(%r11,%rcx), %r14d
	imull	192(%rsp), %r14d                # 4-byte Folded Reload
	addl	%r9d, %r14d
	movl	%r10d, %r15d
	xorl	%edx, %edx
	jmp	.LBB2_355
	.p2align	4, 0x90
.LBB2_354:                              # %"end for sum$3.s1.r242$x284.us"
                                        #   in Loop: Header=BB2_355 Depth=3
	incq	%rdx
	addl	$8, %r15d
	cmpq	104(%rsp), %rdx                 # 8-byte Folded Reload
	je	.LBB2_352
.LBB2_355:                              # %"for sum$3.s1._0._0280.us"
                                        #   Parent Loop BB2_349 Depth=1
                                        #     Parent Loop BB2_353 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB2_359 Depth 4
                                        #         Child Loop BB2_357 Depth 4
	movslq	%r15d, %rcx
	leaq	(,%rcx,4), %rdi
	addq	%r13, %rdi
	leal	4(,%rdx,4), %ecx
	leal	(%r14,%rdx,8), %ebp
	movslq	%ebp, %rbp
	movq	336(%rsp), %rsi                 # 8-byte Reload
	leaq	(%rsi,%rbp,4), %rbp
	cmpl	%r12d, %ecx
	jle	.LBB2_358
# %bb.356:                              # %"for sum$3.s1.r242$x283.us.us.preheader"
                                        #   in Loop: Header=BB2_355 Depth=3
	movq	96(%rsp), %rcx                  # 8-byte Reload
	leal	(%rcx,%rdx,4), %ecx
	addl	%ecx, %ecx
	incl	%ecx
	vmovd	%ecx, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vpaddd	%ymm2, %ymm12, %ymm2
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_357:                              # %"for sum$3.s1.r242$x283.us.us"
                                        #   Parent Loop BB2_349 Depth=1
                                        #     Parent Loop BB2_353 Depth=2
                                        #       Parent Loop BB2_355 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	vpcmpgtd	%ymm0, %ymm2, %ymm3
	vpxor	%ymm1, %ymm3, %ymm3
	vpmaskmovd	(%rbp), %ymm3, %ymm4
	vpmaskmovd	(%rdi), %ymm3, %ymm5
	leal	(%rax,%rcx), %esi
	vmovd	%esi, %xmm6
	vpbroadcastd	%xmm6, %ymm6
	vpmulld	%ymm6, %ymm5, %ymm5
	vpaddd	%ymm4, %ymm5, %ymm4
	vpmaskmovd	%ymm4, %ymm3, (%rbp)
	addq	$11, %rcx
	addq	%rbx, %rdi
	cmpq	$121, %rcx
	jne	.LBB2_357
	jmp	.LBB2_354
	.p2align	4, 0x90
.LBB2_358:                              # %"for sum$3.s1._0._0280.split.us1120"
                                        #   in Loop: Header=BB2_355 Depth=3
	vmovdqa	(%rbp), %ymm2
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB2_359:                              # %"for sum$3.s1.r242$x283.us1116"
                                        #   Parent Loop BB2_349 Depth=1
                                        #     Parent Loop BB2_353 Depth=2
                                        #       Parent Loop BB2_355 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%rax,%rcx), %esi
	vmovd	%esi, %xmm3
	vpbroadcastd	%xmm3, %ymm3
	vpmulld	(%rdi), %ymm3, %ymm3
	vpaddd	%ymm2, %ymm3, %ymm2
	addq	$11, %rcx
	addq	%rbx, %rdi
	cmpq	$121, %rcx
	jne	.LBB2_359
# %bb.360:                              # %"end for sum$3.s1.r242$x284.split.us1119"
                                        #   in Loop: Header=BB2_355 Depth=3
	vmovdqa	%ymm2, (%rbp)
	jmp	.LBB2_354
.LBB2_361:                              # %"end for sum$3.s1._2"
	xorl	%ebp, %ebp
	movq	64(%rsp), %rsi                  # 8-byte Reload
	testq	%rsi, %rsi
	je	.LBB2_366
# %bb.362:                              # %if.then.i544
	movq	(%rsp), %rdi                    # 8-byte Reload
	jmp	.LBB2_365
.LBB2_363:                              # %"end for sum$3.s1._2275"
	xorl	%ebp, %ebp
	testq	%r13, %r13
	je	.LBB2_366
.LBB2_364:                              # %if.then.i517
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r13, %rsi
.LBB2_365:                              # %call_destructor.exit518
	vzeroupper
	callq	halide_free@PLT
.LBB2_366:                              # %call_destructor.exit518
	movl	%ebp, %eax
	addq	$488, %rsp                      # imm = 0x1E8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
.LBB2_367:                              # %"assert failed38"
	movl	136(%rsp), %ecx                 # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	movq	160(%rsp), %rcx                 # 8-byte Reload
	imulq	%rax, %rcx
	imulq	$100, %rcx, %rdx
	leaq	.Lstr.14(%rip), %rsi
	jmp	.LBB2_377
.LBB2_368:                              # %"assert failed42"
	movl	%ebx, %eax
	sarl	$31, %eax
	andnl	%ebx, %eax, %eax
	imulq	%rax, %rdi
	movq	%rdi, %rax
	shlq	$6, %rax
	leaq	(%rax,%rdi,4), %rdx
	leaq	.Lstr.15(%rip), %rsi
	jmp	.LBB2_375
.LBB2_369:                              # %"assert failed46"
	movl	%r13d, %eax
	sarl	$31, %eax
	andnl	%r13d, %eax, %eax
	imulq	%rax, %rdi
	movq	%rdi, %rax
	shlq	$6, %rax
	leaq	(%rax,%rdi,4), %rdx
	leaq	.Lstr.16(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_410
.LBB2_370:                              # %"assert failed50"
	movq	192(%rsp), %rcx                 # 8-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	imulq	%rax, %r14
	movq	%r14, %rax
	shlq	$6, %rax
	leaq	(%rax,%r14,4), %rdx
	leaq	.Lstr.17(%rip), %rsi
	jmp	.LBB2_379
.LBB2_371:                              # %"assert failed54"
	movl	56(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	imulq	%rax, %r14
	shlq	$4, %r14
	leaq	.Lstr.18(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r14, %rdx
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_414
.LBB2_372:                              # %"assert failed58"
	movl	56(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	movq	160(%rsp), %rcx                 # 8-byte Reload
	imulq	%rax, %rcx
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rax,%rax,2), %rdx
	addq	%rcx, %rdx
	jmp	.LBB2_383
.LBB2_373:                              # %"assert failed66"
	movl	56(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	movq	160(%rsp), %rcx                 # 8-byte Reload
	imulq	%rax, %rcx
	imulq	$44, %rcx, %rdx
	leaq	.Lstr.21(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_418
.LBB2_374:                              # %"assert failed93"
	movl	136(%rsp), %ecx                 # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	movq	160(%rsp), %rcx                 # 8-byte Reload
	imulq	%rax, %rcx
	imulq	$100, %rcx, %rdx
	leaq	.Lstr.14(%rip), %rsi
	jmp	.LBB2_375
.LBB2_376:                              # %"assert failed122"
	movl	%ebp, %eax
	sarl	$31, %eax
	andnl	%ebp, %eax, %eax
	imulq	%rax, %rdi
	movq	%rdi, %rax
	shlq	$6, %rax
	leaq	(%rax,%rdi,4), %rdx
	leaq	.Lstr.15(%rip), %rsi
.LBB2_377:                              # %call_destructor.exit515
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_396
.LBB2_378:                              # %"assert failed151"
	movl	%ebx, %eax
	sarl	$31, %eax
	andnl	%ebx, %eax, %eax
	imulq	%rax, %rdi
	movq	%rdi, %rax
	shlq	$6, %rax
	leaq	(%rax,%rdi,4), %rdx
	leaq	.Lstr.16(%rip), %rsi
.LBB2_379:                              # %call_destructor.exit476
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_386
.LBB2_380:                              # %"assert failed168"
	movq	192(%rsp), %rcx                 # 8-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	imulq	%rax, %r14
	movq	%r14, %rax
	shlq	$6, %rax
	leaq	(%rax,%r14,4), %rdx
	leaq	.Lstr.17(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_422
.LBB2_381:                              # %"assert failed185"
	movl	24(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	imulq	%rax, %r14
	shlq	$4, %r14
	leaq	.Lstr.18(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r14, %rdx
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_386
.LBB2_382:                              # %"assert failed213"
	movl	24(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	imulq	%rax, %rsi
	leaq	(%rsi,%rsi,8), %rax
	leaq	(%rax,%rax,2), %rdx
	addq	%rsi, %rdx
.LBB2_383:                              # %call_destructor.exit473
	leaq	.Lstr.19(%rip), %rsi
.LBB2_375:                              # %call_destructor.exit488
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_399
.LBB2_398:                              # %"assert failed60"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_399:                              # %call_destructor.exit473
	movl	%eax, %ebp
	testq	%r15, %r15
	je	.LBB2_366
# %bb.401:                              # %call_destructor.exit473
	testl	%ebp, %ebp
	je	.LBB2_366
# %bb.402:                              # %if.then.i475
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r15, %rsi
	jmp	.LBB2_365
.LBB2_384:                              # %"assert failed257"
	movl	24(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	movq	160(%rsp), %rcx                 # 8-byte Reload
	imulq	%rax, %rcx
	imulq	$44, %rcx, %rdx
	leaq	.Lstr.21(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_426
.LBB2_385:                              # %"assert failed187"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_386:                              # %call_destructor.exit476
	movl	%eax, %ebp
	cmpq	$0, 48(%rsp)                    # 8-byte Folded Reload
	je	.LBB2_366
# %bb.387:                              # %call_destructor.exit476
	testl	%ebp, %ebp
	je	.LBB2_366
# %bb.388:                              # %if.then.i478
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	48(%rsp), %rsi                  # 8-byte Reload
	jmp	.LBB2_365
.LBB2_389:                              # %"assert failed"
	movl	136(%rsp), %ecx                 # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	movq	160(%rsp), %rcx                 # 8-byte Reload
	imulq	%rax, %rcx
	shlq	$2, %rcx
	leaq	(%rcx,%rcx,2), %rdx
	jmp	.LBB2_392
.LBB2_390:                              # %"assert failed62"
	movl	56(%rsp), %ecx                  # 4-byte Reload
	jmp	.LBB2_404
.LBB2_391:                              # %"assert failed77"
	movl	136(%rsp), %ecx                 # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	imulq	%rax, %r8
	shlq	$2, %r8
	leaq	(%r8,%r8,2), %rdx
.LBB2_392:                              # %"assert failed77"
	leaq	.Lstr.13(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	addq	$488, %rsp                      # imm = 0x1E8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	halide_error_buffer_allocation_too_large@PLT # TAILCALL
.LBB2_393:                              # %"assert failed1"
	movq	(%rsp), %rdi                    # 8-byte Reload
	addq	$488, %rsp                      # imm = 0x1E8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	halide_error_out_of_memory@PLT  # TAILCALL
.LBB2_395:                              # %"assert failed40"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_396:                              # %call_destructor.exit515
	movl	%eax, %ebp
	testq	%r13, %r13
	je	.LBB2_366
# %bb.397:                              # %call_destructor.exit515
	testl	%ebp, %ebp
	jne	.LBB2_364
	jmp	.LBB2_366
.LBB2_403:                              # %"assert failed241"
	movl	24(%rsp), %ecx                  # 4-byte Reload
.LBB2_404:                              # %call_destructor.exit470
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	movq	160(%rsp), %rcx                 # 8-byte Reload
	imulq	%rax, %rcx
	leaq	(%rcx,%rcx,8), %rax
	leaq	(%rax,%rax,2), %rdx
	addq	%rcx, %rdx
	leaq	.Lstr.20(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	(%rsp), %rdi                    # 8-byte Reload
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	jmp	.LBB2_406
.LBB2_405:                              # %"assert failed243"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_406:                              # %call_destructor.exit470
	movl	%eax, %ebp
	testq	%rbx, %rbx
	je	.LBB2_366
# %bb.407:                              # %call_destructor.exit470
	testl	%ebp, %ebp
	je	.LBB2_366
# %bb.408:                              # %if.then.i472
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%rbx, %rsi
	jmp	.LBB2_365
.LBB2_409:                              # %"assert failed48"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_410:                              # %call_destructor.exit509
	movl	%eax, %ebp
	testq	%r14, %r14
	je	.LBB2_366
# %bb.411:                              # %call_destructor.exit509
	testl	%ebp, %ebp
	je	.LBB2_366
# %bb.412:                              # %if.then.i511
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	%r14, %rsi
	jmp	.LBB2_365
.LBB2_413:                              # %"assert failed56"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_414:                              # %call_destructor.exit503
	movl	%eax, %ebp
	cmpq	$0, 80(%rsp)                    # 8-byte Folded Reload
	je	.LBB2_366
# %bb.415:                              # %call_destructor.exit503
	testl	%ebp, %ebp
	je	.LBB2_366
# %bb.416:                              # %if.then.i505
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	80(%rsp), %rsi                  # 8-byte Reload
	jmp	.LBB2_365
.LBB2_417:                              # %"assert failed68"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_418:                              # %call_destructor.exit494
	movl	%eax, %ebp
	cmpq	$0, 24(%rsp)                    # 8-byte Folded Reload
	je	.LBB2_366
# %bb.419:                              # %call_destructor.exit494
	testl	%ebp, %ebp
	je	.LBB2_366
# %bb.420:                              # %if.then.i496
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	24(%rsp), %rsi                  # 8-byte Reload
	jmp	.LBB2_365
.LBB2_421:                              # %"assert failed170"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_422:                              # %call_destructor.exit479
	movl	%eax, %ebp
	cmpq	$0, 88(%rsp)                    # 8-byte Folded Reload
	je	.LBB2_366
# %bb.423:                              # %call_destructor.exit479
	testl	%ebp, %ebp
	je	.LBB2_366
# %bb.424:                              # %if.then.i481
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	88(%rsp), %rsi                  # 8-byte Reload
	jmp	.LBB2_365
.LBB2_425:                              # %"assert failed259"
	movq	(%rsp), %rdi                    # 8-byte Reload
	callq	halide_error_out_of_memory@PLT
.LBB2_426:                              # %call_destructor.exit
	movl	%eax, %ebp
	cmpq	$0, 56(%rsp)                    # 8-byte Folded Reload
	je	.LBB2_366
# %bb.427:                              # %call_destructor.exit
	testl	%ebp, %ebp
	je	.LBB2_366
# %bb.428:                              # %if.then.i469
	movq	(%rsp), %rdi                    # 8-byte Reload
	movq	56(%rsp), %rsi                  # 8-byte Reload
	jmp	.LBB2_365
.Lfunc_end2:
	.size	random_pipeline_par_for_sum__3_s1__1__1, .Lfunc_end2-random_pipeline_par_for_sum__3_s1__1__1
                                        # -- End function
	.section	.text.random_pipeline_par_for_casted_s0__1__1,"ax",@progbits
	.globl	random_pipeline_par_for_casted_s0__1__1 # -- Begin function random_pipeline_par_for_casted_s0__1__1
	.p2align	4, 0x90
	.type	random_pipeline_par_for_casted_s0__1__1,@function
random_pipeline_par_for_casted_s0__1__1: # @random_pipeline_par_for_casted_s0__1__1
# %bb.0:                                # %entry
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$184, %rsp
	movl	20(%rdx), %eax
	movslq	48(%rdx), %rbp
	shll	$3, %esi
	addl	$-8, %eax
	cmpl	%esi, %eax
	cmovgl	%esi, %eax
	movl	%eax, 68(%rsp)                  # 4-byte Spill
	cmpq	$-7, %rbp
	movl	$-8, %ecx
	movq	%rbp, %rax
	movq	%rbp, 96(%rsp)                  # 8-byte Spill
	cmovgel	%ebp, %ecx
	movl	24(%rdx), %esi
	movl	%esi, %eax
	sarl	$31, %eax
	movq	%rsi, 16(%rsp)                  # 8-byte Spill
	andnl	%esi, %eax, %esi
	addl	$8, %ecx
	movq	%rsi, %rbx
	imulq	%rcx, %rbx
	shlq	$5, %rbx
	movq	%rcx, %rax
	shlq	$5, %rax
	cmpq	$2147483647, %rbx               # imm = 0x7FFFFFFF
	ja	.LBB3_41
# %bb.1:                                # %entry
	shrq	$27, %rcx
	movl	%eax, %ebp
	imulq	%rsi, %rbp
	shrq	$32, %rbp
	imulq	%rsi, %rcx
	addq	%rbp, %rcx
	shrq	$32, %rcx
	jne	.LBB3_41
# %bb.2:                                # %"assert succeeded"
	movq	(%rdx), %rax
	movq	%rax, 80(%rsp)                  # 8-byte Spill
	movq	8(%rdx), %rax
	movq	%rax, 152(%rsp)                 # 8-byte Spill
	movslq	16(%rdx), %rax
	movq	%rax, 128(%rsp)                 # 8-byte Spill
	movl	28(%rdx), %eax
	movl	%eax, 108(%rsp)                 # 4-byte Spill
	movslq	32(%rdx), %rax
	movq	%rax, 32(%rsp)                  # 8-byte Spill
	movslq	36(%rdx), %rax
	movq	%rax, 88(%rsp)                  # 8-byte Spill
	movslq	40(%rdx), %rax
	movq	%rax, 72(%rsp)                  # 8-byte Spill
	movslq	44(%rdx), %rbp
	movl	52(%rdx), %r15d
	movl	56(%rdx), %eax
	movl	%eax, 12(%rsp)                  # 4-byte Spill
	movslq	60(%rdx), %rax
	movq	%rax, 144(%rsp)                 # 8-byte Spill
	movl	64(%rdx), %r13d
	movslq	68(%rdx), %r14
	movslq	72(%rdx), %rax
	movq	%rax, 120(%rsp)                 # 8-byte Spill
	movb	76(%rdx), %al
	movb	%al, 11(%rsp)                   # 1-byte Spill
	movq	%rdi, 112(%rsp)                 # 8-byte Spill
	movq	%rbx, %rsi
	callq	halide_malloc@PLT
	movq	%rax, %r12
	testq	%rbx, %rbx
	je	.LBB3_4
# %bb.3:                                # %"assert succeeded"
	testq	%r12, %r12
	je	.LBB3_42
.LBB3_4:                                # %"assert succeeded2"
	movq	%r14, 160(%rsp)                 # 8-byte Spill
	cmpl	$0, 16(%rsp)                    # 4-byte Folded Reload
	jle	.LBB3_38
# %bb.5:                                # %"for all_r$3.s0._2.rebased.preheader"
	addl	$64, 12(%rsp)                   # 4-byte Folded Spill
	movq	96(%rsp), %rax                  # 8-byte Reload
	addl	$8, %eax
	cltq
	movq	%rax, 24(%rsp)                  # 8-byte Spill
	testl	%r15d, %r15d
	jle	.LBB3_19
# %bb.6:                                # %"for all_r$3.s0._2.rebased.us.preheader"
	movq	%r13, 136(%rsp)                 # 8-byte Spill
	movslq	12(%rsp), %rax                  # 4-byte Folded Reload
	movq	%rax, 176(%rsp)                 # 8-byte Spill
	leaq	(,%rax,4), %rax
	movq	%rax, 168(%rsp)                 # 8-byte Spill
	movq	24(%rsp), %rax                  # 8-byte Reload
	leaq	(,%rax,4), %rax
	movq	%r15, %r13
	shlq	$5, %r13
	xorl	%ecx, %ecx
	movq	%r12, %rbx
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	.p2align	4, 0x90
.LBB3_7:                                # %"for all_r$3.s0._2.rebased.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_8 Depth 2
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	movl	$8, %r14d
	movq	%rbx, 40(%rsp)                  # 8-byte Spill
	.p2align	4, 0x90
.LBB3_8:                                # %"for all_r$3.s0._1.rebased.us.us"
                                        #   Parent Loop BB3_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%r13, %rdx
	callq	memset@PLT
	movq	56(%rsp), %rax                  # 8-byte Reload
	addq	%rax, %rbx
	decq	%r14
	jne	.LBB3_8
# %bb.9:                                # %"end for all_r$3.s0._1.rebased.split.us.us"
                                        #   in Loop: Header=BB3_7 Depth=1
	movq	48(%rsp), %rcx                  # 8-byte Reload
	incq	%rcx
	movq	40(%rsp), %rbx                  # 8-byte Reload
	addq	168(%rsp), %rbx                 # 8-byte Folded Reload
	cmpq	16(%rsp), %rcx                  # 8-byte Folded Reload
	jne	.LBB3_7
# %bb.10:                               # %"for all_r$3.s1._2.rebased.preheader"
	testl	%r15d, %r15d
	movq	136(%rsp), %r13                 # 8-byte Reload
	jle	.LBB3_19
# %bb.11:                               # %"for all_r$3.s1._2.rebased.us.preheader"
	movq	144(%rsp), %rsi                 # 8-byte Reload
	leaq	8(%rsi), %rcx
	movslq	68(%rsp), %rdx                  # 4-byte Folded Reload
	movq	32(%rsp), %rax                  # 8-byte Reload
	addl	$5, %eax
	imulq	%rcx, %rdx
	movq	152(%rsp), %rcx                 # 8-byte Reload
	leaq	(%rcx,%rdx,4), %rcx
	addq	$32, %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	leaq	32(,%rsi,4), %rcx
	movq	%rcx, 56(%rsp)                  # 8-byte Spill
	shlq	$2, %rbp
	xorl	%r11d, %r11d
	.p2align	4, 0x90
.LBB3_12:                               # %"for all_r$3.s1._2.rebased.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_13 Depth 2
                                        #       Child Loop BB3_14 Depth 3
                                        #         Child Loop BB3_15 Depth 4
	movq	%r11, 48(%rsp)                  # 8-byte Spill
	imulq	176(%rsp), %r11                 # 8-byte Folded Reload
	movq	40(%rsp), %r8                   # 8-byte Reload
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB3_13:                               # %"for all_r$3.s1._1.rebased.us.us"
                                        #   Parent Loop BB3_12 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_14 Depth 3
                                        #         Child Loop BB3_15 Depth 4
	movq	%rsi, %rbx
	imulq	24(%rsp), %rbx                  # 8-byte Folded Reload
	addq	%r11, %rbx
	movq	%r8, %r14
	xorl	%edi, %edi
	.p2align	4, 0x90
.LBB3_14:                               # %"for all_r$3.s1._0._0.us.us"
                                        #   Parent Loop BB3_12 Depth=1
                                        #     Parent Loop BB3_13 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB3_15 Depth 4
	leaq	(%rbx,%rdi,8), %rdx
	vmovdqa	(%r12,%rdx,4), %ymm0
	movq	%r14, %rcx
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB3_15:                               # %"for all_r$3.s1.r267$x.us.us"
                                        #   Parent Loop BB3_12 Depth=1
                                        #     Parent Loop BB3_13 Depth=2
                                        #       Parent Loop BB3_14 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	vmovdqa	-32(%rcx), %ymm1
	vphaddd	(%rcx), %ymm1, %ymm1
	vpermq	$216, %ymm1, %ymm1              # ymm1 = ymm1[0,2,1,3]
	leal	(%rax,%r9), %r10d
	vmovd	%r10d, %xmm2
	vpbroadcastd	%xmm2, %ymm2
	vpmulld	%ymm2, %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm0
	addq	$4, %r9
	addq	%rbp, %rcx
	cmpq	$16, %r9
	jne	.LBB3_15
# %bb.16:                               # %"end for all_r$3.s1.r267$x.us.us"
                                        #   in Loop: Header=BB3_14 Depth=3
	vmovdqa	%ymm0, (%r12,%rdx,4)
	incq	%rdi
	addq	$64, %r14
	cmpq	%r15, %rdi
	jne	.LBB3_14
# %bb.17:                               # %"end for all_r$3.s1._0._0.loopexit.us.us"
                                        #   in Loop: Header=BB3_13 Depth=2
	incq	%rsi
	addq	56(%rsp), %r8                   # 8-byte Folded Reload
	cmpq	$8, %rsi
	jne	.LBB3_13
# %bb.18:                               # %"end for all_r$3.s1._1.rebased.split.us.us"
                                        #   in Loop: Header=BB3_12 Depth=1
	movq	48(%rsp), %r11                  # 8-byte Reload
	incq	%r11
	incq	%rax
	cmpq	16(%rsp), %r11                  # 8-byte Folded Reload
	jne	.LBB3_12
.LBB3_19:                               # %"for casted.s0._2.rebased.preheader"
	movl	68(%rsp), %eax                  # 4-byte Reload
	addl	108(%rsp), %eax                 # 4-byte Folded Reload
	movslq	%eax, %r10
	testl	%r13d, %r13d
	jle	.LBB3_33
# %bb.20:                               # %"for casted.s0._2.rebased.preheader.split.us"
	testb	$1, 11(%rsp)                    # 1-byte Folded Reload
	movq	160(%rsp), %rdi                 # 8-byte Reload
	je	.LBB3_21
# %bb.27:                               # %"for casted.s0._2.rebased.us.us.preheader"
	addq	$8, 96(%rsp)                    # 8-byte Folded Spill
	movslq	12(%rsp), %rbp                  # 4-byte Folded Reload
	shlq	$5, %r13
	movq	32(%rsp), %rcx                  # 8-byte Reload
	movq	72(%rsp), %rsi                  # 8-byte Reload
	imulq	%rsi, %rcx
	movq	88(%rsp), %rax                  # 8-byte Reload
	movq	%rax, %rdx
	imulq	%r10, %rdx
	addq	%rcx, %rdx
	addq	%rdi, %rdx
	movq	80(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%rdx,4), %r11
	leaq	(,%rsi,4), %rcx
	movq	%rcx, 48(%rsp)                  # 8-byte Spill
	leaq	(,%rax,4), %rdi
	movq	%rbp, 56(%rsp)                  # 8-byte Spill
	leaq	(,%rbp,4), %rax
	movq	%rax, 40(%rsp)                  # 8-byte Spill
	shlq	$2, 24(%rsp)                    # 8-byte Folded Spill
	xorl	%r15d, %r15d
	movq	%r12, %r14
	.p2align	4, 0x90
.LBB3_28:                               # %"for casted.s0._2.rebased.us.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_29 Depth 2
                                        #       Child Loop BB3_30 Depth 3
	movq	32(%rsp), %rax                  # 8-byte Reload
	leaq	(%r15,%rax), %rsi
	imulq	72(%rsp), %rsi                  # 8-byte Folded Reload
	movq	%r15, %rbx
	imulq	56(%rsp), %rbx                  # 8-byte Folded Reload
	addq	128(%rsp), %rbx                 # 8-byte Folded Reload
	addq	120(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%r14, %rcx
	movq	%r11, %rdx
	xorl	%ebp, %ebp
	.p2align	4, 0x90
.LBB3_29:                               # %"for casted.s0._1._1i.us.us.us.us"
                                        #   Parent Loop BB3_28 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_30 Depth 3
	leaq	(%r10,%rbp), %r8
	imulq	88(%rsp), %r8                   # 8-byte Folded Reload
	xorl	%r9d, %r9d
	.p2align	4, 0x90
.LBB3_30:                               # %"for casted.s0._0._0.us.us.us.us"
                                        #   Parent Loop BB3_28 Depth=1
                                        #     Parent Loop BB3_29 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqa	(%rcx,%r9), %ymm0
	vmovdqu	%ymm0, (%rdx,%r9)
	addq	$32, %r9
	cmpq	%r9, %r13
	jne	.LBB3_30
# %bb.31:                               # %"end for casted.s0._0._0.loopexit.us.us.us.us"
                                        #   in Loop: Header=BB3_29 Depth=2
	movq	96(%rsp), %rax                  # 8-byte Reload
	imulq	%rbp, %rax
	addq	%rbx, %rax
	vmovdqu	-32(%r12,%rax,4), %ymm0
	addq	%rsi, %r8
	movq	80(%rsp), %rax                  # 8-byte Reload
	vmovdqu	%ymm0, -32(%rax,%r8,4)
	incq	%rbp
	addq	%rdi, %rdx
	addq	24(%rsp), %rcx                  # 8-byte Folded Reload
	cmpq	$8, %rbp
	jne	.LBB3_29
# %bb.32:                               # %"end for casted.s0._1._1i.split.us.us.split.us.us"
                                        #   in Loop: Header=BB3_28 Depth=1
	incq	%r15
	addq	48(%rsp), %r11                  # 8-byte Folded Reload
	addq	40(%rsp), %r14                  # 8-byte Folded Reload
	cmpq	16(%rsp), %r15                  # 8-byte Folded Reload
	jne	.LBB3_28
	jmp	.LBB3_38
.LBB3_21:                               # %"for casted.s0._2.rebased.us.preheader"
	movslq	12(%rsp), %r8                   # 4-byte Folded Reload
	shlq	$5, %r13
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	32(%rsp), %rcx                  # 8-byte Reload
	imulq	%rax, %rcx
	movq	88(%rsp), %rbp                  # 8-byte Reload
	imulq	%rbp, %r10
	addq	%rcx, %r10
	addq	%rdi, %r10
	movq	80(%rsp), %rcx                  # 8-byte Reload
	leaq	(%rcx,%r10,4), %r9
	shlq	$2, %rax
	movq	%rax, %r10
	shlq	$2, %rbp
	shlq	$2, %r8
	shlq	$2, 24(%rsp)                    # 8-byte Folded Spill
	xorl	%edx, %edx
	movq	%r12, %rsi
	.p2align	4, 0x90
.LBB3_22:                               # %"for casted.s0._2.rebased.us"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_23 Depth 2
                                        #       Child Loop BB3_24 Depth 3
	movq	%rsi, %rdi
	movq	%r9, %rax
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB3_23:                               # %"for casted.s0._1._1i.us.us"
                                        #   Parent Loop BB3_22 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB3_24 Depth 3
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB3_24:                               # %"for casted.s0._0._0.us.us"
                                        #   Parent Loop BB3_22 Depth=1
                                        #     Parent Loop BB3_23 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	vmovdqa	(%rdi,%rcx), %ymm0
	vmovdqu	%ymm0, (%rax,%rcx)
	addq	$32, %rcx
	cmpq	%rcx, %r13
	jne	.LBB3_24
# %bb.25:                               # %"end for casted.s0._0._0.loopexit.us.us"
                                        #   in Loop: Header=BB3_23 Depth=2
	incq	%rbx
	addq	%rbp, %rax
	addq	24(%rsp), %rdi                  # 8-byte Folded Reload
	cmpq	$8, %rbx
	jne	.LBB3_23
# %bb.26:                               # %"end for casted.s0._1._1i.split.us.us.split"
                                        #   in Loop: Header=BB3_22 Depth=1
	incq	%rdx
	addq	%r10, %r9
	addq	%r8, %rsi
	cmpq	16(%rsp), %rdx                  # 8-byte Folded Reload
	jne	.LBB3_22
.LBB3_38:                               # %"end for casted.s0._2.rebased"
	testq	%r12, %r12
	je	.LBB3_40
# %bb.39:                               # %if.then.i20
	movq	112(%rsp), %rdi                 # 8-byte Reload
	movq	%r12, %rsi
	vzeroupper
	callq	halide_free@PLT
.LBB3_40:                               # %call_destructor.exit
	xorl	%eax, %eax
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
.LBB3_41:                               # %"assert failed"
	imulq	%rsi, %rax
	leaq	.Lstr.22(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	movq	%rax, %rdx
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	halide_error_buffer_allocation_too_large@PLT # TAILCALL
.LBB3_33:                               # %"for casted.s0._2.rebased.preheader.split"
	testb	$1, 11(%rsp)                    # 1-byte Folded Reload
	je	.LBB3_38
# %bb.34:                               # %"for casted.s0._2.rebased.us34.preheader"
	movslq	12(%rsp), %r8                   # 4-byte Folded Reload
	movq	72(%rsp), %rax                  # 8-byte Reload
	movq	32(%rsp), %rdx                  # 8-byte Reload
	imulq	%rax, %rdx
	movq	88(%rsp), %rcx                  # 8-byte Reload
	imulq	%rcx, %r10
	addq	%rdx, %r10
	addq	120(%rsp), %r10                 # 8-byte Folded Reload
	movq	80(%rsp), %rdx                  # 8-byte Reload
	leaq	(%rdx,%r10,4), %r9
	addq	$-32, %r9
	shlq	$2, %rax
	movq	%rax, %r10
	shlq	$2, %rcx
	movq	128(%rsp), %rax                 # 8-byte Reload
	leaq	(%r12,%rax,4), %rbx
	addq	$-32, %rbx
	shlq	$2, %r8
	movq	96(%rsp), %rax                  # 8-byte Reload
	leaq	32(,%rax,4), %rsi
	xorl	%edi, %edi
.LBB3_35:                               # %"for casted.s0._2.rebased.us34"
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB3_36 Depth 2
	movl	$8, %ebp
	movq	%rbx, %rdx
	movq	%r9, %rax
.LBB3_36:                               # %"for casted.s0._1._1i.us29.us"
                                        #   Parent Loop BB3_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	vmovdqu	(%rdx), %ymm0
	vmovdqu	%ymm0, (%rax)
	addq	%rcx, %rax
	addq	%rsi, %rdx
	decq	%rbp
	jne	.LBB3_36
# %bb.37:                               # %"end for casted.s0._1._1i.split.split.us.us"
                                        #   in Loop: Header=BB3_35 Depth=1
	incq	%rdi
	addq	%r10, %r9
	addq	%r8, %rbx
	cmpq	16(%rsp), %rdi                  # 8-byte Folded Reload
	jne	.LBB3_35
	jmp	.LBB3_38
.LBB3_42:                               # %"assert failed1"
	movq	112(%rsp), %rdi                 # 8-byte Reload
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	halide_error_out_of_memory@PLT  # TAILCALL
.Lfunc_end3:
	.size	random_pipeline_par_for_casted_s0__1__1, .Lfunc_end3-random_pipeline_par_for_casted_s0__1__1
                                        # -- End function
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	4                               # -- Begin function random_pipeline
.LCPI4_0:
	.zero	4
	.long	2                               # 0x2
	.zero	4
	.zero	4
.LCPI4_2:
	.long	4                               # 0x4
	.long	3                               # 0x3
	.zero	4
	.zero	4
.LCPI4_3:
	.long	3                               # 0x3
	.long	73728                           # 0x12000
	.zero	4
	.zero	4
.LCPI4_4:
	.long	1                               # 0x1
	.long	1                               # 0x1
	.long	1                               # 0x1
	.long	4                               # 0x4
.LCPI4_15:
	.quad	-9223372036854775808            # 0x8000000000000000
	.quad	0                               # 0x0
	.section	.rodata.cst4,"aM",@progbits,4
	.p2align	2
.LCPI4_1:
	.long	1                               # 0x1
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	5
.LCPI4_5:
	.quad	-9223372036854775808            # 0x8000000000000000
	.quad	64                              # 0x40
	.quad	0                               # 0x0
	.quad	128                             # 0x80
.LCPI4_6:
	.quad	-9223372036854775806            # 0x8000000000000002
	.quad	0                               # 0x0
	.quad	8388608                         # 0x800000
	.quad	0                               # 0x0
.LCPI4_7:
	.quad	2048                            # 0x800
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	8192                            # 0x2000
.LCPI4_8:
	.quad	0                               # 0x0
	.quad	32                              # 0x20
	.quad	16                              # 0x10
	.quad	0                               # 0x0
.LCPI4_9:
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	32768                           # 0x8000
	.quad	0                               # 0x0
.LCPI4_10:
	.quad	33554432                        # 0x2000000
	.quad	131072                          # 0x20000
	.quad	0                               # 0x0
	.quad	524288                          # 0x80000
.LCPI4_11:
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	0                               # 0x0
	.quad	512                             # 0x200
.LCPI4_12:
	.quad	8                               # 0x8
	.quad	4                               # 0x4
	.quad	16777216                        # 0x1000000
	.quad	0                               # 0x0
.LCPI4_13:
	.quad	2097152                         # 0x200000
	.quad	8                               # 0x8
	.quad	128                             # 0x80
	.quad	64                              # 0x40
.LCPI4_14:
	.quad	2048                            # 0x800
	.quad	16384                           # 0x4000
	.quad	8192                            # 0x2000
	.quad	65536                           # 0x10000
.LCPI4_16:
	.quad	-9223372036853727232            # 0x8000000000100000
	.quad	4                               # 0x4
	.quad	2                               # 0x2
	.quad	16                              # 0x10
.LCPI4_17:
	.quad	512                             # 0x200
	.quad	4194304                         # 0x400000
	.quad	256                             # 0x100
	.quad	4096                            # 0x1000
	.section	.text.random_pipeline,"ax",@progbits
	.globl	random_pipeline
	.p2align	4, 0x90
	.type	random_pipeline,@function
random_pipeline:                        # @random_pipeline
# %bb.0:                                # %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$1056, %rsp                     # imm = 0x420
	movq	16(%rbp), %r8
	testq	%r8, %r8
	je	.LBB4_1
# %bb.8:                                # %"assert succeeded"
	testq	%rdi, %rdi
	je	.LBB4_7
# %bb.9:                                # %"assert succeeded2"
	movq	24(%rbp), %rax
	testq	%rax, %rax
	je	.LBB4_10
# %bb.11:                               # %"assert succeeded4"
	movq	40(%rax), %r9
	movslq	4(%r9), %r15
	cmpq	$9, %r15
	movslq	20(%r9), %rcx
	movq	%rcx, 40(%rsp)                  # 8-byte Spill
	movl	$8, %eax
	cmovgel	%r15d, %eax
	movl	%eax, 128(%rsp)                 # 4-byte Spill
	movl	$8, %eax
	cmpq	$9, %rcx
	cmovgel	%ecx, %eax
	movl	%eax, 120(%rsp)                 # 4-byte Spill
	movl	(%r9), %r10d
	movq	%r10, 280(%rsp)                 # 8-byte Spill
	cmpq	$4, %r15
	movq	40(%rdi), %rax
	movl	(%rax), %ebx
	movl	%ebx, 84(%rsp)                  # 4-byte Spill
	movl	4(%rax), %edx
	movl	$4, %ecx
	cmovll	%r15d, %ecx
	movl	20(%rax), %esi
	movq	%rsi, 48(%rsp)                  # 8-byte Spill
	vmovd	%esi, %xmm0
	movq	%rdx, 24(%rsp)                  # 8-byte Spill
	vpinsrd	$1, %edx, %xmm0, %xmm0
	movl	16(%rax), %esi
	vmovd	%esi, %xmm1
	vpinsrd	$1, %ebx, %xmm1, %xmm1
	addl	%r10d, %ecx
	vpaddd	%xmm1, %xmm0, %xmm4
	vpextrd	$1, %xmm4, %edx
	movq	%rdx, 352(%rsp)                 # 8-byte Spill
	addl	$5, %edx
	cmpl	%ecx, %edx
	cmovlel	%edx, %ecx
	movl	8(%rax), %edx
	movl	%edx, 144(%rsp)                 # 4-byte Spill
	movl	24(%rax), %edx
	movl	%edx, 116(%rsp)                 # 4-byte Spill
	movl	32(%rax), %r13d
	movl	36(%rax), %r12d
	movl	40(%rax), %eax
	movl	%eax, 112(%rsp)                 # 4-byte Spill
	movq	40(%r8), %rax
	movl	(%rax), %edx
	movl	4(%rax), %r10d
	movq	%rdi, %r8
	movl	8(%rax), %edi
	movl	%edi, 76(%rsp)                  # 4-byte Spill
	movl	16(%rax), %edi
	movl	%edi, 32(%rsp)                  # 4-byte Spill
	movl	20(%rax), %edi
	movq	%rdi, 56(%rsp)                  # 8-byte Spill
	movslq	24(%rax), %rbx
	movq	%rbx, 264(%rsp)                 # 8-byte Spill
	movl	32(%rax), %edi
	movl	36(%rax), %r11d
	movslq	40(%rax), %rbx
	movq	%rbx, 272(%rsp)                 # 8-byte Spill
	movl	48(%rax), %r14d
	movl	52(%rax), %ebx
	movq	%rbx, 288(%rsp)                 # 8-byte Spill
	movl	56(%rax), %eax
	movl	%eax, 80(%rsp)                  # 4-byte Spill
	addl	$-6, %ecx
	movl	84(%rsp), %eax                  # 4-byte Reload
	cmpl	%eax, %ecx
	cmovlel	%eax, %ecx
	movl	%ecx, 240(%rsp)                 # 4-byte Spill
	vmovd	40(%rsp), %xmm0                 # 4-byte Folded Reload
                                        # xmm0 = mem[0],zero,zero,zero
	movq	%r15, 96(%rsp)                  # 8-byte Spill
	movq	280(%rsp), %rax                 # 8-byte Reload
	leal	(%r15,%rax), %eax
	movl	%eax, 192(%rsp)                 # 4-byte Spill
	vpinsrd	$1, %eax, %xmm0, %xmm0
	vmovdqa	.LCPI4_0(%rip), %xmm2           # xmm2 = <u,2,u,u>
	movl	16(%r9), %eax
	vpinsrd	$0, %eax, %xmm2, %xmm2
	vpaddd	%xmm2, %xmm0, %xmm8
	vpminsd	%xmm8, %xmm4, %xmm0
	vpcmpeqd	%xmm7, %xmm7, %xmm7
	vpsubd	%xmm7, %xmm1, %xmm1
	vmovd	%xmm4, %ebx
	movq	%rbx, 576(%rsp)                 # 8-byte Spill
	decl	%ebx
	cmpl	%ebx, %eax
	movl	%eax, %r15d
	movl	%ebx, 336(%rsp)                 # 4-byte Spill
	cmovgl	%ebx, %r15d
	vpmaxsd	%xmm1, %xmm0, %xmm6
	cmpl	%esi, %r15d
	movl	%esi, 108(%rsp)                 # 4-byte Spill
	cmovlel	%esi, %r15d
	vpbroadcastd	.LCPI4_1(%rip), %xmm5   # xmm5 = [1,1,1,1]
	movq	%r10, 16(%rsp)                  # 8-byte Spill
	vmovd	%r10d, %xmm0
	movq	%r12, 208(%rsp)                 # 8-byte Spill
	vpinsrd	$1, %r12d, %xmm0, %xmm0
	movq	56(%rsp), %rcx                  # 8-byte Reload
	movl	%edx, 184(%rsp)                 # 4-byte Spill
	vmovd	%edx, %xmm1
	movl	%r13d, 188(%rsp)                # 4-byte Spill
	vpinsrd	$1, %r13d, %xmm1, %xmm1
	vpaddd	%xmm1, %xmm0, %xmm13
	vpminsd	.LCPI4_2(%rip), %xmm13, %xmm14
	vpminsd	%xmm5, %xmm13, %xmm0
	vpaddd	%xmm7, %xmm0, %xmm0
	vpmaxsd	%xmm1, %xmm0, %xmm12
	movq	%r11, 344(%rsp)                 # 8-byte Spill
	vmovd	%r11d, %xmm0
	vpinsrd	$1, %ecx, %xmm0, %xmm1
	movl	%edi, 180(%rsp)                 # 4-byte Spill
	vmovd	%edi, %xmm0
	vpinsrd	$1, 32(%rsp), %xmm0, %xmm0      # 4-byte Folded Reload
	vpaddd	%xmm0, %xmm1, %xmm9
	vpminsd	%xmm5, %xmm9, %xmm1
	movq	288(%rsp), %rcx                 # 8-byte Reload
	leal	(%rcx,%r14), %edx
	cmpl	$7, %edx
	movl	$7, %ecx
	cmovll	%edx, %ecx
	movl	%ecx, 12(%rsp)                  # 4-byte Spill
	testl	%edx, %edx
	movl	$1, %ecx
	movl	%edx, 36(%rsp)                  # 4-byte Spill
	cmovlel	%edx, %ecx
	decl	%ecx
	cmpl	%r14d, %ecx
	movq	%r14, 360(%rsp)                 # 8-byte Spill
	cmovlel	%r14d, %ecx
	movl	%ecx, 152(%rsp)                 # 4-byte Spill
	movq	24(%rbp), %rdx
	movq	16(%rdx), %rsi
	movq	24(%rbp), %rdx
	movq	24(%rdx), %rdx
	movq	%rdx, 560(%rsp)                 # 8-byte Spill
	movq	24(%rbp), %rdx
	movl	32(%rdx), %r10d
	movq	24(%rbp), %rdx
	movl	36(%rdx), %ebx
	movl	8(%r9), %edx
	movl	%edx, 72(%rsp)                  # 4-byte Spill
	movl	24(%r9), %edx
	movl	%edx, 204(%rsp)                 # 4-byte Spill
	movl	32(%r9), %edx
	movl	%edx, 196(%rsp)                 # 4-byte Spill
	movl	36(%r9), %ecx
	movq	%rcx, 168(%rsp)                 # 8-byte Spill
	movl	40(%r9), %edx
	movl	%edx, 200(%rsp)                 # 4-byte Spill
	movq	16(%r8), %rdx
	movq	%rdx, 368(%rsp)                 # 8-byte Spill
	movq	24(%r8), %rdx
	movq	%rdx, 544(%rsp)                 # 8-byte Spill
	movl	32(%r8), %edx
	movl	%edx, 136(%rsp)                 # 4-byte Spill
	movq	%r8, %r11
	movl	36(%r8), %edx
	movq	16(%rbp), %rcx
	movq	24(%rbp), %rdi
	movl	%edx, 256(%rsp)                 # 4-byte Spill
	movq	16(%rcx), %rdx
	movq	%rdx, 568(%rsp)                 # 8-byte Spill
	movq	24(%rcx), %rdx
	movq	%rdx, 552(%rsp)                 # 8-byte Spill
	movl	32(%rcx), %r13d
	movl	36(%rcx), %edx
	movl	%edx, 248(%rsp)                 # 4-byte Spill
	movq	%rsi, 376(%rsp)                 # 8-byte Spill
	testq	%rsi, %rsi
	jne	.LBB4_13
# %bb.12:                               # %_halide_buffer_is_bounds_query.exit
	cmpq	$0, (%rdi)
	jne	.LBB4_13
# %bb.17:                               # %then_bb
	movq	%r9, %r14
	movl	%ebx, 88(%rsp)                  # 4-byte Spill
	movq	%rax, %rbx
	movl	120(%rsp), %r9d                 # 4-byte Reload
	movl	%r9d, %eax
	movl	128(%rsp), %ecx                 # 4-byte Reload
	imull	%ecx, %eax
	movq	96(%rsp), %rsi                  # 8-byte Reload
	cmpl	$8, %esi
	movl	$8, %edi
	movl	$8, %edx
	cmovll	%esi, %edx
	movq	280(%rsp), %rsi                 # 8-byte Reload
	addl	%esi, %edx
	addl	$-8, %edx
	movq	40(%rsp), %rsi                  # 8-byte Reload
	cmpl	$8, %esi
	cmovll	%esi, %edi
	movq	%rbx, 160(%rsp)                 # 8-byte Spill
	leal	-8(%rbx,%rdi), %esi
	movl	%edx, 384(%rsp)
	movl	%ecx, 388(%rsp)
	movq	$1, 392(%rsp)
	leaq	400(%rsp), %rdx
	movl	%esi, 400(%rsp)
	movq	168(%rsp), %r8                  # 8-byte Reload
	movq	24(%rbp), %rdi
	movl	%r9d, 404(%rsp)
	movl	%ecx, 408(%rsp)
	movl	$0, 412(%rsp)
	movl	196(%rsp), %esi                 # 4-byte Reload
	movl	%esi, 416(%rsp)
	movl	%r8d, 420(%rsp)
	movl	%eax, 424(%rsp)
	movl	$0, 428(%rsp)
	movabsq	$12884975616, %rbx              # imm = 0x300012000
	movq	%rbx, 32(%rdi)
	vxorpd	%xmm3, %xmm3, %xmm3
	vmovupd	%xmm3, (%rdi)
	movq	$0, 16(%rdi)
	movl	384(%rsp), %ebx
	movl	%ebx, (%r14)
	movl	388(%rsp), %ebx
	movl	%ebx, 4(%r14)
	movq	392(%rsp), %rbx
	movq	%rbx, 8(%r14)
	xorl	%esi, %esi
	.p2align	4, 0x90
.LBB4_18:                               # %for.body.for.body_crit_edge.i
                                        # =>This Inner Loop Header: Depth=1
	movq	40(%rdi), %rbx
	vmovupd	(%rdx,%rsi), %xmm3
	vmovupd	%xmm3, 16(%rbx,%rsi)
	addq	$16, %rsi
	cmpq	$32, %rsi
	jne	.LBB4_18
# %bb.19:                               # %_halide_buffer_init.exit
	movq	$0, 24(%rdi)
	movq	160(%rsp), %rax                 # 8-byte Reload
	movl	88(%rsp), %ebx                  # 4-byte Reload
	movq	16(%rbp), %rcx
.LBB4_13:                               # %after_bb
	movl	%ebx, %r14d
	vmovd	%xmm6, 232(%rsp)                # 4-byte Folded Spill
	vpextrd	$1, %xmm6, 120(%rsp)            # 4-byte Folded Spill
	vpaddd	%xmm7, %xmm1, %xmm1
	vpsubd	%xmm12, %xmm14, %xmm11
	cmpq	$0, 16(%r11)
	movl	%r13d, 128(%rsp)                # 4-byte Spill
	movl	152(%rsp), %r9d                 # 4-byte Reload
	movl	%r10d, 68(%rsp)                 # 4-byte Spill
	jne	.LBB4_15
# %bb.14:                               # %_halide_buffer_is_bounds_query.exit180
	movq	%r11, %rbx
	cmpq	$0, (%r11)
	jne	.LBB4_15
# %bb.20:                               # %then_bb6
	movl	%r14d, 88(%rsp)                 # 4-byte Spill
	movl	120(%rsp), %edi                 # 4-byte Reload
	movl	240(%rsp), %ecx                 # 4-byte Reload
	subl	%ecx, %edi
	movl	232(%rsp), %esi                 # 4-byte Reload
	subl	%r15d, %esi
	movq	40(%rbx), %r13
	vpextrd	$1, %xmm11, %edx
	testl	%edx, %edx
	movl	$1, %r10d
	cmovgl	%edx, %r10d
	movl	%ecx, 432(%rsp)
	movl	%edi, 436(%rsp)
	movq	$1, 440(%rsp)
	leaq	448(%rsp), %rdx
	movl	%r15d, 448(%rsp)
	movl	%esi, 452(%rsp)
	imull	%edi, %esi
	movl	%edi, 456(%rsp)
	movl	$0, 460(%rsp)
	vpextrd	$1, %xmm12, 464(%rsp)
	movl	%r10d, 468(%rsp)
	movl	%esi, 472(%rsp)
	movl	$0, 476(%rsp)
	movabsq	$12884975616, %rsi              # imm = 0x300012000
	movq	%rsi, 32(%rbx)
	vxorpd	%xmm3, %xmm3, %xmm3
	vmovupd	%xmm3, (%rbx)
	movq	$0, 16(%rbx)
	movl	432(%rsp), %esi
	movl	%esi, (%r13)
	movl	436(%rsp), %esi
	movl	%esi, 4(%r13)
	movq	440(%rsp), %rsi
	movq	%rsi, 8(%r13)
	xorl	%esi, %esi
	movq	%rbx, %rdi
	.p2align	4, 0x90
.LBB4_21:                               # %for.body.for.body_crit_edge.i206
                                        # =>This Inner Loop Header: Depth=1
	movq	40(%rdi), %rbx
	vmovupd	(%rdx,%rsi), %xmm3
	vmovupd	%xmm3, 16(%rbx,%rsi)
	addq	$16, %rsi
	cmpq	$32, %rsi
	jne	.LBB4_21
# %bb.22:                               # %_halide_buffer_init.exit208
	movq	$0, 24(%rdi)
	movl	88(%rsp), %r14d                 # 4-byte Reload
	movq	24(%rbp), %rdi
	movq	16(%rbp), %rcx
.LBB4_15:                               # %after_bb5
	vpmaxsd	%xmm0, %xmm1, %xmm10
	movl	12(%rsp), %r10d                 # 4-byte Reload
	subl	%r9d, %r10d
	cmpq	$0, 16(%rcx)
	je	.LBB4_25
# %bb.16:
	xorl	%edx, %edx
	movq	48(%rsp), %r12                  # 8-byte Reload
	cmpq	$0, 16(%rdi)
	movq	24(%rsp), %r8                   # 8-byte Reload
	jne	.LBB4_28
	jmp	.LBB4_29
.LBB4_25:                               # %_halide_buffer_is_bounds_query.exit188
	cmpq	$0, (%rcx)
	movq	48(%rsp), %r12                  # 8-byte Reload
	je	.LBB4_35
.LBB4_26:                               # %land.rhs.i213
	cmpq	$0, (%rcx)
	sete	%dl
	cmpq	$0, 16(%rdi)
	movq	24(%rsp), %r8                   # 8-byte Reload
	je	.LBB4_29
.LBB4_28:
	xorl	%esi, %esi
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r11)
	movl	$0, %ebx
	jne	.LBB4_32
.LBB4_31:                               # %land.rhs.i225
	cmpq	$0, (%r11)
	sete	%bl
.LBB4_32:                               # %_halide_buffer_is_bounds_query.exit226
	orb	%bl, %sil
	orb	%sil, %dl
	jne	.LBB4_3
# %bb.33:                               # %then_bb12
	movl	%r15d, 312(%rsp)                # 4-byte Spill
	movq	%rax, 160(%rsp)                 # 8-byte Spill
	xorl	%edi, %edi
	cmpl	$73728, 68(%rsp)                # 4-byte Folded Reload
                                        # imm = 0x12000
	setne	%dil
	xorl	%eax, %eax
	movl	%r14d, 88(%rsp)                 # 4-byte Spill
	cmpl	$3, %r14d
	sete	%al
	movl	%eax, 12(%rsp)                  # 4-byte Spill
	xorl	%eax, %eax
	cmpl	$73728, 128(%rsp)               # 4-byte Folded Reload
                                        # imm = 0x12000
	sete	%al
	movl	%eax, 328(%rsp)                 # 4-byte Spill
	xorl	%eax, %eax
	cmpl	$8, 96(%rsp)                    # 4-byte Folded Reload
	setl	%al
	movl	%eax, 320(%rsp)                 # 4-byte Spill
	xorl	%r13d, %r13d
	cmpl	$8, 40(%rsp)                    # 4-byte Folded Reload
	setl	%r13b
	movq	168(%rsp), %rdx                 # 8-byte Reload
	shrq	$23, %rdx
	andl	$256, %edx                      # imm = 0x100
	movq	%r8, %rbx
	shrq	$21, %rbx
	andl	$1024, %ebx                     # imm = 0x400
	movl	%r10d, %eax
	movq	%r12, %r10
	shrq	$19, %r10
	andl	$4096, %r10d                    # imm = 0x1000
	movq	208(%rsp), %r11                 # 8-byte Reload
	shrq	$17, %r11
	andl	$16384, %r11d                   # imm = 0x4000
	movq	16(%rsp), %r14                  # 8-byte Reload
	shrq	$15, %r14
	andl	$65536, %r14d                   # imm = 0x10000
	movl	%r9d, %ecx
	movq	56(%rsp), %r9                   # 8-byte Reload
	shrq	$13, %r9
	andl	$262144, %r9d                   # imm = 0x40000
	movq	344(%rsp), %r15                 # 8-byte Reload
	movq	%r15, %r12
	shrq	$11, %r12
	andl	$1048576, %r12d                 # imm = 0x100000
	testl	%eax, %eax
	movl	$1, %r8d
	cmovgl	%eax, %r8d
	addl	%ecx, %r8d
	xorl	%esi, %esi
	cmpl	36(%rsp), %r8d                  # 4-byte Folded Reload
	setg	%sil
	shlq	$21, %rsi
	orq	%rdi, %rsi
	orq	%rdx, %rsi
	orq	%rbx, %rsi
	orq	%r10, %rsi
	orq	%r11, %rsi
	orq	%r14, %rsi
	orq	%r9, %rsi
	vmovd	12(%rsp), %xmm1                 # 4-byte Folded Reload
                                        # xmm1 = mem[0],zero,zero,zero
	vpcmpgtd	%xmm4, %xmm6, %xmm3
	vmovd	76(%rsp), %xmm4                 # 4-byte Folded Reload
                                        # xmm4 = mem[0],zero,zero,zero
	vpinsrd	$1, 144(%rsp), %xmm4, %xmm4     # 4-byte Folded Reload
	vpinsrd	$2, 72(%rsp), %xmm4, %xmm4      # 4-byte Folded Reload
	vpinsrd	$3, 248(%rsp), %xmm4, %xmm4     # 4-byte Folded Reload
	vpcmpeqd	.LCPI4_4(%rip), %xmm4, %xmm4
	vpinsrb	$4, 320(%rsp), %xmm1, %xmm1     # 4-byte Folded Reload
	vpextrb	$8, %xmm4, %edx
	vpinsrb	$8, %edx, %xmm1, %xmm1
	vpextrb	$12, %xmm4, %edx
	vpinsrb	$12, %r13d, %xmm1, %xmm6
	vpextrb	$0, %xmm3, %edi
	vmovd	%edi, %xmm1
	vpinsrb	$4, %edx, %xmm1, %xmm0
	vmovd	256(%rsp), %xmm1                # 4-byte Folded Reload
                                        # xmm1 = mem[0],zero,zero,zero
	vpinsrd	$1, 136(%rsp), %xmm1, %xmm1     # 4-byte Folded Reload
	vpcmpeqd	.LCPI4_3(%rip), %xmm1, %xmm7
	vpmaxsd	%xmm5, %xmm11, %xmm1
	vpaddd	%xmm1, %xmm12, %xmm1
	vpcmpgtd	%xmm13, %xmm1, %xmm5
	vpmovsxdq	%xmm5, %xmm2
	vpinsrb	$8, 328(%rsp), %xmm0, %xmm0     # 4-byte Folded Reload
	vpextrb	$8, %xmm2, %edx
	orq	%r12, %rsi
	vpcmpgtd	%xmm10, %xmm9, %xmm2
	vpslld	$31, %xmm6, %xmm6
	vpmovsxdq	%xmm6, %ymm6
	vmovapd	.LCPI4_6(%rip), %ymm11          # ymm11 = [9223372036854775810,0,8388608,0]
	vblendvpd	%ymm6, .LCPI4_5(%rip), %ymm11, %ymm6
	vpinsrb	$12, %edx, %xmm0, %xmm0
	movq	288(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, %rdx
	vpslld	$31, %xmm0, %xmm0
	vpmovsxdq	%xmm0, %ymm0
	vmovapd	.LCPI4_8(%rip), %ymm11          # ymm11 = [0,32,16,0]
	vblendvpd	%ymm0, .LCPI4_7(%rip), %ymm11, %ymm0
	shrq	$9, %rdx
	andl	$4194304, %edx                  # imm = 0x400000
	vpshufd	$20, %xmm2, %xmm2               # xmm2 = xmm2[0,1,1,0]
	vpblendd	$1, %xmm4, %xmm2, %xmm2         # xmm2 = xmm4[0],xmm2[1,2,3]
	vpbroadcastb	%xmm5, %xmm5
	vpblendd	$4, %xmm5, %xmm2, %xmm2         # xmm2 = xmm2[0,1],xmm5[2],xmm2[3]
	vpslld	$31, %xmm2, %xmm2
	vpmovsxdq	%xmm2, %ymm2
	vmovapd	.LCPI4_10(%rip), %ymm5          # ymm5 = [33554432,131072,0,524288]
	vblendvpd	%ymm2, .LCPI4_9(%rip), %ymm5, %ymm2
	vshufps	$212, %xmm4, %xmm7, %xmm4       # xmm4 = xmm7[0,1],xmm4[1,3]
	vinsertps	$112, %xmm3, %xmm4, %xmm3 # xmm3 = xmm4[0,1,2],xmm3[1]
	vpslld	$31, %xmm3, %xmm3
	vpmovsxdq	%xmm3, %ymm3
	vmovapd	.LCPI4_12(%rip), %ymm4          # ymm4 = [8,4,16777216,0]
	vblendvpd	%ymm3, .LCPI4_11(%rip), %ymm4, %ymm3
	orq	%rsi, %rdx
	vorpd	%ymm2, %ymm3, %ymm2
	vorpd	%ymm2, %ymm6, %ymm2
	vorpd	%ymm2, %ymm0, %ymm0
	vextractf128	$1, %ymm0, %xmm2
	vorpd	%xmm2, %xmm0, %xmm0
	vpermilps	$238, %xmm0, %xmm2      # xmm2 = xmm0[2,3,2,3]
	vorpd	%xmm2, %xmm0, %xmm0
	vmovq	%xmm0, %rsi
	orq	%rdx, %rsi
	tzcntq	%rsi, %rax
	cmpl	$25, %eax
	jbe	.LBB4_34
# %bb.39:                               # %no_errors_bb
	movslq	204(%rsp), %rdi                 # 4-byte Folded Reload
	movslq	48(%rsp), %rbx                  # 4-byte Folded Reload
	movq	%rbx, 144(%rsp)                 # 8-byte Spill
	movslq	208(%rsp), %r12                 # 4-byte Folded Reload
	movq	%r12, 152(%rsp)                 # 8-byte Spill
	movslq	56(%rsp), %r10                  # 4-byte Folded Reload
	movslq	%r15d, %r11
	movslq	%ecx, %r8
	movq	%r8, 136(%rsp)                  # 8-byte Spill
	xorl	%eax, %eax
	cmpq	$0, 376(%rsp)                   # 8-byte Folded Reload
	sete	%al
	movl	%eax, 48(%rsp)                  # 4-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	imulq	%rcx, %rdi
	movq	96(%rsp), %rsi                  # 8-byte Reload
	imulq	%rsi, %rcx
	movslq	168(%rsp), %r9                  # 4-byte Folded Reload
	movq	%rcx, %rdx
	imulq	%r9, %rdx
	movq	24(%rsp), %r15                  # 8-byte Reload
	movslq	%r15d, %rax
	movq	%rax, 344(%rsp)                 # 8-byte Spill
	imulq	%rax, %rbx
	movq	%rbx, %r14
	imulq	%r12, %r14
	movslq	16(%rsp), %r13                  # 4-byte Folded Reload
	movq	%r10, %r12
	movq	%r13, 232(%rsp)                 # 8-byte Spill
	imulq	%r13, %r12
	movq	%r12, %r13
	imulq	%r11, %r13
	movq	%r13, %rax
	imulq	%r8, %rax
	movl	%esi, %esi
	shrq	$31, %rsi
	movq	%rsi, 56(%rsp)                  # 8-byte Spill
	movq	%rdi, %rsi
	negq	%rsi
	cmovsq	%rdi, %rsi
	xorl	%edi, %edi
	movq	%rsi, 248(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %rsi               # imm = 0x7FFFFFFF
	seta	%dil
	movl	%edi, 288(%rsp)                 # 4-byte Spill
	xorl	%esi, %esi
	movq	%rcx, 256(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %rcx               # imm = 0x7FFFFFFF
	setg	%sil
	movl	%esi, 208(%rsp)                 # 4-byte Spill
	movslq	200(%rsp), %rsi                 # 4-byte Folded Reload
	imulq	%r9, %rsi
	movq	%rsi, %rcx
	negq	%rcx
	cmovsq	%rsi, %rcx
	xorl	%esi, %esi
	movq	%rcx, 328(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %rcx               # imm = 0x7FFFFFFF
	seta	%sil
	movl	%esi, 72(%rsp)                  # 4-byte Spill
	xorl	%ecx, %ecx
	movq	%rdx, 128(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %rdx               # imm = 0x7FFFFFFF
	setg	%cl
	movl	%ecx, 12(%rsp)                  # 4-byte Spill
	movslq	116(%rsp), %rsi                 # 4-byte Folded Reload
	imulq	144(%rsp), %rsi                 # 8-byte Folded Reload
	shrl	$26, %r15d
	andl	$-32, %r15d
	movq	%r15, 24(%rsp)                  # 8-byte Spill
	movq	%rsi, %rcx
	negq	%rcx
	cmovsq	%rsi, %rcx
	xorl	%edx, %edx
	movq	%rcx, 320(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %rcx               # imm = 0x7FFFFFFF
	seta	%dl
	movl	%edx, 68(%rsp)                  # 4-byte Spill
	xorl	%r8d, %r8d
	movq	%rbx, 240(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %rbx               # imm = 0x7FFFFFFF
	setg	%r8b
	movslq	112(%rsp), %rsi                 # 4-byte Folded Reload
	imulq	152(%rsp), %rsi                 # 8-byte Folded Reload
	movq	%rsi, %rcx
	negq	%rcx
	cmovsq	%rsi, %rcx
	xorl	%edx, %edx
	movq	%rcx, 312(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %rcx               # imm = 0x7FFFFFFF
	seta	%dl
	movl	%edx, 152(%rsp)                 # 4-byte Spill
	xorl	%ecx, %ecx
	movq	%r14, 120(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %r14               # imm = 0x7FFFFFFF
	setg	%cl
	movl	%ecx, 144(%rsp)                 # 4-byte Spill
	movq	16(%rsp), %rcx                  # 8-byte Reload
	shrl	$21, %ecx
	andl	$1024, %ecx                     # imm = 0x400
	movq	%rcx, 16(%rsp)                  # 8-byte Spill
	imulq	264(%rsp), %r10                 # 8-byte Folded Reload
	movq	%r10, %rsi
	negq	%rsi
	cmovsq	%r10, %rsi
	xorl	%r14d, %r14d
	cmpq	$2147483647, %rsi               # imm = 0x7FFFFFFF
	seta	%r14b
	xorl	%ecx, %ecx
	movq	%r12, 88(%rsp)                  # 8-byte Spill
	cmpq	$2147483647, %r12               # imm = 0x7FFFFFFF
	setg	%cl
	movl	%ecx, 76(%rsp)                  # 4-byte Spill
	imulq	272(%rsp), %r11                 # 8-byte Folded Reload
	movq	%r11, %rdi
	negq	%rdi
	cmovsq	%r11, %rdi
	xorl	%r11d, %r11d
	cmpq	$2147483647, %rdi               # imm = 0x7FFFFFFF
	seta	%r11b
	xorl	%r9d, %r9d
	movq	%r13, 336(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %r13               # imm = 0x7FFFFFFF
	setg	%r9b
	movslq	80(%rsp), %rbx                  # 4-byte Folded Reload
	imulq	136(%rsp), %rbx                 # 8-byte Folded Reload
	movq	%rbx, %rdx
	negq	%rdx
	cmovsq	%rbx, %rdx
	xorl	%ebx, %ebx
	cmpq	$2147483647, %rdx               # imm = 0x7FFFFFFF
	seta	%bl
	shlq	$15, %rbx
	xorl	%r15d, %r15d
	movq	%rax, 136(%rsp)                 # 8-byte Spill
	cmpq	$2147483647, %rax               # imm = 0x7FFFFFFF
	setg	%r15b
	movq	560(%rsp), %rcx                 # 8-byte Reload
	andl	$2, %ecx
	shlq	$16, %rcx
	movq	544(%rsp), %r10                 # 8-byte Reload
	andl	$2, %r10d
	shlq	$17, %r10
	movq	552(%rsp), %r12                 # 8-byte Reload
	andl	$2, %r12d
	shlq	$18, %r12
	xorl	%r13d, %r13d
	cmpq	$0, 368(%rsp)                   # 8-byte Folded Reload
	sete	%r13b
	vmovd	%r13d, %xmm0
	vpinsrb	$4, 72(%rsp), %xmm0, %xmm0      # 4-byte Folded Reload
	vpinsrb	$8, %r8d, %xmm0, %xmm0
	vpinsrb	$12, 68(%rsp), %xmm0, %xmm1     # 4-byte Folded Reload
	vmovd	%r14d, %xmm0
	vpinsrb	$4, %r9d, %xmm0, %xmm0
	vpinsrb	$8, %r11d, %xmm0, %xmm0
	vpinsrb	$12, %r15d, %xmm0, %xmm2
	vmovd	48(%rsp), %xmm0                 # 4-byte Folded Reload
                                        # xmm0 = mem[0],zero,zero,zero
	vpinsrb	$4, 208(%rsp), %xmm0, %xmm0     # 4-byte Folded Reload
	vpinsrb	$8, 288(%rsp), %xmm0, %xmm0     # 4-byte Folded Reload
	vpinsrb	$12, 12(%rsp), %xmm0, %xmm3     # 4-byte Folded Reload
	vmovd	144(%rsp), %xmm0                # 4-byte Folded Reload
                                        # xmm0 = mem[0],zero,zero,zero
	xorl	%eax, %eax
	movq	568(%rsp), %r9                  # 8-byte Reload
	testq	%r9, %r9
	sete	%al
	vpinsrb	$4, %eax, %xmm0, %xmm0
	vpinsrb	$8, 152(%rsp), %xmm0, %xmm0     # 4-byte Folded Reload
	vpinsrb	$12, 76(%rsp), %xmm0, %xmm0     # 4-byte Folded Reload
	orq	%rbx, %rcx
	orq	56(%rsp), %rcx                  # 8-byte Folded Reload
	orq	%r10, %rcx
	orq	24(%rsp), %rcx                  # 8-byte Folded Reload
	vpslld	$31, %xmm3, %xmm3
	vpmovsxdq	%xmm3, %ymm3
	vmovapd	.LCPI4_15(%rip), %xmm4          # xmm4 = [9223372036854775808,0]
	vblendvpd	%ymm3, .LCPI4_16(%rip), %ymm4, %ymm3
	orq	%r12, %rcx
	orq	16(%rsp), %rcx                  # 8-byte Folded Reload
	vpslld	$31, %xmm1, %xmm1
	vpsrad	$31, %xmm1, %xmm1
	vpmovzxdq	%xmm1, %ymm1            # ymm1 = xmm1[0],zero,xmm1[1],zero,xmm1[2],zero,xmm1[3],zero
	vpand	.LCPI4_13(%rip), %ymm1, %ymm1
	vpslld	$31, %xmm2, %xmm2
	vpsrad	$31, %xmm2, %xmm2
	vpmovzxdq	%xmm2, %ymm2            # ymm2 = xmm2[0],zero,xmm2[1],zero,xmm2[2],zero,xmm2[3],zero
	vpand	.LCPI4_14(%rip), %ymm2, %ymm2
	vpor	%ymm2, %ymm1, %ymm1
	vpslld	$31, %xmm0, %xmm0
	vpsrad	$31, %xmm0, %xmm0
	vpmovzxdq	%xmm0, %ymm0            # ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
	vpand	.LCPI4_17(%rip), %ymm0, %ymm0
	vorpd	%ymm0, %ymm3, %ymm0
	vorpd	%ymm1, %ymm0, %ymm0
	vextractf128	$1, %ymm0, %xmm1
	vorpd	%xmm1, %xmm0, %xmm0
	vpermilps	$238, %xmm0, %xmm1      # xmm1 = xmm0[2,3,2,3]
	vorpd	%xmm1, %xmm0, %xmm0
	vmovq	%xmm0, %rax
	orq	%rax, %rcx
	xorl	%eax, %eax
	tzcntq	%rcx, %rax
	cmpl	$22, %eax
	jbe	.LBB4_40
# %bb.103:                              # %"produce repeat_edge$6"
	vmovdqa	%xmm14, 208(%rsp)               # 16-byte Spill
	vmovd	%xmm14, %eax
	movl	%eax, %ecx
	sarl	$31, %ecx
	andnl	%eax, %ecx, %r8d
	movl	184(%rsp), %edi                 # 4-byte Reload
	cmpl	$4, %edi
	movl	$4, %ecx
	cmovll	%edi, %ecx
	movl	%ecx, %edx
	sarl	$31, %edx
	andnl	%ecx, %edx, %r10d
	vmovd	%xmm10, %edx
	movq	272(%rsp), %rcx                 # 8-byte Reload
	imull	%ecx, %edx
	vpextrd	$1, %xmm10, %esi
	movq	264(%rsp), %rax                 # 8-byte Reload
	imull	%eax, %esi
	addl	%edx, %esi
	movl	32(%rsp), %edx                  # 4-byte Reload
	imull	%eax, %edx
	movl	180(%rsp), %eax                 # 4-byte Reload
	imull	%ecx, %eax
	addl	%edx, %eax
	movl	80(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %edx
	movq	360(%rsp), %rbx                 # 8-byte Reload
	imull	%ebx, %edx
	addl	%eax, %edx
	addl	%edi, %edx
	subl	%edx, %esi
	movq	%r9, 824(%rsp)
	leaq	896(%rsp), %rax
	movq	%rax, 832(%rsp)
	movl	%edi, 840(%rsp)
	movl	%ebx, 844(%rsp)
	movl	%ecx, 848(%rsp)
	movl	%r10d, 852(%rsp)
	movl	%r8d, 856(%rsp)
	movl	36(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 860(%rsp)
	movl	%esi, 864(%rsp)
	vmovdqa	%xmm13, 288(%rsp)               # 16-byte Spill
	vmovd	%xmm13, 868(%rsp)
	movq	random_pipeline_par_for_repeat_edge__6_s0__0@GOTPCREL(%rip), %rsi
	leaq	824(%rsp), %r8
	xorl	%edi, %edi
	xorl	%edx, %edx
	movl	$4, %ecx
	vzeroupper
	callq	halide_do_par_for@PLT
	testl	%eax, %eax
	jne	.LBB4_104
# %bb.105:                              # %"assert succeeded64"
	movq	96(%rsp), %rax                  # 8-byte Reload
	decl	%eax
	movl	%eax, %r15d
	andl	$-4, %r15d
	movl	%eax, 80(%rsp)                  # 4-byte Spill
                                        # kill: def $eax killed $eax def $rax
	andl	$-8, %eax
	movq	%rax, 56(%rsp)                  # 8-byte Spill
	addl	$4, %eax
	cmpl	%eax, %r15d
	cmovlel	%eax, %r15d
	leal	8(%r15,%r15), %eax
	movl	%eax, 24(%rsp)                  # 4-byte Spill
	movq	40(%rsp), %rcx                  # 8-byte Reload
	leal	-1(%rcx), %eax
	sarl	$3, %eax
	leal	7(%rcx), %r14d
	movl	%r14d, %r12d
	andl	$-8, %r14d
	cmpl	$-3, %r15d
	movl	$-4, %ecx
	cmovgel	%r15d, %ecx
	testl	%eax, %eax
	movl	$-1, %edx
	cmovnsl	%eax, %edx
	leal	(%rcx,%rcx), %eax
	addl	$8, %eax
	leal	8(,%rdx,8), %edx
	movq	%rdx, %rbx
	imulq	%rax, %rbx
	shlq	$4, %rbx
	cmpq	$2147483647, %rbx               # imm = 0x7FFFFFFF
	ja	.LBB4_107
# %bb.106:                              # %"assert succeeded64"
	addl	%ecx, %ecx
	leal	32(,%rcx,4), %ecx
	imulq	%rdx, %rcx
	shrq	$32, %rcx
	shrq	$30, %rax
	imulq	%rdx, %rax
	addq	%rcx, %rax
	movq	%rax, %rcx
	shrq	$32, %rcx
	shrq	$30, %rax
	orq	%rcx, %rax
	jne	.LBB4_107
# %bb.108:                              # %"assert succeeded66"
	xorl	%edi, %edi
	movq	%rbx, %rsi
	callq	halide_malloc@PLT
	testq	%rbx, %rbx
	je	.LBB4_111
# %bb.109:                              # %"assert succeeded66"
	testq	%rax, %rax
	je	.LBB4_110
.LBB4_111:                              # %"assert succeeded68"
	addl	%r15d, %r15d
	movq	%r15, 48(%rsp)                  # 8-byte Spill
	movl	24(%rsp), %edx                  # 4-byte Reload
	imull	%r14d, %edx
	sarl	$3, %r12d
	movq	96(%rsp), %r13                  # 8-byte Reload
	leal	3(%r13), %ebx
	movl	%ebx, %esi
	sarl	$2, %esi
	movq	%rax, 872(%rsp)
	movl	%edx, 24(%rsp)                  # 4-byte Spill
	movl	%edx, 880(%rsp)
	movl	%esi, 272(%rsp)                 # 4-byte Spill
	movl	%esi, 884(%rsp)
	movl	%r15d, 888(%rsp)
	movq	random_pipeline_par_for_sum__3_s0__1__1@GOTPCREL(%rip), %rsi
	leaq	872(%rsp), %r8
	xorl	%edi, %edi
	xorl	%edx, %edx
	movl	%r12d, 32(%rsp)                 # 4-byte Spill
	movl	%r12d, %ecx
	movq	%rax, 16(%rsp)                  # 8-byte Spill
	callq	halide_do_par_for@PLT
                                        # kill: def $eax killed $eax def $rax
	testl	%eax, %eax
	jne	.LBB4_112
# %bb.113:                              # %"consume repeat_edge$6"
	movl	112(%rsp), %ecx                 # 4-byte Reload
	movl	188(%rsp), %r9d                 # 4-byte Reload
	imull	%r9d, %ecx
	movl	116(%rsp), %r8d                 # 4-byte Reload
	imull	108(%rsp), %r8d                 # 4-byte Folded Reload
	movl	84(%rsp), %eax                  # 4-byte Reload
	addl	%eax, %r8d
	addl	%ecx, %r8d
	vmovaps	208(%rsp), %xmm0                # 16-byte Reload
	vextractps	$1, %xmm0, %ecx
	movl	%ecx, %edx
	sarl	$31, %edx
	andnl	%ecx, %edx, %ecx
	movl	%ecx, 208(%rsp)                 # 4-byte Spill
	movl	80(%rsp), %r12d                 # 4-byte Reload
	movl	%r12d, %r10d
	sarl	$2, %r10d
	cmpl	$3, %r9d
	movl	$3, %ecx
	cmovll	%r9d, %ecx
	movl	%ecx, %esi
	sarl	$31, %esi
	andnl	%ecx, %esi, %ecx
	movl	%ecx, 264(%rsp)                 # 4-byte Spill
	movl	%eax, %ecx
	movq	280(%rsp), %rax                 # 8-byte Reload
	subl	%eax, %ecx
	addl	$9, %ecx
	movl	%ecx, %esi
	sarl	$3, %esi
	sarl	$31, %ecx
	andnl	%esi, %ecx, %edi
	movl	%r13d, %ecx
	sarl	$2, %ecx
	movl	%ecx, 36(%rsp)                  # 4-byte Spill
	andl	$-8, %ebx
	leal	11(%r13), %r11d
	sarl	$3, %r11d
	cmpl	%edi, %r11d
	cmovlel	%r11d, %edi
	leal	1(%r13), %esi
	andl	$-32, %esi
	movq	352(%rsp), %rcx                 # 8-byte Reload
                                        # kill: def $ecx killed $ecx killed $rcx def $rcx
	subl	%eax, %ecx
	movl	%ebx, %edx
	leal	5(%rcx), %ebx
	cmpl	%ebx, %r13d
	cmovlel	%r13d, %ebx
	addl	$2, %ebx
	cmpl	%ebx, %ecx
	cmovlel	%ecx, %ebx
	leal	9(%r13), %ecx
	cmpl	%ebx, %ecx
	cmovlel	%ecx, %ebx
	movq	368(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, 584(%rsp)
	leaq	896(%rsp), %rcx
	movq	%rcx, 592(%rsp)
	addl	$2, %ebx
	sarl	$3, %ebx
	cmpl	%edi, %ebx
	cmovlel	%edi, %ebx
	leal	26(%rsi), %ecx
	movl	%edx, 12(%rsp)                  # 4-byte Spill
	cmpl	%edx, %ecx
	cmovlel	%edx, %ecx
	orl	$22, %esi
	movq	56(%rsp), %rdx                  # 8-byte Reload
	cmpl	%esi, %edx
	cmovgl	%edx, %esi
	movl	%r13d, %edx
	andl	$2147483644, %edx               # imm = 0x7FFFFFFC
	addl	%eax, %edx
	movq	16(%rsp), %r15                  # 8-byte Reload
	movq	%r15, 600(%rsp)
	movl	%r13d, 608(%rsp)
	movq	40(%rsp), %r14                  # 8-byte Reload
	movl	%r14d, 612(%rsp)
	movl	%eax, 616(%rsp)
	movq	160(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 620(%rsp)
	movl	84(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 624(%rsp)
	movl	108(%rsp), %eax                 # 4-byte Reload
	movl	%eax, 628(%rsp)
	movl	%r9d, 632(%rsp)
	movl	116(%rsp), %eax                 # 4-byte Reload
	movl	%eax, 636(%rsp)
	movl	112(%rsp), %eax                 # 4-byte Reload
	movl	%eax, 640(%rsp)
	movl	%r14d, %r15d
	sarl	$3, %r15d
	movl	24(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 644(%rsp)
	movl	%r15d, 648(%rsp)
	movq	576(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 652(%rsp)
	movl	$3, %r15d
	movl	208(%rsp), %eax                 # 4-byte Reload
	subl	%eax, %r15d
	movl	264(%rsp), %r9d                 # 4-byte Reload
	subl	%r9d, %eax
	movl	%eax, 656(%rsp)
	movl	%ebx, 660(%rsp)
	movl	%r15d, 664(%rsp)
	movl	%ecx, 668(%rsp)
	leal	33(%r13), %ecx
	sarl	$5, %ecx
	movl	%esi, 672(%rsp)
	leal	7(%r13), %r15d
	sarl	$3, %r15d
	movl	%ecx, 676(%rsp)
	imull	$56, %r10d, %ecx
	shll	$3, %r10d
	movq	48(%rsp), %rax                  # 8-byte Reload
	movl	%eax, 680(%rsp)
	movl	%r15d, 684(%rsp)
	movl	%r10d, 688(%rsp)
	movl	272(%rsp), %eax                 # 4-byte Reload
	movl	%eax, 692(%rsp)
	movl	%ecx, 696(%rsp)
	addl	%edx, %edx
	movl	%edx, 700(%rsp)
	movl	192(%rsp), %ecx                 # 4-byte Reload
	addl	%ecx, %ecx
	movl	%ecx, 704(%rsp)
	movq	352(%rsp), %rax                 # 8-byte Reload
	movl	%eax, 708(%rsp)
	vmovapd	288(%rsp), %xmm0                # 16-byte Reload
	vextractps	$1, %xmm0, 712(%rsp)
	movl	%r8d, 716(%rsp)
	movl	%r9d, 720(%rsp)
	movl	36(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 724(%rsp)
	movl	12(%rsp), %eax                  # 4-byte Reload
	movl	%eax, 728(%rsp)
	movl	%r11d, 732(%rsp)
	movl	%edi, 736(%rsp)
	testb	$3, %r13b
	setne	740(%rsp)
	movq	random_pipeline_par_for_sum__3_s1__1__1@GOTPCREL(%rip), %rsi
	leaq	584(%rsp), %r8
	xorl	%edi, %edi
	xorl	%edx, %edx
	movl	32(%rsp), %ecx                  # 4-byte Reload
	callq	halide_do_par_for@PLT
                                        # kill: def $eax killed $eax def $rax
	testl	%eax, %eax
	jne	.LBB4_112
# %bb.114:                              # %"consume sum$3"
	movl	200(%rsp), %r8d                 # 4-byte Reload
	movl	%r8d, %ecx
	movl	196(%rsp), %r9d                 # 4-byte Reload
	imull	%r9d, %ecx
	movl	204(%rsp), %edi                 # 4-byte Reload
	movl	%edi, %eax
	movq	160(%rsp), %rbx                 # 8-byte Reload
	imull	%ebx, %eax
	addl	%ecx, %eax
	movq	376(%rsp), %rcx                 # 8-byte Reload
	movq	%rcx, 744(%rsp)
	movl	%r13d, %ecx
	sarl	$3, %ecx
	shll	$3, %r12d
	andl	$-64, %r12d
	movl	%r13d, %edx
	subl	%eax, %edx
	negl	%eax
	testb	$7, %r13b
	movq	16(%rsp), %rsi                  # 8-byte Reload
	movq	%rsi, 752(%rsp)
	movl	%r13d, 760(%rsp)
	movq	40(%rsp), %rsi                  # 8-byte Reload
	movl	%esi, 764(%rsp)
	movq	168(%rsp), %rsi                 # 8-byte Reload
	movl	%esi, 768(%rsp)
	movl	%ebx, 772(%rsp)
	movl	%r9d, 776(%rsp)
	movl	%edi, 780(%rsp)
	movl	%r8d, 784(%rsp)
	movl	24(%rsp), %esi                  # 4-byte Reload
	movl	%esi, 788(%rsp)
	movq	56(%rsp), %rsi                  # 8-byte Reload
	movl	%esi, 792(%rsp)
	movl	%r15d, 796(%rsp)
	movl	%r12d, 800(%rsp)
	movq	48(%rsp), %rsi                  # 8-byte Reload
	movl	%esi, 804(%rsp)
	movl	%ecx, 808(%rsp)
	movl	%eax, 812(%rsp)
	movl	%edx, 816(%rsp)
	setne	820(%rsp)
	movq	random_pipeline_par_for_casted_s0__1__1@GOTPCREL(%rip), %rsi
	xorl	%r13d, %r13d
	leaq	744(%rsp), %r8
	xorl	%edi, %edi
	xorl	%edx, %edx
	movl	32(%rsp), %ecx                  # 4-byte Reload
	callq	halide_do_par_for@PLT
	testl	%eax, %eax
	jne	.LBB4_115
# %bb.116:                              # %"assert succeeded74"
	movq	16(%rsp), %rsi                  # 8-byte Reload
	testq	%rsi, %rsi
	je	.LBB4_3
# %bb.117:                              # %if.then.i248
	xorl	%r13d, %r13d
.LBB4_6:                                # %if.then.i
	xorl	%edi, %edi
	callq	halide_free@PLT
.LBB4_3:                                # %common.ret
	movl	%r13d, %eax
.LBB4_4:                                # %common.ret
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB4_35:                               # %then_bb9
	vmovd	%xmm11, %esi
	testl	%esi, %esi
	movl	$1, %ebx
	cmovlel	%ebx, %esi
	testl	%r10d, %r10d
	cmovgl	%r10d, %ebx
	vmovd	%xmm12, 480(%rsp)
	movl	%esi, 484(%rsp)
	movq	$1, 488(%rsp)
	vpextrd	$1, %xmm10, 496(%rsp)
	movl	$1, 500(%rsp)
	movl	%esi, 504(%rsp)
	movl	$0, 508(%rsp)
	vmovd	%xmm10, 512(%rsp)
	movq	40(%rcx), %rdx
	movl	$1, 516(%rsp)
	movl	%esi, 520(%rsp)
	movl	$0, 524(%rsp)
	movl	%r9d, 528(%rsp)
	movl	%ebx, 532(%rsp)
	movl	%esi, 536(%rsp)
	movabsq	$17179942912, %rsi              # imm = 0x400012000
	movq	%rsi, 32(%rcx)
	vpxor	%xmm1, %xmm1, %xmm1
	vmovdqu	%xmm1, (%rcx)
	movl	$0, 540(%rsp)
	movq	$0, 16(%rcx)
	leaq	480(%rsp), %rsi
	cmpq	%rsi, %rdx
	je	.LBB4_36
# %bb.37:                               # %for.body.preheader.i237
	vmovdqu	480(%rsp), %xmm1
	vmovdqu	%xmm1, (%rdx)
	movl	$16, %edx
	.p2align	4, 0x90
.LBB4_38:                               # %for.body.for.body_crit_edge.i244
                                        # =>This Inner Loop Header: Depth=1
	movq	40(%rcx), %rsi
	vmovdqu	480(%rsp,%rdx), %xmm1
	vmovdqu	%xmm1, (%rsi,%rdx)
	addq	$16, %rdx
	cmpq	$64, %rdx
	jne	.LBB4_38
# %bb.23:                               # %after_bb8
	movq	$0, 24(%rcx)
	cmpq	$0, 16(%rcx)
	je	.LBB4_26
# %bb.24:
	xorl	%edx, %edx
	cmpq	$0, 16(%rdi)
	movq	24(%rsp), %r8                   # 8-byte Reload
	jne	.LBB4_28
.LBB4_29:                               # %land.rhs.i219
	cmpq	$0, (%rdi)
	sete	%sil
	xorl	%r13d, %r13d
	cmpq	$0, 16(%r11)
	movl	$0, %ebx
	jne	.LBB4_32
	jmp	.LBB4_31
.LBB4_36:                               # %after_bb8.thread267
	movq	$0, 24(%rcx)
	jmp	.LBB4_26
.LBB4_1:                                # %"assert failed"
	leaq	.Lstr.9(%rip), %rsi
	jmp	.LBB4_2
.LBB4_7:                                # %"assert failed1"
	leaq	.Lstr(%rip), %rsi
	jmp	.LBB4_2
.LBB4_10:                               # %"assert failed3"
	leaq	.Lstr.23(%rip), %rsi
.LBB4_2:                                # %"assert failed"
	xorl	%edi, %edi
	callq	halide_error_buffer_argument_is_null@PLT
	jmp	.LBB4_4
.LBB4_107:                              # %"assert failed65"
	movl	24(%rsp), %ecx                  # 4-byte Reload
	movl	%ecx, %eax
	sarl	$31, %eax
	andnl	%ecx, %eax, %eax
	movl	%r14d, %ecx
	sarl	$31, %ecx
	andnl	%r14d, %ecx, %edx
	imulq	%rax, %rdx
	shlq	$4, %rdx
	leaq	.Lstr.31(%rip), %rsi
.LBB4_92:                               # %common.ret
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
.LBB4_93:                               # %common.ret
	vzeroupper
	callq	halide_error_buffer_allocation_too_large@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_112:
	movq	%rax, %r13
	movq	16(%rsp), %rsi                  # 8-byte Reload
	jmp	.LBB4_5
.LBB4_34:                               # %then_bb12
	movl	88(%rsp), %edx                  # 4-byte Reload
	movq	16(%rsp), %r9                   # 8-byte Reload
	movq	168(%rsp), %r10                 # 8-byte Reload
	movq	40(%rsp), %rbx                  # 8-byte Reload
	movq	96(%rsp), %rdi                  # 8-byte Reload
	leaq	.LJTI4_0(%rip), %rsi
	movslq	(%rsi,%rax,4), %rax
	addq	%rsi, %rax
	jmpq	*%rax
.LBB4_41:                               # %assert_failed
	leaq	.Lstr.24(%rip), %rsi
	xorl	%edi, %edi
	movl	68(%rsp), %edx                  # 4-byte Reload
	jmp	.LBB4_42
.LBB4_40:                               # %no_errors_bb
	movq	%rdi, 24(%rsp)                  # 8-byte Spill
	movq	%rsi, 40(%rsp)                  # 8-byte Spill
	movq	136(%rsp), %r13                 # 8-byte Reload
	movq	336(%rsp), %r12                 # 8-byte Reload
	movq	88(%rsp), %r15                  # 8-byte Reload
	movq	232(%rsp), %r14                 # 8-byte Reload
	movq	120(%rsp), %r11                 # 8-byte Reload
	movq	240(%rsp), %r10                 # 8-byte Reload
	movq	344(%rsp), %r9                  # 8-byte Reload
	movq	128(%rsp), %r8                  # 8-byte Reload
	movq	256(%rsp), %rbx                 # 8-byte Reload
	leaq	.LJTI4_1(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
.LBB4_75:                               # %assert_failed40
	leaq	.Lstr.23(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	96(%rsp), %rdx                  # 8-byte Reload
	jmp	.LBB4_93
.LBB4_104:
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_115:
	movq	16(%rsp), %rsi                  # 8-byte Reload
	movl	%eax, %r13d
.LBB4_5:                                # %destructor_block
	testq	%rsi, %rsi
	jne	.LBB4_6
	jmp	.LBB4_3
.LBB4_110:                              # %"assert failed67"
	xorl	%edi, %edi
	callq	halide_error_out_of_memory@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_76:                               # %assert_failed41
	leaq	.Lstr.23(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	248(%rsp), %rdx                 # 8-byte Reload
	jmp	.LBB4_93
.LBB4_77:                               # %assert_failed42
	leaq	.Lstr.23(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%rbx, %rdx
	jmp	.LBB4_78
.LBB4_79:                               # %assert_failed43
	leaq	.Lstr.23(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	328(%rsp), %rdx                 # 8-byte Reload
	jmp	.LBB4_93
.LBB4_80:                               # %assert_failed44
	leaq	.Lstr.23(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%r8, %rdx
	jmp	.LBB4_78
.LBB4_81:                               # %assert_failed45
	leaq	.Lstr(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%r9, %rdx
	jmp	.LBB4_93
.LBB4_82:                               # %assert_failed46
	leaq	.Lstr(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	320(%rsp), %rdx                 # 8-byte Reload
	jmp	.LBB4_93
.LBB4_83:                               # %assert_failed47
	leaq	.Lstr(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%r10, %rdx
	jmp	.LBB4_78
.LBB4_84:                               # %assert_failed48
	leaq	.Lstr(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	312(%rsp), %rdx                 # 8-byte Reload
	jmp	.LBB4_93
.LBB4_85:                               # %assert_failed49
	leaq	.Lstr(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%r11, %rdx
	jmp	.LBB4_78
.LBB4_86:                               # %assert_failed50
	leaq	.Lstr.9(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%r14, %rdx
	jmp	.LBB4_93
.LBB4_87:                               # %assert_failed51
	leaq	.Lstr.9(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	40(%rsp), %rdx                  # 8-byte Reload
	jmp	.LBB4_93
.LBB4_88:                               # %assert_failed52
	leaq	.Lstr.9(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%r15, %rdx
	jmp	.LBB4_78
.LBB4_89:                               # %assert_failed53
	leaq	.Lstr.9(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	24(%rsp), %rdx                  # 8-byte Reload
	jmp	.LBB4_93
.LBB4_90:                               # %assert_failed54
	leaq	.Lstr.9(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%r12, %rdx
	jmp	.LBB4_78
.LBB4_91:                               # %assert_failed55
	leaq	.Lstr.9(%rip), %rsi
	jmp	.LBB4_92
.LBB4_94:                               # %assert_failed56
	leaq	.Lstr.9(%rip), %rsi
	movl	$2147483647, %ecx               # imm = 0x7FFFFFFF
	xorl	%edi, %edi
	movq	%r13, %rdx
.LBB4_78:                               # %common.ret
	vzeroupper
	callq	halide_error_buffer_extents_too_large@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_95:                               # %assert_failed57
	leaq	.Lstr.24(%rip), %rsi
	jmp	.LBB4_96
.LBB4_97:                               # %assert_failed58
	leaq	.Lstr.25(%rip), %rsi
	jmp	.LBB4_96
.LBB4_98:                               # %assert_failed59
	leaq	.Lstr.26(%rip), %rsi
.LBB4_96:                               # %common.ret
	xorl	%edi, %edi
	vzeroupper
	callq	halide_error_device_dirty_with_no_device_support@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_99:                               # %assert_failed60
	leaq	.Lstr.24(%rip), %rsi
	jmp	.LBB4_100
.LBB4_101:                              # %assert_failed61
	leaq	.Lstr.25(%rip), %rsi
	jmp	.LBB4_100
.LBB4_102:                              # %assert_failed62
	leaq	.Lstr.26(%rip), %rsi
.LBB4_100:                              # %common.ret
	xorl	%edi, %edi
	vzeroupper
	callq	halide_error_host_is_null@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_43:                               # %assert_failed14
	leaq	.Lstr.24(%rip), %rsi
	xorl	%edi, %edi
	jmp	.LBB4_44
.LBB4_46:                               # %assert_failed15
	leaq	.Lstr.25(%rip), %rsi
	xorl	%edi, %edi
	movl	136(%rsp), %edx                 # 4-byte Reload
	jmp	.LBB4_42
.LBB4_47:                               # %assert_failed16
	leaq	.Lstr.25(%rip), %rsi
	xorl	%edi, %edi
	movl	256(%rsp), %edx                 # 4-byte Reload
.LBB4_44:                               # %common.ret
	movl	$3, %ecx
	jmp	.LBB4_45
.LBB4_48:                               # %assert_failed17
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	movl	128(%rsp), %edx                 # 4-byte Reload
.LBB4_42:                               # %common.ret
	movl	$73728, %ecx                    # imm = 0x12000
	vzeroupper
	callq	halide_error_bad_type@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_49:                               # %assert_failed18
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	movl	248(%rsp), %edx                 # 4-byte Reload
	movl	$4, %ecx
.LBB4_45:                               # %common.ret
	vzeroupper
	callq	halide_error_bad_dimensions@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_50:                               # %assert_failed19
	cmpl	$8, %edi
	movl	$8, %eax
	cmovll	%edi, %eax
	movq	280(%rsp), %r9                  # 8-byte Reload
	leal	(%r9,%rax), %ecx
	addl	$-8, %ecx
	movl	192(%rsp), %r8d                 # 4-byte Reload
	decl	%r8d
	movl	%r8d, (%rsp)
	leaq	.Lstr.24(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	jmp	.LBB4_52
.LBB4_51:                               # %assert_failed20
	cmpl	$8, %ebx
	movl	$8, %eax
	cmovll	%ebx, %eax
	movq	160(%rsp), %r9                  # 8-byte Reload
	leal	(%r9,%rax), %ecx
	addl	$-8, %ecx
	vmovd	%xmm8, %r8d
	decl	%r8d
	movl	%r8d, (%rsp)
	leaq	.Lstr.24(%rip), %rsi
	xorl	%edi, %edi
	movl	$1, %edx
	jmp	.LBB4_52
.LBB4_54:                               # %assert_failed21
	leaq	.Lstr.24(%rip), %rsi
	xorl	%edi, %edi
	movl	$2, %edx
	movl	%r10d, %ecx
	jmp	.LBB4_58
.LBB4_55:                               # %assert_failed22
	movl	120(%rsp), %r8d                 # 4-byte Reload
	decl	%r8d
	movq	352(%rsp), %rax                 # 8-byte Reload
	decl	%eax
	movl	%eax, (%rsp)
	leaq	.Lstr.25(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	movl	240(%rsp), %ecx                 # 4-byte Reload
	movl	84(%rsp), %r9d                  # 4-byte Reload
	jmp	.LBB4_53
.LBB4_56:                               # %assert_failed23
	leaq	.Lstr.25(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	movq	24(%rsp), %rcx                  # 8-byte Reload
	jmp	.LBB4_57
.LBB4_59:                               # %assert_failed24
	movl	232(%rsp), %r8d                 # 4-byte Reload
	decl	%r8d
	movl	336(%rsp), %eax                 # 4-byte Reload
	movl	%eax, (%rsp)
	leaq	.Lstr.25(%rip), %rsi
	xorl	%edi, %edi
	movl	$1, %edx
	movl	312(%rsp), %ecx                 # 4-byte Reload
	movl	108(%rsp), %r9d                 # 4-byte Reload
	jmp	.LBB4_53
.LBB4_60:                               # %assert_failed25
	leaq	.Lstr.25(%rip), %rsi
	xorl	%edi, %edi
	movl	$1, %edx
	movq	48(%rsp), %rcx                  # 8-byte Reload
	jmp	.LBB4_57
.LBB4_61:                               # %assert_failed26
	vpextrd	$1, %xmm1, %r8d
	vpextrd	$1, %xmm13, %eax
	decl	%r8d
	decl	%eax
	vpextrd	$1, %xmm12, %ecx
	movl	%eax, (%rsp)
	leaq	.Lstr.25(%rip), %rsi
	xorl	%edi, %edi
	movl	$2, %edx
	movl	188(%rsp), %r9d                 # 4-byte Reload
	jmp	.LBB4_53
.LBB4_62:                               # %assert_failed27
	leaq	.Lstr.25(%rip), %rsi
	xorl	%edi, %edi
	movl	$2, %edx
	movq	208(%rsp), %rcx                 # 8-byte Reload
	jmp	.LBB4_57
.LBB4_63:                               # %assert_failed28
	vmovd	%xmm1, %r8d
	decl	%r8d
	vmovd	%xmm13, %eax
	decl	%eax
	vmovd	%xmm12, %ecx
	movl	%eax, (%rsp)
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	movl	184(%rsp), %r9d                 # 4-byte Reload
	jmp	.LBB4_53
.LBB4_64:                               # %assert_failed29
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	movl	%r9d, %ecx
	jmp	.LBB4_58
.LBB4_65:                               # %assert_failed30
	vpextrd	$1, %xmm9, %eax
	decl	%eax
	vpextrd	$1, %xmm10, %ecx
	movl	%eax, (%rsp)
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	movl	$1, %edx
	movl	%ecx, %r8d
	movl	32(%rsp), %r9d                  # 4-byte Reload
	jmp	.LBB4_53
.LBB4_66:                               # %assert_failed31
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	movl	$1, %edx
	movq	56(%rsp), %rcx                  # 8-byte Reload
	jmp	.LBB4_57
.LBB4_67:                               # %assert_failed32
	vmovd	%xmm9, %eax
	decl	%eax
	vmovd	%xmm10, %ecx
	movl	%eax, (%rsp)
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	movl	$2, %edx
	movl	%ecx, %r8d
	movl	180(%rsp), %r9d                 # 4-byte Reload
	jmp	.LBB4_53
.LBB4_68:                               # %assert_failed33
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	movl	$2, %edx
	movl	%r15d, %ecx
	jmp	.LBB4_58
.LBB4_69:                               # %assert_failed34
	decl	%r8d
	movl	36(%rsp), %eax                  # 4-byte Reload
	decl	%eax
	movl	%eax, (%rsp)
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	movl	$3, %edx
	movl	152(%rsp), %ecx                 # 4-byte Reload
	movq	360(%rsp), %r9                  # 8-byte Reload
.LBB4_52:                               # %common.ret
                                        # kill: def $r9d killed $r9d killed $r9
.LBB4_53:                               # %common.ret
	vzeroupper
	callq	halide_error_access_out_of_bounds@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_70:                               # %assert_failed35
	leaq	.Lstr.26(%rip), %rsi
	xorl	%edi, %edi
	movl	$3, %edx
	movq	288(%rsp), %rcx                 # 8-byte Reload
.LBB4_57:                               # %common.ret
                                        # kill: def $ecx killed $ecx killed $rcx
.LBB4_58:                               # %common.ret
	vzeroupper
	callq	halide_error_buffer_extents_negative@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.LBB4_71:                               # %assert_failed36
	leaq	.Lstr.27(%rip), %rsi
	leaq	.Lstr.28(%rip), %rcx
	xorl	%edi, %edi
	movl	72(%rsp), %edx                  # 4-byte Reload
	jmp	.LBB4_72
.LBB4_73:                               # %assert_failed37
	leaq	.Lstr.29(%rip), %rsi
	leaq	.Lstr.28(%rip), %rcx
	xorl	%edi, %edi
	movl	144(%rsp), %edx                 # 4-byte Reload
	jmp	.LBB4_72
.LBB4_74:                               # %assert_failed38
	leaq	.Lstr.30(%rip), %rsi
	leaq	.Lstr.28(%rip), %rcx
	xorl	%edi, %edi
	movl	76(%rsp), %edx                  # 4-byte Reload
.LBB4_72:                               # %common.ret
	movl	$1, %r8d
	vzeroupper
	callq	halide_error_constraint_violated@PLT
	movl	%eax, %r13d
	jmp	.LBB4_3
.Lfunc_end4:
	.size	random_pipeline, .Lfunc_end4-random_pipeline
	.section	.rodata.random_pipeline,"a",@progbits
	.p2align	2
.LJTI4_0:
	.long	.LBB4_41-.LJTI4_0
	.long	.LBB4_43-.LJTI4_0
	.long	.LBB4_46-.LJTI4_0
	.long	.LBB4_47-.LJTI4_0
	.long	.LBB4_48-.LJTI4_0
	.long	.LBB4_49-.LJTI4_0
	.long	.LBB4_50-.LJTI4_0
	.long	.LBB4_51-.LJTI4_0
	.long	.LBB4_54-.LJTI4_0
	.long	.LBB4_55-.LJTI4_0
	.long	.LBB4_56-.LJTI4_0
	.long	.LBB4_59-.LJTI4_0
	.long	.LBB4_60-.LJTI4_0
	.long	.LBB4_61-.LJTI4_0
	.long	.LBB4_62-.LJTI4_0
	.long	.LBB4_63-.LJTI4_0
	.long	.LBB4_64-.LJTI4_0
	.long	.LBB4_65-.LJTI4_0
	.long	.LBB4_66-.LJTI4_0
	.long	.LBB4_67-.LJTI4_0
	.long	.LBB4_68-.LJTI4_0
	.long	.LBB4_69-.LJTI4_0
	.long	.LBB4_70-.LJTI4_0
	.long	.LBB4_71-.LJTI4_0
	.long	.LBB4_73-.LJTI4_0
	.long	.LBB4_74-.LJTI4_0
.LJTI4_1:
	.long	.LBB4_75-.LJTI4_1
	.long	.LBB4_76-.LJTI4_1
	.long	.LBB4_77-.LJTI4_1
	.long	.LBB4_79-.LJTI4_1
	.long	.LBB4_80-.LJTI4_1
	.long	.LBB4_81-.LJTI4_1
	.long	.LBB4_82-.LJTI4_1
	.long	.LBB4_83-.LJTI4_1
	.long	.LBB4_84-.LJTI4_1
	.long	.LBB4_85-.LJTI4_1
	.long	.LBB4_86-.LJTI4_1
	.long	.LBB4_87-.LJTI4_1
	.long	.LBB4_88-.LJTI4_1
	.long	.LBB4_89-.LJTI4_1
	.long	.LBB4_90-.LJTI4_1
	.long	.LBB4_91-.LJTI4_1
	.long	.LBB4_94-.LJTI4_1
	.long	.LBB4_95-.LJTI4_1
	.long	.LBB4_97-.LJTI4_1
	.long	.LBB4_98-.LJTI4_1
	.long	.LBB4_99-.LJTI4_1
	.long	.LBB4_101-.LJTI4_1
	.long	.LBB4_102-.LJTI4_1
                                        # -- End function
	.section	.text.random_pipeline_argv,"ax",@progbits
	.globl	random_pipeline_argv            # -- Begin function random_pipeline_argv
	.p2align	4, 0x90
	.type	random_pipeline_argv,@function
random_pipeline_argv:                   # @random_pipeline_argv
# %bb.0:                                # %entry
	subq	$24, %rsp
	movq	(%rdi), %rax
	vmovups	48(%rdi), %xmm0
	vmovups	%xmm0, (%rsp)
	movq	%rax, %rdi
	callq	random_pipeline@PLT
	addq	$24, %rsp
	retq
.Lfunc_end5:
	.size	random_pipeline_argv, .Lfunc_end5-random_pipeline_argv
                                        # -- End function
	.section	.text.random_pipeline_metadata,"ax",@progbits
	.globl	random_pipeline_metadata        # -- Begin function random_pipeline_metadata
	.p2align	4, 0x90
	.type	random_pipeline_metadata,@function
random_pipeline_metadata:               # @random_pipeline_metadata
# %bb.0:                                # %entry
	leaq	.Lrandom_pipeline_metadata_storage(%rip), %rax
	retq
.Lfunc_end6:
	.size	random_pipeline_metadata, .Lfunc_end6-random_pipeline_metadata
                                        # -- End function
	.type	.L__unnamed_1,@object           # @0
	.section	.rodata,"a",@progbits
	.p2align	3
.L__unnamed_1:
	.quad	0                               # 0x0
	.size	.L__unnamed_1, 8

	.type	.L__unnamed_2,@object           # @1
	.p2align	3
.L__unnamed_2:
	.quad	2000                            # 0x7d0
	.size	.L__unnamed_2, 8

	.type	.L__unnamed_3,@object           # @2
	.p2align	3
.L__unnamed_3:
	.quad	0                               # 0x0
	.size	.L__unnamed_3, 8

	.type	.L__unnamed_4,@object           # @3
	.p2align	3
.L__unnamed_4:
	.quad	2000                            # 0x7d0
	.size	.L__unnamed_4, 8

	.type	.L__unnamed_5,@object           # @4
	.p2align	3
.L__unnamed_5:
	.quad	0                               # 0x0
	.size	.L__unnamed_5, 8

	.type	.L__unnamed_6,@object           # @5
	.p2align	3
.L__unnamed_6:
	.quad	3                               # 0x3
	.size	.L__unnamed_6, 8

	.type	.L__unnamed_7,@object           # @6
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_7:
	.quad	.L__unnamed_1
	.quad	.L__unnamed_2
	.quad	.L__unnamed_3
	.quad	.L__unnamed_4
	.quad	.L__unnamed_5
	.quad	.L__unnamed_6
	.size	.L__unnamed_7, 48

	.type	.Lstr,@object                   # @str
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr:
	.asciz	"input"
	.size	.Lstr, 6

	.type	.L__unnamed_8,@object           # @7
	.p2align	3
.L__unnamed_8:
	.quad	0                               # 0x0
	.size	.L__unnamed_8, 8

	.type	.L__unnamed_9,@object           # @8
	.p2align	3
.L__unnamed_9:
	.quad	512                             # 0x200
	.size	.L__unnamed_9, 8

	.type	.L__unnamed_10,@object          # @9
	.p2align	3
.L__unnamed_10:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_10, 8

	.type	.L__unnamed_11,@object          # @10
	.p2align	3
.L__unnamed_11:
	.quad	5                               # 0x5
	.size	.L__unnamed_11, 8

	.type	.L__unnamed_12,@object          # @11
	.p2align	3
.L__unnamed_12:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_12, 8

	.type	.L__unnamed_13,@object          # @12
	.p2align	3
.L__unnamed_13:
	.quad	5                               # 0x5
	.size	.L__unnamed_13, 8

	.type	.L__unnamed_14,@object          # @13
	.p2align	3
.L__unnamed_14:
	.quad	0                               # 0x0
	.size	.L__unnamed_14, 8

	.type	.L__unnamed_15,@object          # @14
	.p2align	3
.L__unnamed_15:
	.quad	512                             # 0x200
	.size	.L__unnamed_15, 8

	.type	.L__unnamed_16,@object          # @15
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_16:
	.quad	.L__unnamed_8
	.quad	.L__unnamed_9
	.quad	.L__unnamed_10
	.quad	.L__unnamed_11
	.quad	.L__unnamed_12
	.quad	.L__unnamed_13
	.quad	.L__unnamed_14
	.quad	.L__unnamed_15
	.size	.L__unnamed_16, 64

	.type	.Lstr.4,@object                 # @str.4
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.4:
	.asciz	"uint8_weights"
	.size	.Lstr.4, 14

	.type	.L__unnamed_17,@object          # @16
	.p2align	3
.L__unnamed_17:
	.quad	0                               # 0x0
	.size	.L__unnamed_17, 8

	.type	.L__unnamed_18,@object          # @17
	.p2align	3
.L__unnamed_18:
	.quad	512                             # 0x200
	.size	.L__unnamed_18, 8

	.type	.L__unnamed_19,@object          # @18
	.p2align	3
.L__unnamed_19:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_19, 8

	.type	.L__unnamed_20,@object          # @19
	.p2align	3
.L__unnamed_20:
	.quad	5                               # 0x5
	.size	.L__unnamed_20, 8

	.type	.L__unnamed_21,@object          # @20
	.p2align	3
.L__unnamed_21:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_21, 8

	.type	.L__unnamed_22,@object          # @21
	.p2align	3
.L__unnamed_22:
	.quad	5                               # 0x5
	.size	.L__unnamed_22, 8

	.type	.L__unnamed_23,@object          # @22
	.p2align	3
.L__unnamed_23:
	.quad	0                               # 0x0
	.size	.L__unnamed_23, 8

	.type	.L__unnamed_24,@object          # @23
	.p2align	3
.L__unnamed_24:
	.quad	512                             # 0x200
	.size	.L__unnamed_24, 8

	.type	.L__unnamed_25,@object          # @24
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_25:
	.quad	.L__unnamed_17
	.quad	.L__unnamed_18
	.quad	.L__unnamed_19
	.quad	.L__unnamed_20
	.quad	.L__unnamed_21
	.quad	.L__unnamed_22
	.quad	.L__unnamed_23
	.quad	.L__unnamed_24
	.size	.L__unnamed_25, 64

	.type	.Lstr.5,@object                 # @str.5
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.5:
	.asciz	"uint16_weights"
	.size	.Lstr.5, 15

	.type	.L__unnamed_26,@object          # @25
	.p2align	3
.L__unnamed_26:
	.quad	0                               # 0x0
	.size	.L__unnamed_26, 8

	.type	.L__unnamed_27,@object          # @26
	.p2align	3
.L__unnamed_27:
	.quad	512                             # 0x200
	.size	.L__unnamed_27, 8

	.type	.L__unnamed_28,@object          # @27
	.p2align	3
.L__unnamed_28:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_28, 8

	.type	.L__unnamed_29,@object          # @28
	.p2align	3
.L__unnamed_29:
	.quad	5                               # 0x5
	.size	.L__unnamed_29, 8

	.type	.L__unnamed_30,@object          # @29
	.p2align	3
.L__unnamed_30:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_30, 8

	.type	.L__unnamed_31,@object          # @30
	.p2align	3
.L__unnamed_31:
	.quad	5                               # 0x5
	.size	.L__unnamed_31, 8

	.type	.L__unnamed_32,@object          # @31
	.p2align	3
.L__unnamed_32:
	.quad	0                               # 0x0
	.size	.L__unnamed_32, 8

	.type	.L__unnamed_33,@object          # @32
	.p2align	3
.L__unnamed_33:
	.quad	512                             # 0x200
	.size	.L__unnamed_33, 8

	.type	.L__unnamed_34,@object          # @33
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_34:
	.quad	.L__unnamed_26
	.quad	.L__unnamed_27
	.quad	.L__unnamed_28
	.quad	.L__unnamed_29
	.quad	.L__unnamed_30
	.quad	.L__unnamed_31
	.quad	.L__unnamed_32
	.quad	.L__unnamed_33
	.size	.L__unnamed_34, 64

	.type	.Lstr.6,@object                 # @str.6
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.6:
	.asciz	"uint32_weights"
	.size	.Lstr.6, 15

	.type	.L__unnamed_35,@object          # @34
	.p2align	3
.L__unnamed_35:
	.quad	0                               # 0x0
	.size	.L__unnamed_35, 8

	.type	.L__unnamed_36,@object          # @35
	.p2align	3
.L__unnamed_36:
	.quad	512                             # 0x200
	.size	.L__unnamed_36, 8

	.type	.L__unnamed_37,@object          # @36
	.p2align	3
.L__unnamed_37:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_37, 8

	.type	.L__unnamed_38,@object          # @37
	.p2align	3
.L__unnamed_38:
	.quad	5                               # 0x5
	.size	.L__unnamed_38, 8

	.type	.L__unnamed_39,@object          # @38
	.p2align	3
.L__unnamed_39:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_39, 8

	.type	.L__unnamed_40,@object          # @39
	.p2align	3
.L__unnamed_40:
	.quad	5                               # 0x5
	.size	.L__unnamed_40, 8

	.type	.L__unnamed_41,@object          # @40
	.p2align	3
.L__unnamed_41:
	.quad	0                               # 0x0
	.size	.L__unnamed_41, 8

	.type	.L__unnamed_42,@object          # @41
	.p2align	3
.L__unnamed_42:
	.quad	512                             # 0x200
	.size	.L__unnamed_42, 8

	.type	.L__unnamed_43,@object          # @42
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_43:
	.quad	.L__unnamed_35
	.quad	.L__unnamed_36
	.quad	.L__unnamed_37
	.quad	.L__unnamed_38
	.quad	.L__unnamed_39
	.quad	.L__unnamed_40
	.quad	.L__unnamed_41
	.quad	.L__unnamed_42
	.size	.L__unnamed_43, 64

	.type	.Lstr.7,@object                 # @str.7
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.7:
	.asciz	"int8_weights"
	.size	.Lstr.7, 13

	.type	.L__unnamed_44,@object          # @43
	.p2align	3
.L__unnamed_44:
	.quad	0                               # 0x0
	.size	.L__unnamed_44, 8

	.type	.L__unnamed_45,@object          # @44
	.p2align	3
.L__unnamed_45:
	.quad	512                             # 0x200
	.size	.L__unnamed_45, 8

	.type	.L__unnamed_46,@object          # @45
	.p2align	3
.L__unnamed_46:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_46, 8

	.type	.L__unnamed_47,@object          # @46
	.p2align	3
.L__unnamed_47:
	.quad	5                               # 0x5
	.size	.L__unnamed_47, 8

	.type	.L__unnamed_48,@object          # @47
	.p2align	3
.L__unnamed_48:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_48, 8

	.type	.L__unnamed_49,@object          # @48
	.p2align	3
.L__unnamed_49:
	.quad	5                               # 0x5
	.size	.L__unnamed_49, 8

	.type	.L__unnamed_50,@object          # @49
	.p2align	3
.L__unnamed_50:
	.quad	0                               # 0x0
	.size	.L__unnamed_50, 8

	.type	.L__unnamed_51,@object          # @50
	.p2align	3
.L__unnamed_51:
	.quad	512                             # 0x200
	.size	.L__unnamed_51, 8

	.type	.L__unnamed_52,@object          # @51
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_52:
	.quad	.L__unnamed_44
	.quad	.L__unnamed_45
	.quad	.L__unnamed_46
	.quad	.L__unnamed_47
	.quad	.L__unnamed_48
	.quad	.L__unnamed_49
	.quad	.L__unnamed_50
	.quad	.L__unnamed_51
	.size	.L__unnamed_52, 64

	.type	.Lstr.8,@object                 # @str.8
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.8:
	.asciz	"int16_weights"
	.size	.Lstr.8, 14

	.type	.L__unnamed_53,@object          # @52
	.p2align	3
.L__unnamed_53:
	.quad	0                               # 0x0
	.size	.L__unnamed_53, 8

	.type	.L__unnamed_54,@object          # @53
	.p2align	3
.L__unnamed_54:
	.quad	512                             # 0x200
	.size	.L__unnamed_54, 8

	.type	.L__unnamed_55,@object          # @54
	.p2align	3
.L__unnamed_55:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_55, 8

	.type	.L__unnamed_56,@object          # @55
	.p2align	3
.L__unnamed_56:
	.quad	5                               # 0x5
	.size	.L__unnamed_56, 8

	.type	.L__unnamed_57,@object          # @56
	.p2align	3
.L__unnamed_57:
	.quad	-5                              # 0xfffffffffffffffb
	.size	.L__unnamed_57, 8

	.type	.L__unnamed_58,@object          # @57
	.p2align	3
.L__unnamed_58:
	.quad	5                               # 0x5
	.size	.L__unnamed_58, 8

	.type	.L__unnamed_59,@object          # @58
	.p2align	3
.L__unnamed_59:
	.quad	0                               # 0x0
	.size	.L__unnamed_59, 8

	.type	.L__unnamed_60,@object          # @59
	.p2align	3
.L__unnamed_60:
	.quad	512                             # 0x200
	.size	.L__unnamed_60, 8

	.type	.L__unnamed_61,@object          # @60
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_61:
	.quad	.L__unnamed_53
	.quad	.L__unnamed_54
	.quad	.L__unnamed_55
	.quad	.L__unnamed_56
	.quad	.L__unnamed_57
	.quad	.L__unnamed_58
	.quad	.L__unnamed_59
	.quad	.L__unnamed_60
	.size	.L__unnamed_61, 64

	.type	.Lstr.9,@object                 # @str.9
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.9:
	.asciz	"int32_weights"
	.size	.Lstr.9, 14

	.type	.L__unnamed_62,@object          # @61
	.p2align	3
.L__unnamed_62:
	.quad	0                               # 0x0
	.size	.L__unnamed_62, 8

	.type	.L__unnamed_63,@object          # @62
	.p2align	3
.L__unnamed_63:
	.quad	2000                            # 0x7d0
	.size	.L__unnamed_63, 8

	.type	.L__unnamed_64,@object          # @63
	.p2align	3
.L__unnamed_64:
	.quad	0                               # 0x0
	.size	.L__unnamed_64, 8

	.type	.L__unnamed_65,@object          # @64
	.p2align	3
.L__unnamed_65:
	.quad	2000                            # 0x7d0
	.size	.L__unnamed_65, 8

	.type	.L__unnamed_66,@object          # @65
	.p2align	3
.L__unnamed_66:
	.quad	0                               # 0x0
	.size	.L__unnamed_66, 8

	.type	.L__unnamed_67,@object          # @66
	.p2align	3
.L__unnamed_67:
	.quad	3                               # 0x3
	.size	.L__unnamed_67, 8

	.type	.L__unnamed_68,@object          # @67
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_68:
	.quad	.L__unnamed_62
	.quad	.L__unnamed_63
	.quad	.L__unnamed_64
	.quad	.L__unnamed_65
	.quad	.L__unnamed_66
	.quad	.L__unnamed_67
	.size	.L__unnamed_68, 48

	.type	.Lstr.10,@object                # @str.10
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.10:
	.asciz	"output"
	.size	.Lstr.10, 7

	.type	.L__unnamed_69,@object          # @68
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.L__unnamed_69:
	.quad	.Lstr
	.long	1                               # 0x1
	.long	3                               # 0x3
	.byte	0                               # 0x0
	.byte	32                              # 0x20
	.short	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_7
	.quad	.Lstr.4
	.long	1                               # 0x1
	.long	4                               # 0x4
	.byte	1                               # 0x1
	.byte	8                               # 0x8
	.short	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_16
	.quad	.Lstr.5
	.long	1                               # 0x1
	.long	4                               # 0x4
	.byte	1                               # 0x1
	.byte	16                              # 0x10
	.short	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_25
	.quad	.Lstr.6
	.long	1                               # 0x1
	.long	4                               # 0x4
	.byte	1                               # 0x1
	.byte	32                              # 0x20
	.short	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_34
	.quad	.Lstr.7
	.long	1                               # 0x1
	.long	4                               # 0x4
	.byte	0                               # 0x0
	.byte	8                               # 0x8
	.short	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_43
	.quad	.Lstr.8
	.long	1                               # 0x1
	.long	4                               # 0x4
	.byte	0                               # 0x0
	.byte	16                              # 0x10
	.short	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_52
	.quad	.Lstr.9
	.long	1                               # 0x1
	.long	4                               # 0x4
	.byte	0                               # 0x0
	.byte	32                              # 0x20
	.short	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_61
	.quad	.Lstr.10
	.long	2                               # 0x2
	.long	3                               # 0x3
	.byte	0                               # 0x0
	.byte	32                              # 0x20
	.short	1                               # 0x1
	.zero	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	.L__unnamed_68
	.size	.L__unnamed_69, 512

	.type	.Lstr.11,@object                # @str.11
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.11:
	.asciz	"x86-64-linux-avx-avx2-f16c-fma-no_runtime-sse41"
	.size	.Lstr.11, 48

	.type	.Lstr.12,@object                # @str.12
	.p2align	5
.Lstr.12:
	.asciz	"random_pipeline"
	.size	.Lstr.12, 16

	.type	.Lrandom_pipeline_metadata_storage,@object # @random_pipeline_metadata_storage
	.section	.data.rel.ro,"aw",@progbits
	.p2align	4
.Lrandom_pipeline_metadata_storage:
	.long	1                               # 0x1
	.long	8                               # 0x8
	.quad	.L__unnamed_69
	.quad	.Lstr.11
	.quad	.Lstr.12
	.size	.Lrandom_pipeline_metadata_storage, 32

	.type	.Lstr.13,@object                # @str.13
	.section	.rodata,"a",@progbits
	.p2align	5
.Lstr.13:
	.asciz	"constant_exterior"
	.size	.Lstr.13, 18

	.type	.Lstr.14,@object                # @str.14
	.p2align	5
.Lstr.14:
	.asciz	"sum"
	.size	.Lstr.14, 4

	.type	.Lstr.15,@object                # @str.15
	.p2align	5
.Lstr.15:
	.asciz	"all_r"
	.size	.Lstr.15, 6

	.type	.Lstr.16,@object                # @str.16
	.p2align	5
.Lstr.16:
	.asciz	"conv__0"
	.size	.Lstr.16, 8

	.type	.Lstr.17,@object                # @str.17
	.p2align	5
.Lstr.17:
	.asciz	"upsampled_linear__0"
	.size	.Lstr.17, 20

	.type	.Lstr.18,@object                # @str.18
	.p2align	5
.Lstr.18:
	.asciz	"all_r$1"
	.size	.Lstr.18, 8

	.type	.Lstr.19,@object                # @str.19
	.p2align	5
.Lstr.19:
	.asciz	"sum$1"
	.size	.Lstr.19, 6

	.type	.Lstr.20,@object                # @str.20
	.p2align	5
.Lstr.20:
	.asciz	"conv2D_w__0_1"
	.size	.Lstr.20, 14

	.type	.Lstr.21,@object                # @str.21
	.p2align	5
.Lstr.21:
	.asciz	"relu"
	.size	.Lstr.21, 5

	.type	.Lstr.22,@object                # @str.22
	.p2align	5
.Lstr.22:
	.asciz	"all_r$3"
	.size	.Lstr.22, 8

	.type	.Lstr.23,@object                # @str.23
	.p2align	5
.Lstr.23:
	.asciz	"casted"
	.size	.Lstr.23, 7

	.type	.Lstr.24,@object                # @str.24
	.p2align	5
.Lstr.24:
	.asciz	"Output buffer casted"
	.size	.Lstr.24, 21

	.type	.Lstr.25,@object                # @str.25
	.p2align	5
.Lstr.25:
	.asciz	"Input buffer input"
	.size	.Lstr.25, 19

	.type	.Lstr.26,@object                # @str.26
	.p2align	5
.Lstr.26:
	.asciz	"Input buffer int32_weights"
	.size	.Lstr.26, 27

	.type	.Lstr.27,@object                # @str.27
	.p2align	5
.Lstr.27:
	.asciz	"casted.stride.0"
	.size	.Lstr.27, 16

	.type	.Lstr.28,@object                # @str.28
	.p2align	5
.Lstr.28:
	.asciz	"1"
	.size	.Lstr.28, 2

	.type	.Lstr.29,@object                # @str.29
	.p2align	5
.Lstr.29:
	.asciz	"input.stride.0"
	.size	.Lstr.29, 15

	.type	.Lstr.30,@object                # @str.30
	.p2align	5
.Lstr.30:
	.asciz	"int32_weights.stride.0"
	.size	.Lstr.30, 23

	.type	.Lstr.31,@object                # @str.31
	.p2align	5
.Lstr.31:
	.asciz	"sum$3"
	.size	.Lstr.31, 6

	.ident	"clang version 14.0.6 (https://github.com/chamikasudusinghe/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)"
	.ident	"clang version 14.0.6 (https://github.com/chamikasudusinghe/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)"
	.ident	"clang version 14.0.6 (https://github.com/chamikasudusinghe/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)"
	.ident	"clang version 14.0.6 (https://github.com/chamikasudusinghe/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)"
	.ident	"clang version 14.0.6 (https://github.com/chamikasudusinghe/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)"
	.ident	"clang version 14.0.6 (https://github.com/chamikasudusinghe/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)"
	.section	".note.GNU-stack","",@progbits
